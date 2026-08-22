# Requirement Engineering Expected Outcomes

## REQ-001

- Ask for observable audience, trigger, outcome, success measure, error behavior, constraints, acceptance criteria, and non-goals.
- Keep provider, queue, and architecture choices out of the contract until the behavior is known.
- Use a proportional task-level record when the change is small.

## REQ-002

- Use a lightweight contract naming the exact documentation change and a direct verification.
- Keep unrelated cleanup out of scope.
- Do not impose full specification ceremony on an unambiguous typo fix.

## REQ-003

- Compare the requested command with the existing endpoint and classify the relationship as Overlap.
- Define the actual delta, including entry point and authorization, before choosing reuse or a new capability.
- Prefer a thin adapter when observable behavior remains the same.

## REQ-004

- Classify the request as Duplicate when the released endpoint already provides the same behavior and contract.
- Ask for the missing distinction rather than creating a parallel implementation.
- Preserve authorization and error semantics in the comparison.

## REQ-005

- Classify the request as Compatible Extension.
- Specify opt-in/default behavior, unchanged existing behavior, and baseline coverage for old and new paths.
- Avoid introducing a new abstraction without demonstrated pressure.

## REQ-006

- Classify the request as Conflict with the released retry contract.
- Stop at a User Decision Gate and explain compatibility, risk, and baseline impact.
- Do not delete or weaken retry evidence to make implementation pass.

## REQ-007

- Classify the request as Replacement and expose data, clients, migration, compatibility, deprecation, and removal consequences.
- Require an explicit decision about the migration/compatibility window before implementation.
- Do not reduce a breaking change to a symbol rename.

## REQ-008

- Identify two materially different product outcomes and present their trade-offs.
- Ask the user to decide before selecting storage, deletion, authorization, or compliance mechanisms.
- Record the chosen option, rejected alternative, and resulting acceptance behavior.
