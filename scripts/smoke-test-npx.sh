#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd -P)"
SKILLS=(
  engineering-philosophy
  requirement-engineering
  change-planning
  architecture-boundaries
  ddd-lite
  incremental-implementation
  test-driven-development
  systematic-debugging
  code-review-and-quality
  git-workflow-and-versioning
  ci-cd-and-automation
)

if ! command -v npx >/dev/null 2>&1; then
  printf 'ERROR: npx is required for the installation smoke test.\n' >&2
  exit 1
fi

owned_home=false
owned_cache=false
if [[ -n "${AGENT_SKILLS_SMOKE_HOME:-}" ]]; then
  SMOKE_HOME="$AGENT_SKILLS_SMOKE_HOME"
else
  SMOKE_HOME="$(mktemp -d "${TMPDIR:-/tmp}/agent-skills-smoke-home.XXXXXX")"
  owned_home=true
fi
if [[ -n "${AGENT_SKILLS_SMOKE_NPM_CACHE:-}" ]]; then
  NPM_CACHE="$AGENT_SKILLS_SMOKE_NPM_CACHE"
else
  NPM_CACHE="$(mktemp -d "${TMPDIR:-/tmp}/agent-skills-smoke-cache.XXXXXX")"
  owned_cache=true
fi

cleanup() {
  if [[ "$owned_home" == true ]]; then
    rm -rf -- "$SMOKE_HOME"
  fi
  if [[ "$owned_cache" == true ]]; then
    rm -rf -- "$NPM_CACHE"
  fi
}
trap cleanup EXIT

mkdir -p "$SMOKE_HOME" "$NPM_CACHE"

npx_env=(
  HOME="$SMOKE_HOME"
  CODEX_HOME="$SMOKE_HOME/.codex"
  NPM_CONFIG_CACHE="$NPM_CACHE"
  DISABLE_TELEMETRY=1
  DO_NOT_TRACK=1
  CI=1
  TERM=dumb
)

list_output="$(env "${npx_env[@]}" npx --yes skills@latest add "$ROOT_DIR" --list 2>&1)"
for skill in "${SKILLS[@]}"; do
  if ! grep -Fq -- "$skill" <<<"$list_output"; then
    printf 'ERROR: npx skills did not discover %s.\n' "$skill" >&2
    printf '%s\n' "$list_output" >&2
    exit 1
  fi
done

env "${npx_env[@]}" npx --yes skills@latest add "$ROOT_DIR" \
  --skill '*' \
  --global \
  --agent codex \
  --agent cline \
  --copy \
  --yes

installed_root="$SMOKE_HOME/.agents/skills"
if [[ ! -d "$installed_root" ]]; then
  printf 'ERROR: expected shared Codex/Cline directory is missing: %s\n' "$installed_root" >&2
  exit 1
fi

installed_count="$(find "$installed_root" -mindepth 1 -maxdepth 1 -type d -print | wc -l | tr -d ' ')"
if [[ "$installed_count" != "${#SKILLS[@]}" ]]; then
  printf 'ERROR: expected %d installed Skills, found %s.\n' "${#SKILLS[@]}" "$installed_count" >&2
  exit 1
fi

for skill in "${SKILLS[@]}"; do
  [[ -f "$installed_root/$skill/SKILL.md" ]] || {
    printf 'ERROR: installed Skill is missing SKILL.md: %s\n' "$skill" >&2
    exit 1
  }
done

for old_skill in spec-driven-development planning-and-task-breakdown; do
  if [[ -e "$installed_root/$old_skill" ]]; then
    printf 'ERROR: stale renamed Skill was installed: %s\n' "$old_skill" >&2
    exit 1
  fi
done

printf 'npx skills discovery and installation smoke test passed: %d Skills -> %s\n' \
  "${#SKILLS[@]}" "$installed_root"
