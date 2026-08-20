# Incremental Implementation Cases

## INC-001 — Large rewrite

Prompt: Replace an entire subsystem in one branch before testing.

Expected focus: reject the big-bang approach and define a narrow vertical slice.

## INC-002 — Storage migration

Prompt: Migrate storage while existing callers remain active.

Expected focus: add a seam, introduce the new path, verify compatibility, migrate slices, then remove the old path.

## INC-003 — Dual writes

Prompt: Add dual writes without reconciliation or removal criteria.

Expected focus: expose consistency risk and require reconciliation and cleanup conditions.

## INC-004 — Vertical slice

Prompt: Choose between creating all empty layers or delivering one end-to-end behavior.

Expected focus: prefer the smallest real path that can be verified.

## INC-005 — Old path removal

Prompt: The new path compiles but old callers still exist.

Expected focus: do not remove the old path until usage and behavior are verified.
