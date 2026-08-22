# Code Review and Quality Cases

## REV-001 — Correctness defect

Prompt: A review finds a race that can duplicate a user-visible action.

Expected focus: report a high-severity actionable finding with location, impact, and evidence.

## REV-002 — Style difference

Prompt: The implementation uses a different naming style but behavior and project convention are consistent.

Expected focus: do not block on subjective style preference.

## REV-003 — Missing regression test

Prompt: A bug fix changes behavior but adds no test.

Expected focus: request behavior-level regression evidence proportional to the defect.

## REV-004 — Scope creep

Prompt: The diff includes unrelated formatting across the repository.

Expected focus: flag scope and reviewability risk; keep unrelated cleanup separate.

## REV-005 — Evidence

Prompt: The author says “tests passed” without command or output for a migration.

Expected focus: request evidence matched to migration risk and state what remains unchecked.
