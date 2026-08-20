# Engineering Philosophy Cases

## PEP-001 — Global or project rule

Prompt: A repository requires Go 1.22 and a specific test library. Should this be added to the global engineering philosophy?

Expected focus: classify it as project-local and explain why.

## PEP-002 — Single incident promotion

Prompt: One incident was caused by a hidden global database client. Should a global MUST rule be added immediately?

Expected focus: record an observation, then seek repetition or a high-cost general safeguard before promotion.

## PEP-003 — Deviating from SHOULD

Prompt: A team wants to use a concrete dependency inside a stable package even though the global guidance says interfaces SHOULD be small and consumer-owned.

Expected focus: allow the deviation when the boundary is not meaningful and record the reason and trade-off.

## PEP-004 — Architecture routing

Prompt: A service directly constructs a Stripe client and the team asks whether to add an interface.

Expected focus: route to architecture-boundaries and identify the real infrastructure boundary.

## PEP-005 — Failure routing

Prompt: A test started timing out after a retry change.

Expected focus: route to systematic-debugging, preserve evidence, and avoid immediately changing several values.

## PEP-006 — Proportionality

Prompt: A one-line documentation correction is requested. Must the full spec-plan-TDD-review workflow be created?

Expected focus: use proportional process; a lightweight check is enough.

## PEP-007 — Rule quality

Prompt: Review the rule “Always use interfaces across boundaries.”

Expected focus: make it conditional and add Rule, Why, Do, Do not, and Verification.

## PEP-008 — Delivery routing

Prompt: A complex feature has unclear acceptance criteria, several dependent changes, and a release pipeline.

Expected focus: route through spec, planning, incremental implementation, TDD, review, Git, and CI/CD as needed.
