---
name: git-workflow-and-versioning
description: Keep engineering history safe and explainable through scoped branches, atomic commits, meaningful versions, and changelog entries that record behavior and reasons.
license: AGPL-3.0-only
metadata:
  version: "0.1.0"
  category: "delivery"
---

# Git Workflow and Versioning

## Use this skill when

Use this Skill when creating commits, preparing a branch, describing a release, updating a changelog, or deciding how to preserve a clean and reviewable history.

## Operating rules

1. Confirm the current branch and working tree.
2. Keep the branch scope aligned with the approved change.
3. Group related changes into atomic commits.
4. Write commit messages that explain behavior and intent.
5. Review the diff and tests before committing.
6. Use version changes that match user-visible compatibility impact.
7. Record why a meaningful engineering rule changed.

## MUST

- Do not discard user changes.
- Do not use destructive Git commands without explicit authorization.
- Keep unrelated formatting and cleanup out of the task branch.
- Make commits reviewable and internally coherent.
- Ensure the changelog describes meaningful behavior and reasons.

## SHOULD

- Prefer one behavior or migration step per commit.
- Keep generated artifacts out of source unless the project requires them.
- Use patch, minor, and major version changes consistently.
- Preserve a clean diff before handoff.
- Mention verification in the commit or handoff summary.

## Versioning

- PATCH: wording, examples, ambiguity removal, or non-decision-changing corrections.
- MINOR: new rules, references, eval cases, or capabilities that preserve the philosophy.
- MAJOR: a change to a core engineering principle or a breaking public workflow.

Read [branches-and-commits.md](references/branches-and-commits.md) for history shape and [history-hygiene.md](references/history-hygiene.md) for safe cleanup and release notes.

## Routing

Use code-review-and-quality before committing a meaningful change. Use ci-cd-and-automation for pipeline and release checks. Do not use Git history operations to hide an unresolved debugging or review problem.

## Verification

Before handoff, show the branch, diff summary, tests, commit scope, version impact, and changelog update.
