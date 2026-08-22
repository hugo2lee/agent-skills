# Change Plan

A Change Plan converts an approved Requirement Contract and repository analysis into executable slices. It should be specific enough to verify and small enough to revise when evidence changes.

## Plan fields

- outcome and acceptance criteria;
- slice boundaries and user-visible value;
- dependencies and ordering;
- business behavior and tests;
- minimum architectural enabler, if demonstrated pressure requires one;
- persistence, outbound, inbound, and release baseline work, when applicable;
- risks, checkpoints, and stop conditions;
- exact verification commands and completion conditions;
- explicit non-goals.

Each task has one owner of the decision, a bounded scope, a dependency statement, and a completion condition. “Implement backend” is not a verifiable task; “accept an idempotency key in the command, persist the result with the existing transaction adapter, and pass the duplicate-request behavior test” is.

## Plan evolution

Implementation discovery is expected. If a slice changes because repository evidence contradicts an assumption, update the Feature Change Record, explain the reason, and re-check affected gates. A changed plan is healthy; an unrecorded changed contract is silent drift.

## Review readiness

Before implementation starts, the plan should make it possible to identify the first runnable slice, the safety net that protects existing behavior, and the evidence that will show the slice is complete.
