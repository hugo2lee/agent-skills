---
name: incremental-implementation
description: Sequence a large change, migration, or refactor into small vertical slices with compatibility steps, safety nets, and frequent runnable verification. Do not use it as the primary Skill for ordinary task planning, one behavior's TDD loop, or active failure diagnosis.
license: AGPL-3.0-only
metadata:
  version: "0.2.0"
  category: "implementation"
---

# Incremental Implementation

## Use this skill when

Use this Skill for refactors, migrations, new features spanning layers, dependency replacement, or any change whose full implementation would be difficult to verify in one step.

## Operating model

1. Establish the behavior and safety net.
2. Choose a vertical slice that exercises a real path.
3. Add the smallest compatible change.
4. Run focused and broader verification.
5. Keep old and new paths explicit while both exist.
6. Migrate the next slice.
7. Remove temporary compatibility code only after usage and verification prove it is safe.

## MUST

- Keep each slice independently understandable and verifiable.
- Preserve a working state between slices when practical.
- Make compatibility, fallback, and removal conditions explicit.
- Do not combine unrelated feature work with a migration.
- Verify behavior before deleting the old path.

## SHOULD

- Prefer vertical slices over layer-by-layer speculative scaffolding.
- Add seams before replacing implementations.
- Use adapters, feature flags, dual reads, or staged writes only when their trade-offs are understood.
- Keep commits small enough to review and revert.
- Track temporary code and its removal condition.

## Do not

- rewrite an entire subsystem before proving one path;
- leave two sources of truth without an explicit reconciliation plan;
- call a partial migration complete because it compiles;
- use a compatibility layer as a permanent architecture.

Read [vertical-slices.md](references/vertical-slices.md) for slice selection and [safe-change-sequencing.md](references/safe-change-sequencing.md) for migrations.

## Routing

Use planning-and-task-breakdown to define slices. Use test-driven-development inside each slice. Use systematic-debugging when a slice fails and code-review-and-quality before merging.

## Verification

For each slice record the behavior covered, checks run, compatibility state, remaining risk, and the condition for moving forward.
