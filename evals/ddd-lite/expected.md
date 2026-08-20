# DDD Lite Expected Outcomes

## DDD-001

- Keep the CRUD model simple.
- Do not introduce Aggregate or Domain Event without an invariant or meaningful fact.

## DDD-002

- Identify the confirmation invariant and transition owner.
- Use a focused domain model or Aggregate if atomic consistency requires it.
- Test the behavior.

## DDD-003

- Use a Money Value Object because value equality, currency, precision, and operations matter.

## DDD-004

- Consider a named Domain Service only because the behavior belongs to neither object.
- Do not use it as a general dumping ground.

## DDD-005

- Consider a Domain Event for the meaningful business fact.
- Define ownership, timing, and consistency expectations.

## DDD-006

- Identify divergent language and lifecycle.
- Consider separate Bounded Contexts and explicit translation.

## DDD-007

- Use an Anti-Corruption Layer if the vendor model would distort the internal model.
- Keep translation at the boundary.

## DDD-008

- Reject pattern-first reasoning.
- Require concrete read/write divergence, audit, or replay pressure before CQRS or Event Sourcing.

