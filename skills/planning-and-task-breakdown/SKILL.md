---
name: planning-and-task-breakdown
description: Turn a clear, multi-step engineering goal into bounded tasks with dependencies, risks, checkpoints, completion criteria, and verification. Use when work is understood but complex or coordinated; not for unclear requirements, implementation sequencing details, or trivial edits.
license: AGPL-3.0-only
metadata:
  version: "0.2.0"
  category: "planning"
---

# Planning and Task Breakdown

## Use this skill when

Use this Skill for work involving multiple files, dependent steps, migration risk, coordination, or verification that cannot be described as one safe edit.

For a trivial change, use a short checklist instead of a large project plan.

## Planning procedure

1. Restate the outcome and success criteria.
2. Identify the current state and constraints.
3. Split the work by behavior or subsystem, not by arbitrary file count.
4. Order tasks by dependencies and risk.
5. Define a checkpoint and verification for each meaningful slice.
6. Name out-of-scope work and unresolved decisions.
7. Keep the plan updateable when repository evidence changes.

## MUST

- Make every task bounded and verifiable.
- Identify dependencies before parallelizing work.
- Put high-risk discovery before irreversible implementation.
- Keep scope aligned with the approved goal.
- State what evidence completes each task.

## SHOULD

- Prefer vertical slices that produce a usable or testable result.
- Separate discovery, implementation, migration, and cleanup.
- Call out compatibility and rollback concerns.
- Use the smallest plan that prevents implementation guessing.

## Do not

- produce a file inventory without behavior or dependency meaning;
- hide unresolved product decisions inside implementation tasks;
- schedule cleanup before the behavior is protected;
- split one tightly coupled decision across independent workers.

Read [decomposition.md](references/decomposition.md) for task shape and [dependencies-and-risks.md](references/dependencies-and-risks.md) for ordering.

## Routing

Start with spec-driven-development when the goal is unclear. Use incremental-implementation to execute a multi-step plan, test-driven-development for behavior slices, and code-review-and-quality before handoff.

## Verification

A plan is ready when implementation can proceed without inventing scope, ordering, interfaces, or acceptance checks.
