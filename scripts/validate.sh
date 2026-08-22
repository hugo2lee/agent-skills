#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd -P)"
PYTHON_BIN="${AGENT_SKILLS_PYTHON:-$ROOT_DIR/.venv/bin/python3}"
if [[ ! -x "$PYTHON_BIN" ]]; then
  PYTHON_BIN="python3"
fi

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

failures=0

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  failures=$((failures + 1))
}

VERSION_FILE="$ROOT_DIR/VERSION"
VERSION=""
if [[ -f "$VERSION_FILE" ]]; then
  VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"
else
  fail "missing root VERSION file"
fi
if [[ -n "$VERSION" && ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  fail "VERSION must contain a plain MAJOR.MINOR.PATCH value: $VERSION"
fi

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  fail "Python executable not found: $PYTHON_BIN"
fi

# The Agent Skills specification recommends skills-ref for standards-level
# frontmatter validation. Repository-specific checks below remain necessary
# because skills-ref does not know our routing/eval/version conventions.
STANDARDS_VALIDATOR="${AGENT_SKILLS_STANDARDS_VALIDATOR:-}"
if [[ -z "$STANDARDS_VALIDATOR" && -x "$ROOT_DIR/.venv/bin/skills-ref" ]]; then
  STANDARDS_VALIDATOR="$ROOT_DIR/.venv/bin/skills-ref"
fi
if [[ -z "$STANDARDS_VALIDATOR" && -x "$ROOT_DIR/.venv/bin/agentskills" ]]; then
  STANDARDS_VALIDATOR="$ROOT_DIR/.venv/bin/agentskills"
fi
if [[ -z "$STANDARDS_VALIDATOR" ]] && command -v skills-ref >/dev/null 2>&1; then
  STANDARDS_VALIDATOR="$(command -v skills-ref)"
fi
if [[ -z "$STANDARDS_VALIDATOR" ]] && command -v agentskills >/dev/null 2>&1; then
  STANDARDS_VALIDATOR="$(command -v agentskills)"
fi
if [[ -z "$STANDARDS_VALIDATOR" ]]; then
  fail "skills-ref/agentskills is required; install the Agent Skills reference validator or set AGENT_SKILLS_STANDARDS_VALIDATOR"
fi

# The bundled skill-creator validator is useful as a supplemental compatibility
# check, but it is intentionally no longer the primary standards validator.
LEGACY_QUICK_VALIDATOR="${AGENT_SKILLS_QUICK_VALIDATOR:-${AGENT_SKILLS_VALIDATOR:-}}"
DEFAULT_QUICK_VALIDATOR="${HOME:?HOME must be set}/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
if [[ -z "$LEGACY_QUICK_VALIDATOR" && -f "$DEFAULT_QUICK_VALIDATOR" ]]; then
  LEGACY_QUICK_VALIDATOR="$DEFAULT_QUICK_VALIDATOR"
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
    grep -q "\[TODO:" "$skill_md" && fail "$skill contains an unfinished TODO"
  fi

  if [[ -f "$metadata" ]]; then
    grep -q "^  display_name: " "$metadata" || fail "$skill metadata has no display_name"
    grep -q "^  short_description: " "$metadata" || fail "$skill metadata has no short_description"
    grep -q "^  default_prompt: " "$metadata" || fail "$skill metadata has no default_prompt"
    grep -Fq "\$$skill" "$metadata" || fail "$skill default_prompt does not mention \$$skill"
    expected_policy="true"
    [[ "$skill" == "engineering-philosophy" ]] && expected_policy="false"
    grep -q "^  allow_implicit_invocation: $expected_policy$" "$metadata" || \
      fail "$skill invocation policy must allow_implicit_invocation: $expected_policy"
  fi

  if [[ -n "$STANDARDS_VALIDATOR" && -f "$skill_md" ]]; then
    if ! "$STANDARDS_VALIDATOR" validate "$skill_dir"; then
      fail "skills-ref rejected $skill"
    fi
  fi

  if [[ -n "$LEGACY_QUICK_VALIDATOR" && -f "$LEGACY_QUICK_VALIDATOR" && -f "$skill_md" ]]; then
    if "$PYTHON_BIN" -c 'import yaml' >/dev/null 2>&1; then
      if ! "$PYTHON_BIN" "$LEGACY_QUICK_VALIDATOR" "$skill_dir"; then
        fail "supplemental skill-creator validator rejected $skill"
      fi
    else
      printf 'WARN: skipping supplemental skill-creator validator because PyYAML is unavailable.\n' >&2
    fi
  fi
done

if command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  if ! "$PYTHON_BIN" - "$ROOT_DIR" "$VERSION" "${SKILLS[@]}" <<'PY'
import os
import re
import sys
from pathlib import Path
from urllib.parse import unquote

try:
    import yaml
except ImportError as exc:
    print(f"ERROR: PyYAML is required for repository-specific validation: {exc}", file=sys.stderr)
    sys.exit(1)

root = Path(sys.argv[1])
expected_version = sys.argv[2]
skills = sys.argv[3:]
skill_names = set(skills)
errors = []


def frontmatter(path):
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines()
    if len(lines) < 3 or lines[0].strip() != "---":
        errors.append(f"{path}: missing YAML frontmatter")
        return {}
    try:
        end = lines.index("---", 1)
    except ValueError:
        errors.append(f"{path}: frontmatter is not closed")
        return {}
    try:
        return yaml.safe_load("\n".join(lines[1:end])) or {}
    except yaml.YAMLError as exc:
        errors.append(f"{path}: invalid YAML frontmatter: {exc}")
        return {}


def headings(path):
    text = path.read_text(encoding="utf-8")
    return re.findall(r"^##\s+([A-Z]+-\d+)\b", text, flags=re.MULTILINE)


def check_links(skill_dir):
    link_pattern = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
    for markdown in skill_dir.rglob("*.md"):
        text = markdown.read_text(encoding="utf-8")
        for raw_target in link_pattern.findall(text):
            target = raw_target.strip().split("#", 1)[0].strip()
            if not target or target.startswith(("http://", "https://", "mailto:")):
                continue
            target_path = (markdown.parent / unquote(target)).resolve()
            if not target_path.exists():
                errors.append(f"{markdown.relative_to(root)}: broken reference link {raw_target}")


def validate_skill_list(values, case_id, field):
    if not isinstance(values, list) or not all(isinstance(value, str) for value in values):
        errors.append(f"{case_id}: {field} must be a list of Skill names")
        return
    unknown = [value for value in values if value not in skill_names]
    if unknown:
        errors.append(f"{case_id}: {field} contains unknown Skills {unknown}")


skill_dirs = root / "skills"
discovered = sorted(path.parent.name for path in skill_dirs.glob("*/SKILL.md"))
if discovered != sorted(skills):
    errors.append(f"skills/: expected exactly {len(skills)} top-level Skills, found {discovered}")
if len(discovered) != len(set(discovered)):
    errors.append("skills/: duplicate Skill directory names detected")

old_skill_names = {"spec-driven-development", "planning-and-task-breakdown"}
for old_name in old_skill_names:
    if (skill_dirs / old_name).exists():
        errors.append(f"skills/: stale renamed Skill directory remains: {old_name}")
    if (root / "evals" / old_name).exists():
        errors.append(f"evals/: stale renamed eval directory remains: {old_name}")

minimum_cases = {
    "engineering-philosophy": 8,
    "architecture-boundaries": 8,
    "ddd-lite": 8,
    "test-driven-development": 8,
    "systematic-debugging": 8,
    "requirement-engineering": 8,
    "change-planning": 8,
}
global_eval_ids = {}

for skill in skills:
    skill_dir = root / "skills" / skill
    skill_md = skill_dir / "SKILL.md"
    metadata_path = skill_dir / "agents" / "openai.yaml"
    eval_dir = root / "evals" / skill

    if skill_md.exists():
        properties = frontmatter(skill_md)
        if properties.get("name") != skill:
            errors.append(f"{skill}: frontmatter name does not match directory")
        description = properties.get("description")
        if not isinstance(description, str) or not description.strip():
            errors.append(f"{skill}: description is empty")
        elif len(description) > 1024:
            errors.append(f"{skill}: description exceeds 1024 characters")
        metadata = properties.get("metadata")
        if not isinstance(metadata, dict) or str(metadata.get("version")) != expected_version:
            errors.append(f"{skill}: metadata.version must be {expected_version}")
        check_links(skill_dir)

    if metadata_path.exists():
        try:
            metadata = yaml.safe_load(metadata_path.read_text(encoding="utf-8")) or {}
        except yaml.YAMLError as exc:
            errors.append(f"{metadata_path.relative_to(root)}: invalid YAML: {exc}")
            metadata = {}
        interface = metadata.get("interface", {})
        policy = metadata.get("policy", {})
        if not isinstance(interface, dict):
            errors.append(f"{skill}: agents/openai.yaml interface must be a mapping")
        else:
            for field in ("display_name", "short_description", "default_prompt"):
                if not isinstance(interface.get(field), str) or not interface[field].strip():
                    errors.append(f"{skill}: metadata interface.{field} is missing")
            short_description = interface.get("short_description", "")
            if not 25 <= len(short_description) <= 64:
                errors.append(f"{skill}: short_description must be 25-64 characters")
            if "$" + skill not in interface.get("default_prompt", ""):
                errors.append(f"{skill}: default_prompt must mention " + "$" + skill)
        expected_policy = skill != "engineering-philosophy"
        if not isinstance(policy, dict) or policy.get("allow_implicit_invocation") is not expected_policy:
            errors.append(f"{skill}: allow_implicit_invocation must be {str(expected_policy).lower()}")

    cases = eval_dir / "cases.md"
    expected = eval_dir / "expected.md"
    if cases.exists() and expected.exists():
        case_ids = headings(cases)
        expected_ids = headings(expected)
        if len(case_ids) != len(set(case_ids)):
            errors.append(f"{skill}: duplicate case ID in cases.md")
        if len(expected_ids) != len(set(expected_ids)):
            errors.append(f"{skill}: duplicate case ID in expected.md")
        if set(case_ids) != set(expected_ids):
            errors.append(f"{skill}: cases.md and expected.md IDs differ")
        for case_id in case_ids:
            previous = global_eval_ids.get(case_id)
            if previous is not None:
                errors.append(f"duplicate eval case ID {case_id}: {previous} and {skill}/cases.md")
            else:
                global_eval_ids[case_id] = f"{skill}/cases.md"
        minimum = minimum_cases.get(skill, 5)
        if len(case_ids) < minimum:
            errors.append(f"{skill}: expected at least {minimum} eval cases, found {len(case_ids)}")

specialist_requirements = {
    "requirement-engineering": {
        "prefix": "REQ-",
        "title": "# Requirement Engineering Cases",
        "forbidden_titles": ("Spec-Driven Development",),
    },
    "change-planning": {
        "prefix": "CHG-",
        "title": "# Change Planning Cases",
        "forbidden_titles": ("Planning and Task Breakdown",),
    },
}
for skill, requirement in specialist_requirements.items():
    cases_path = root / "evals" / skill / "cases.md"
    expected_path = root / "evals" / skill / "expected.md"
    if not cases_path.exists() or not expected_path.exists():
        continue
    cases_text = cases_path.read_text(encoding="utf-8")
    expected_text = expected_path.read_text(encoding="utf-8")
    if not cases_text.splitlines() or cases_text.splitlines()[0].strip() != requirement["title"]:
        errors.append(f"{skill}: cases.md must use the semantic title {requirement['title']!r}")
    if not expected_text.splitlines() or expected_text.splitlines()[0].strip() != f"# {skill.replace('-', ' ').title()} Expected Outcomes":
        errors.append(f"{skill}: expected.md has the wrong semantic title")
    for forbidden_title in requirement["forbidden_titles"]:
        if forbidden_title in cases_text or forbidden_title in expected_text:
            errors.append(f"{skill}: stale migrated eval title remains: {forbidden_title}")
    case_ids = headings(cases_path)
    expected_ids = headings(expected_path)
    for case_id in case_ids + expected_ids:
        if not case_id.startswith(requirement["prefix"]):
            errors.append(f"{skill}: eval ID must use {requirement['prefix']} prefix: {case_id}")
    if len(case_ids) < 8:
        errors.append(f"{skill}: semantic specialist evals require at least 8 cases")

readme = root / "README.md"
if not readme.exists() or f"v{expected_version}" not in readme.read_text(encoding="utf-8"):
    errors.append(f"README.md must declare stable version v{expected_version}")
if not readme.exists() or "hugo2lee/engineering-philosophy" not in readme.read_text(encoding="utf-8"):
    errors.append("README.md must document the target repository hugo2lee/engineering-philosophy")

changelog = root / "CHANGELOG.md"
if not changelog.exists() or f"## v{expected_version} -" not in changelog.read_text(encoding="utf-8"):
    errors.append(f"CHANGELOG.md must contain the v{expected_version} release heading")
if not changelog.exists() or "Added the C++ boundary realization reference under `architecture-boundaries` without creating a C++ top-level Skill." not in changelog.read_text(encoding="utf-8"):
    errors.append("CHANGELOG.md must preserve the released v0.2.0 C++ reference entry")

architecture_skill = root / "skills" / "architecture-boundaries" / "SKILL.md"
cpp_reference = root / "skills" / "architecture-boundaries" / "references" / "languages" / "cpp.md"
if not cpp_reference.exists():
    errors.append("architecture-boundaries is missing references/languages/cpp.md")
elif not architecture_skill.exists() or "references/languages/cpp.md" not in architecture_skill.read_text(encoding="utf-8"):
    errors.append("architecture-boundaries SKILL.md must link references/languages/cpp.md")

lifecycle_documents = (
    (root / "README.md", "Release Behavior Baseline", "Change Review / Gate 3"),
    (root / "skills" / "engineering-philosophy" / "SKILL.md", "Release Behavior Baseline", "Change Review / Gate 3"),
    (root / "skills" / "engineering-philosophy" / "references" / "feature-change-lifecycle.md", "Release Behavior Baseline", "Change Review / Gate 3"),
)
for document, baseline_marker, review_marker in lifecycle_documents:
    if not document.exists():
        errors.append(f"lifecycle document is missing: {document.relative_to(root)}")
        continue
    text = document.read_text(encoding="utf-8")
    baseline_position = text.find(baseline_marker)
    review_position = text.find(review_marker)
    if baseline_position < 0 or review_position < 0 or baseline_position > review_position:
        errors.append(f"{document.relative_to(root)} must establish {baseline_marker} before {review_marker}")

lifecycle_order = (
    "User Request",
    "Requirement Clarification",
    "Requirement Reconciliation",
    "User Decision Gate",
    "Approved Requirement Contract",
    "Repository Analysis",
    "Business Change / Impact Analysis",
    "Architecture Pressure Analysis",
    "Conditional architecture-boundaries / ddd-lite routing",
    "Implementation Plan",
    "Incremental Implementation",
    "TDD / Focused Verification",
    "Release Behavior Baseline",
    "Change Review / Gate 3",
    "CI / Artifact / Release Verification / Gate 4",
    "Version / Tag / Release",
)
for document in (
    root / "README.md",
    root / "skills" / "engineering-philosophy" / "SKILL.md",
    root / "skills" / "engineering-philosophy" / "references" / "feature-change-lifecycle.md",
):
    if not document.exists():
        continue
    text = document.read_text(encoding="utf-8")
    positions = [text.find(marker) for marker in lifecycle_order]
    if any(position < 0 for position in positions):
        missing = [marker for marker, position in zip(lifecycle_order, positions) if position < 0]
        errors.append(f"{document.relative_to(root)} is missing lifecycle markers {missing}")
    elif positions != sorted(positions):
        errors.append(f"{document.relative_to(root)} lifecycle markers are out of order")

review_skill = root / "skills" / "code-review-and-quality" / "SKILL.md"
if not review_skill.exists() or "applicable Release Behavior Baselines" not in review_skill.read_text(encoding="utf-8"):
    errors.append("code-review-and-quality must require applicable Release Behavior Baselines before Gate 3")
record_template = root / "skills" / "engineering-philosophy" / "references" / "feature-change-record.md"
if not record_template.exists() or "## Change Review / Gate 3" not in record_template.read_text(encoding="utf-8"):
    errors.append("Feature Change Record must include a Change Review / Gate 3 section")

version_value = (root / "VERSION").read_text(encoding="utf-8").strip() if (root / "VERSION").exists() else ""
if version_value != expected_version:
    errors.append(f"VERSION must equal {expected_version}, found {version_value!r}")

tag_ref = os.environ.get("GITHUB_REF", "")
tag_name = os.environ.get("GITHUB_REF_NAME", "")
if tag_ref.startswith("refs/tags/") and tag_name != f"v{expected_version}":
    errors.append(f"GitHub tag context must be v{expected_version}, found {tag_name or tag_ref}")

routing_path = root / "evals" / "routing" / "cases.yaml"
if not routing_path.exists():
    errors.append("evals/routing/cases.yaml is missing")
else:
    try:
        routing_cases = yaml.safe_load(routing_path.read_text(encoding="utf-8"))
    except yaml.YAMLError as exc:
        errors.append(f"evals/routing/cases.yaml: invalid YAML: {exc}")
        routing_cases = []
    if not isinstance(routing_cases, list):
        errors.append("evals/routing/cases.yaml: top level must be a list")
        routing_cases = []

    seen_ids = set()
    counts = {"zh": 0, "en": 0, "mixed": 0}
    routing_by_id = {}
    required_fields = {"id", "language", "prompt", "expected_primary", "allowed_secondary", "forbidden"}
    for case in routing_cases:
        if not isinstance(case, dict):
            errors.append("evals/routing/cases.yaml: every case must be a mapping")
            continue
        missing = required_fields - set(case)
        if missing:
            errors.append(f"routing case {case.get('id', '<unknown>')}: missing {sorted(missing)}")
            continue
        case_id = case["id"]
        if case_id in seen_ids:
            errors.append(f"routing: duplicate case ID {case_id}")
        seen_ids.add(case_id)
        previous = global_eval_ids.get(case_id)
        if previous is not None:
            errors.append(f"duplicate eval case ID {case_id}: {previous} and evals/routing/cases.yaml")
        else:
            global_eval_ids[case_id] = "evals/routing/cases.yaml"
        routing_by_id[case_id] = case
        language = case["language"]
        if language not in counts:
            errors.append(f"routing case {case_id}: language must be zh, en, or mixed")
        else:
            counts[language] += 1
        if not isinstance(case["prompt"], str) or not case["prompt"].strip():
            errors.append(f"routing case {case_id}: prompt must be non-empty")
        for field in ("expected_primary", "allowed_secondary", "forbidden"):
            validate_skill_list(case[field], case_id, field)
        if any(value in case["forbidden"] for value in case["expected_primary"]):
            errors.append(f"routing case {case_id}: expected primary is also forbidden")
        prompt = case["prompt"]
        has_cjk = bool(re.search(r"[\u3400-\u9fff]", prompt))
        has_latin = bool(re.search(r"[A-Za-z]", prompt))
        if language == "zh" and not has_cjk:
            errors.append(f"routing case {case_id}: zh case has no CJK text")
        if language == "en" and has_cjk:
            errors.append(f"routing case {case_id}: en case contains CJK text")
        if language == "mixed" and not (has_cjk and has_latin):
            errors.append(f"routing case {case_id}: mixed case needs both CJK and Latin text")

    if len(routing_cases) < 30:
        errors.append(f"routing: expected at least 30 cases, found {len(routing_cases)}")
    for language, minimum in (("zh", 12), ("en", 12), ("mixed", 6)):
        if counts[language] < minimum:
            errors.append(f"routing: expected at least {minimum} {language} cases, found {counts[language]}")

    negative_requirements = {
        "ROUTE-ZH-001": "ddd-lite",
        "ROUTE-EN-013": "ddd-lite",
        "ROUTE-ZH-003": "architecture-boundaries",
        "ROUTE-EN-015": "architecture-boundaries",
        "ROUTE-ZH-004": "change-planning",
        "ROUTE-EN-017": "requirement-engineering",
        "ROUTE-ZH-005": "incremental-implementation",
        "ROUTE-ZH-006": "change-planning",
        "ROUTE-EN-018": "change-planning",
        "ROUTE-ZH-007": "code-review-and-quality",
        "ROUTE-EN-019": "code-review-and-quality",
        "ROUTE-EN-020": "systematic-debugging",
        "ROUTE-ZH-009": "ci-cd-and-automation",
        "ROUTE-EN-022": "git-workflow-and-versioning",
    }
    for case_id, forbidden_skill in negative_requirements.items():
        case = routing_by_id.get(case_id)
        if case is None:
            errors.append(f"routing: required negative case is missing: {case_id}")
        elif forbidden_skill not in case.get("forbidden", []):
            errors.append(f"routing case {case_id}: must forbid {forbidden_skill}")

lifecycle_path = root / "evals" / "lifecycle" / "cases.yaml"
if not lifecycle_path.exists():
    errors.append("evals/lifecycle/cases.yaml is missing")
else:
    try:
        lifecycle_cases = yaml.safe_load(lifecycle_path.read_text(encoding="utf-8"))
    except yaml.YAMLError as exc:
        errors.append(f"evals/lifecycle/cases.yaml: invalid YAML: {exc}")
        lifecycle_cases = []
    if not isinstance(lifecycle_cases, list):
        errors.append("evals/lifecycle/cases.yaml: top level must be a list")
        lifecycle_cases = []
    lifecycle_required = {
        "id", "category", "language", "prompt", "context", "expected_primary",
        "allowed_secondary", "expected_decisions", "forbidden", "acceptance",
    }
    lifecycle_seen = set()
    lifecycle_categories = set()
    for case in lifecycle_cases:
        if not isinstance(case, dict):
            errors.append("lifecycle: every case must be a mapping")
            continue
        case_id = case.get("id", "<unknown>")
        missing = lifecycle_required - set(case)
        if missing:
            errors.append(f"lifecycle case {case_id}: missing {sorted(missing)}")
            continue
        if case_id in lifecycle_seen:
            errors.append(f"lifecycle: duplicate case ID {case_id}")
        lifecycle_seen.add(case_id)
        previous = global_eval_ids.get(case_id)
        if previous is not None:
            errors.append(f"duplicate eval case ID {case_id}: {previous} and evals/lifecycle/cases.yaml")
        else:
            global_eval_ids[case_id] = "evals/lifecycle/cases.yaml"
        category = case["category"]
        if not isinstance(category, str) or not category.strip():
            errors.append(f"lifecycle case {case_id}: category must be non-empty")
        else:
            lifecycle_categories.add(category)
        language = case["language"]
        if language not in {"zh", "en", "mixed"}:
            errors.append(f"lifecycle case {case_id}: language must be zh, en, or mixed")
        prompt = case["prompt"]
        if not isinstance(prompt, str) or not prompt.strip():
            errors.append(f"lifecycle case {case_id}: prompt must be non-empty")
        if not isinstance(case["context"], str) or not case["context"].strip():
            errors.append(f"lifecycle case {case_id}: context must be non-empty")
        primary = case["expected_primary"]
        if not isinstance(primary, str) or primary not in skill_names:
            errors.append(f"lifecycle case {case_id}: expected_primary must be one Skill name")
        validate_skill_list(case["allowed_secondary"], case_id, "allowed_secondary")
        validate_skill_list(case["forbidden"], case_id, "forbidden")
        if primary in case["forbidden"]:
            errors.append(f"lifecycle case {case_id}: expected primary is also forbidden")
        decisions = case["expected_decisions"]
        if not isinstance(decisions, list) or not decisions or not all(isinstance(value, str) for value in decisions):
            errors.append(f"lifecycle case {case_id}: expected_decisions must be a non-empty list of strings")
        acceptance = case["acceptance"]
        if not isinstance(acceptance, str) or not acceptance.strip():
            errors.append(f"lifecycle case {case_id}: acceptance must be non-empty")
    if len(lifecycle_cases) < 30:
        errors.append(f"lifecycle: expected at least 30 cases, found {len(lifecycle_cases)}")
    required_categories = {
        "requirement-clarification", "requirement-reconciliation", "repository-analysis",
        "architecture-pressure", "change-planning", "behavior-implementation",
        "service-behavior-baseline", "persistence-baseline", "outbound-baseline",
        "inbound-baseline", "regression-debugging", "review-traceability", "release-readiness",
    }
    missing_categories = required_categories - lifecycle_categories
    if missing_categories:
        errors.append(f"lifecycle: missing required categories {sorted(missing_categories)}")

# Old Skill names are allowed only in intentional migration/history prose. They
# must not leak into active Skill instructions or executable routing data.
allowed_stale_paths = {
    root / "README.md",
    root / "CHANGELOG.md",
    root / "docs" / "migrations" / "v0.3.0-skill-renames.md",
    root / "scripts" / "validate.sh",
    root / "scripts" / "smoke-test-npx.sh",
}
for path in root.rglob("*"):
    if not path.is_file() or ".git" in path.parts or path in allowed_stale_paths:
        continue
    try:
        text = path.read_text(encoding="utf-8")
    except (UnicodeDecodeError, OSError):
        continue
    for old_name in old_skill_names:
        if old_name in text:
            errors.append(f"{path.relative_to(root)} contains stale active Skill name {old_name}")

for error in errors:
    print(f"ERROR: {error}", file=sys.stderr)
sys.exit(1 if errors else 0)
PY
  then
    failures=$((failures + 1))
  fi
fi

if [[ ! -f "$ROOT_DIR/.github/workflows/validate.yml" ]]; then
  fail "missing GitHub Actions validation workflow"
fi
if ! grep -Fq 'skills@latest' "$ROOT_DIR/scripts/smoke-test-npx.sh"; then
  fail "npx installation smoke test is missing"
fi

if (( failures > 0 )); then
  printf 'Validation failed with %d issue(s).\n' "$failures" >&2
  exit 1
fi

printf 'Validated %d Skills at v%s with skills-ref, repository rules, references, routing, lifecycle evals, and metadata.\n' "${#SKILLS[@]}" "$VERSION"
