#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P)"
PYTHON_BIN="${AGENT_SKILLS_PYTHON:-$ROOT_DIR/.venv/bin/python3}"
if [[ ! -x "$PYTHON_BIN" ]]; then
  PYTHON_BIN="python3"
fi
QUICK_VALIDATOR="${AGENT_SKILLS_VALIDATOR:-}"

DEFAULT_QUICK_VALIDATOR="${HOME:?HOME must be set}/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
if [[ -z "$QUICK_VALIDATOR" && -f "$DEFAULT_QUICK_VALIDATOR" ]]; then
  QUICK_VALIDATOR="$DEFAULT_QUICK_VALIDATOR"
fi

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

failures=0

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  failures=$((failures + 1))
}

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  fail "Python executable not found: $PYTHON_BIN"
fi

for skill in "${SKILLS[@]}"; do
  skill_dir="$ROOT_DIR/skills/$skill"
  skill_md="$skill_dir/SKILL.md"
  metadata="$skill_dir/agents/openai.yaml"
  eval_dir="$ROOT_DIR/evals/$skill"

  [[ -d "$skill_dir" ]] || { fail "missing skill directory: $skill"; continue; }
  [[ -f "$skill_md" ]] || fail "$skill is missing SKILL.md"
  [[ -f "$metadata" ]] || fail "$skill is missing agents/openai.yaml"
  [[ -f "$eval_dir/cases.md" ]] || fail "$skill is missing evals/$skill/cases.md"
  [[ -f "$eval_dir/expected.md" ]] || fail "$skill is missing evals/$skill/expected.md"

  if [[ -f "$skill_md" ]]; then
    first_line="$(sed -n '1p' "$skill_md")"
    [[ "$first_line" == "---" ]] || fail "$skill SKILL.md has no YAML frontmatter"
    grep -q "^name: $skill$" "$skill_md" || fail "$skill frontmatter name does not match directory"
    grep -q "^description: " "$skill_md" || fail "$skill has no description"
    grep -q "\\[TODO:" "$skill_md" && fail "$skill contains an unfinished TODO"
  fi

  if [[ -f "$metadata" ]]; then
    grep -q "^  display_name: " "$metadata" || fail "$skill metadata has no display_name"
    grep -q "^  short_description: " "$metadata" || fail "$skill metadata has no short_description"
    grep -q "^  default_prompt: " "$metadata" || fail "$skill metadata has no default_prompt"
    grep -Fq "\$$skill" "$metadata" || fail "$skill default_prompt does not mention \$$skill"
    grep -q "^  allow_implicit_invocation: true$" "$metadata" || fail "$skill does not allow implicit invocation"
  fi

  if [[ -n "$QUICK_VALIDATOR" && -f "$QUICK_VALIDATOR" && -f "$skill_md" ]]; then
    if "$PYTHON_BIN" -c 'import yaml' >/dev/null 2>&1; then
      if ! "$PYTHON_BIN" "$QUICK_VALIDATOR" "$skill_dir"; then
        fail "skill-creator validator rejected $skill"
      fi
    else
      printf 'WARN: skipping skill-creator validator because PyYAML is unavailable.\n' >&2
      QUICK_VALIDATOR=""
    fi
  fi
done

if command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  if ! "$PYTHON_BIN" - "$ROOT_DIR" <<'PY'
import re
import sys
from pathlib import Path

root = Path(sys.argv[1])
skills = [
    "engineering-philosophy",
    "architecture-boundaries",
    "ddd-lite",
    "test-driven-development",
    "systematic-debugging",
    "spec-driven-development",
    "planning-and-task-breakdown",
    "incremental-implementation",
    "code-review-and-quality",
    "git-workflow-and-versioning",
    "ci-cd-and-automation",
]

minimum_cases = {
    "engineering-philosophy": 8,
    "architecture-boundaries": 8,
    "ddd-lite": 8,
    "test-driven-development": 8,
    "systematic-debugging": 8,
}

errors = []

def headings(path):
    text = path.read_text(encoding="utf-8")
    return re.findall(r"^##\s+([A-Z]+-\d+)\b", text, flags=re.MULTILINE)

for skill in skills:
    skill_dir = root / "skills" / skill
    skill_md = skill_dir / "SKILL.md"
    eval_dir = root / "evals" / skill
    cases = eval_dir / "cases.md"
    expected = eval_dir / "expected.md"

    if skill_md.exists():
        body = skill_md.read_text(encoding="utf-8")
        for match in re.findall(r"\[[^\]]+\]\(([^)]+)\)", body):
            if "://" not in match and not (skill_dir / match).resolve().exists():
                errors.append(f"{skill}: broken reference link {match}")

    if cases.exists() and expected.exists():
        case_ids = headings(cases)
        expected_ids = headings(expected)
        if len(case_ids) != len(set(case_ids)):
            errors.append(f"{skill}: duplicate case ID in cases.md")
        if len(expected_ids) != len(set(expected_ids)):
            errors.append(f"{skill}: duplicate case ID in expected.md")
        if set(case_ids) != set(expected_ids):
            errors.append(f"{skill}: cases.md and expected.md IDs differ")
        if len(case_ids) < minimum_cases.get(skill, 5):
            errors.append(f"{skill}: expected at least {minimum_cases.get(skill, 5)} eval cases, found {len(case_ids)}")

for error in errors:
    print(f"ERROR: {error}", file=sys.stderr)
sys.exit(1 if errors else 0)
PY
  then
    failures=$((failures + 1))
  fi
fi

if (( failures > 0 )); then
  printf 'Validation failed with %d issue(s).\n' "$failures" >&2
  exit 1
fi

printf 'Validated %d Skill(s), metadata files, references, and eval suites.\n' "${#SKILLS[@]}"
