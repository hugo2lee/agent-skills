# Planning and Task Breakdown Cases

## PLAN-001 — Multi-file feature

Prompt: A feature changes API, domain rules, persistence, tests, and CI.

Expected focus: produce bounded behavior-oriented tasks with dependencies and verification.

## PLAN-002 — Dependency order

Prompt: A migration needs a safety net before changing storage.

Expected focus: put discovery and tests before implementation and removal.

## PLAN-003 — Parallel conflict

Prompt: Two workers would edit the same application service.

Expected focus: do not parallelize overlapping work without resolving ownership or splitting the write set.

## PLAN-004 — Scope expansion

Prompt: The plan discovers a chance to rename the entire package tree.

Expected focus: keep unrelated cleanup out unless the user expands scope.

## PLAN-005 — Completion

Prompt: A plan says “implement feature” but has no checks.

Expected focus: add completion criteria and evidence for every meaningful task.
