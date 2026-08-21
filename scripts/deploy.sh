#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P)"
SOURCE_DIR="$ROOT_DIR/skills"
USER_DIR="${HOME:?HOME must be set}"

CLINE_ROOT="${AGENT_SKILLS_CLINE_ROOT:-$USER_DIR/.agents/skills}"
CODEX_ROOT="${AGENT_SKILLS_CODEX_ROOT:-$USER_DIR/.codex/skills}"
OPENCLAW_ROOT="${AGENT_SKILLS_OPENCLAW_ROOT:-$USER_DIR/.openclaw/skills}"

DRY_RUN=false
FORCE=false

SKILLS=(
  engineering-philosophy
  architecture-boundaries
  ddd-lite
  test-driven-development
  systematic-debugging
  spec-driven-development
  planning-and-task-breakdown
  incremental-implementation
  code-review-and-quality
  git-workflow-and-versioning
  ci-cd-and-automation
)

usage() {
  cat <<'USAGE'
Usage:
  scripts/deploy.sh [--dry-run] [--force] \
    [--cline-root DIR] [--codex-root DIR] [--openclaw-root DIR]

The default operation copies all managed Skills. --dry-run previews changes.
--force allows taking over an existing same-named directory without the
managed marker. The default roots follow the npx skills agent locations;
use the root flags or AGENT_SKILLS_*_ROOT environment variables to preserve
an existing personal layout.
USAGE
}

while (($# > 0)); do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --force)
      FORCE=true
      shift
      ;;
    --cline-root)
      (($# >= 2)) || { usage >&2; exit 2; }
      CLINE_ROOT="$2"
      shift 2
      ;;
    --codex-root)
      (($# >= 2)) || { usage >&2; exit 2; }
      CODEX_ROOT="$2"
      shift 2
      ;;
    --openclaw-root)
      (($# >= 2)) || { usage >&2; exit 2; }
      OPENCLAW_ROOT="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

"$ROOT_DIR/scripts/validate.sh"

if ! command -v rsync >/dev/null 2>&1; then
  printf 'ERROR: rsync is required for safe managed copies.\n' >&2
  exit 1
fi

canonical_root="$(CDPATH= cd -- "$ROOT_DIR" && pwd -P)"
targets=("$CLINE_ROOT" "$CODEX_ROOT" "$OPENCLAW_ROOT")

for target in "${targets[@]}"; do
  case "$target" in
    /*) ;;
    *)
      printf 'ERROR: deployment roots must be absolute paths: %s\n' "$target" >&2
      exit 1
      ;;
  esac
  case "$target/" in
    "$canonical_root/"*)
      printf 'ERROR: refusing to deploy into the source repository: %s\n' "$target" >&2
      exit 1
      ;;
  esac
done

stage_dir="$(mktemp -d "${TMPDIR:-/tmp}/agent-skills-deploy.XXXXXX")"
trap 'rm -rf "$stage_dir"' EXIT

if [[ "$DRY_RUN" != true ]]; then
  for target_root in "${targets[@]}"; do
    for skill in "${SKILLS[@]}"; do
      destination="$target_root/$skill"
      if [[ -e "$destination" && ! -d "$destination" ]]; then
        printf 'ERROR: deployment target is not a directory: %s\n' "$destination" >&2
        exit 1
      fi
      if [[ -e "$destination" && ! -f "$destination/.agent-skills-managed" && "$FORCE" != true ]]; then
        printf 'ERROR: refusing to take over unmanaged directory: %s\n' "$destination" >&2
        printf '       Re-run with --force only after reviewing that exact directory.\n' >&2
        exit 1
      fi
    done
  done
fi

for skill in "${SKILLS[@]}"; do
  rsync -a -- "$SOURCE_DIR/$skill/" "$stage_dir/$skill/"
  printf '%s\n' 'managed-by: agent-skills' > "$stage_dir/$skill/.agent-skills-managed"
done

for target_root in "${targets[@]}"; do
  if [[ "$DRY_RUN" == true ]]; then
    printf '[dry-run] would create or update %s\n' "$target_root"
    for skill in "${SKILLS[@]}"; do
      printf '[dry-run]   %s/%s\n' "$target_root" "$skill"
    done
    continue
  fi

  mkdir -p "$target_root"
  for skill in "${SKILLS[@]}"; do
    destination="$target_root/$skill"
    if [[ -e "$destination" && ! -d "$destination" ]]; then
      printf 'ERROR: deployment target is not a directory: %s\n' "$destination" >&2
      exit 1
    fi
    if [[ -e "$destination" && ! -f "$destination/.agent-skills-managed" && "$FORCE" != true ]]; then
      printf 'ERROR: refusing to take over unmanaged directory: %s\n' "$destination" >&2
      printf '       Re-run with --force only after reviewing that exact directory.\n' >&2
      exit 1
    fi

    mkdir -p "$destination"
    rsync -a --delete \
      --exclude '.agent-skills-managed' \
      -- "$stage_dir/$skill/" "$destination/"
    cp "$stage_dir/$skill/.agent-skills-managed" "$destination/.agent-skills-managed"
    printf 'deployed %s -> %s\n' "$skill" "$destination"
  done
done
