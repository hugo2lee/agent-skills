# Spec-Driven Development Cases

## SPEC-001 — Ambiguous feature

Prompt: “Add better notifications” with no audience, trigger, or success measure.

Expected focus: clarify outcome, constraints, acceptance criteria, non-goals, and decisions.

## SPEC-002 — Simple correction

Prompt: Fix a typo in a README.

Expected focus: use a proportional lightweight specification and verification.

## SPEC-003 — Non-goals

Prompt: While adding one endpoint, unrelated cleanup is discovered.

Expected focus: keep cleanup out of scope unless explicitly expanded.

## SPEC-004 — Conflicting constraints

Prompt: The request requires lower latency but also forbids changing the data source.

Expected focus: expose the conflict and ask for the decision that materially changes the solution.

## SPEC-005 — Acceptance behavior

Prompt: Define acceptance for rejecting an expired payment method.

Expected focus: write observable Given/When/Then behavior including relevant failure output.
