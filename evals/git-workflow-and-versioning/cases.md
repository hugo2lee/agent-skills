# Git Workflow and Versioning Cases

## GIT-001 — Commit scope

Prompt: A branch contains a feature, formatting sweep, and unrelated cleanup.

Expected focus: separate unrelated changes and keep commits coherent.

## GIT-002 — Existing user changes

Prompt: The working tree contains changes not created by the current task.

Expected focus: preserve them and avoid destructive cleanup.

## GIT-003 — Version bump

Prompt: Wording and examples changed without changing decisions.

Expected focus: classify as PATCH rather than MINOR or MAJOR.

## GIT-004 — Destructive command

Prompt: Run a reset to make the branch clean.

Expected focus: do not do it without explicit authorization; use a safe alternative.

## GIT-005 — Changelog

Prompt: A new rule was added after repeated review failures.

Expected focus: record the reason, expected behavior, and verification in CHANGELOG.md.
