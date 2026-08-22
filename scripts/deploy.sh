#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd -P)"
SOURCE_DIR="$ROOT_DIR/skills"
USER_DIR="${HOME:?HOME must be set}"

SHARED_ROOT_OVERRIDE="${AGENT_SKILLS_SHARED_ROOT:-}"
if [[ -n "$SHARED_ROOT_OVERRIDE" ]]; then
  CLINE_ROOT="${AGENT_SKILLS_CLINE_ROOT:-$SHARED_ROOT_OVERRIDE}"
  CODEX_ROOT="${AGENT_SKILLS_CODEX_ROOT:-$SHARED_ROOT_OVERRIDE}"
else
  CLINE_ROOT="${AGENT_SKILLS_CLINE_ROOT:-$USER_DIR/.agents/skills}"
  CODEX_ROOT="${AGENT_SKILLS_CODEX_ROOT:-$USER_DIR/.codex/skills}"
fi
OPENCLAW_ROOT="${AGENT_SKILLS_OPENCLAW_ROOT:-$USER_DIR/.openclaw/skills}"

DRY_RUN=false
FORCE=false

usage() {
  cat <<'USAGE'
Usage:
  scripts/deploy.sh [--dry-run] [--force] \
    [--cline-root DIR] [--codex-root DIR] [--openclaw-root DIR]

This is a maintainer local-development helper; npx skills is the recommended
installation path for ordinary users. The default operation copies all managed
Skills. --dry-run previews changes. --force allows taking over an existing
same-named directory without the managed marker. The native/default destinations
are ~/.codex/skills for Codex, ~/.agents/skills for Cline, and
~/.openclaw/skills for OpenClaw. Current npx skills behavior may use
~/.agents/skills as a shared Codex/Cline canonical root; use npx skills ls -g to
inspect that CLI-managed destination. Use the root flags or
AGENT_SKILLS_*_ROOT environment variables to test isolated destinations.
AGENT_SKILLS_SHARED_ROOT remains an explicit shared-layout compatibility override
and applies to both Codex and Cline unless their specific root override is set.
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

PYTHON_BIN="${AGENT_SKILLS_PYTHON:-$ROOT_DIR/.venv/bin/python3}"
if [[ ! -x "$PYTHON_BIN" ]]; then
  PYTHON_BIN="python3"
fi
if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  printf 'ERROR: Python executable not found: %s\n' "$PYTHON_BIN" >&2
  exit 1
fi

published_output="$("$PYTHON_BIN" "$ROOT_DIR/scripts/skill-set.py" --mode published)"
SKILLS=()
while IFS= read -r skill; do
  [[ -n "$skill" ]] && SKILLS+=("$skill")
done <<< "$published_output"
if (( ${#SKILLS[@]} == 0 )); then
  printf 'ERROR: no published Skills found in skills/registry.yaml.\n' >&2
  exit 1
fi

if ! command -v rsync >/dev/null 2>&1; then
  printf 'ERROR: rsync is required for safe managed copies.\n' >&2
  exit 1
fi

canonical_root="$(CDPATH='' cd -- "$ROOT_DIR" && pwd -P)"
targets=()
for candidate in "$CLINE_ROOT" "$CODEX_ROOT" "$OPENCLAW_ROOT"; do
  duplicate=false
  if ((${#targets[@]} > 0)); then
    for existing in "${targets[@]}"; do
      if [[ "$existing" == "$candidate" ]]; then
        duplicate=true
        break
      fi
    done
  fi
  if [[ "$duplicate" != true ]]; then
    targets+=("$candidate")
  fi
done

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
if [[ "$DRY_RUN" == true ]]; then
  printf 'PLANNED_SKILLS=%s\n' "$(printf '%s\n' "${SKILLS[@]}" | paste -sd, -)"
else
  printf 'DEPLOYED_SKILLS=%s\n' "$(printf '%s\n' "${SKILLS[@]}" | paste -sd, -)"
fi
