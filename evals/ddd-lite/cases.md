# DDD Lite Cases

## DDD-001 — Simple CRUD

Prompt: A simple internal CRUD screen has no business invariants. Should it use Aggregates and Domain Events?

Expected focus: keep the model simple and avoid cargo-cult DDD.

## DDD-002 — Order invariant

Prompt: An order may be confirmed only when it has a positive total and is still a draft.

Expected focus: place and test the invariant in an appropriate domain model, potentially an Aggregate.

## DDD-003 — Money value

Prompt: Money must have currency, precision rules, and safe addition.

Expected focus: use a Value Object because value semantics and validation matter.

## DDD-004 — Cross-object behavior

Prompt: A pricing decision genuinely depends on two domain objects and belongs to neither.

Expected focus: consider a Domain Service with a named business operation, not a generic service dump.

## DDD-005 — Business fact

Prompt: Other bounded areas must react after an order is confirmed.

Expected focus: consider a meaningful Domain Event and define its ownership and consistency.

## DDD-006 — Divergent language

Prompt: Sales and fulfillment use the same word with different lifecycle and meaning.

Expected focus: consider separate contexts and explicit translation rather than one distorted model.

## DDD-007 — External model

Prompt: A vendor customer model conflicts with the internal customer concept.

Expected focus: use an Anti-Corruption Layer when the external model would leak inward.

## DDD-008 — CQRS or Event Sourcing

Prompt: The team wants CQRS and Event Sourcing because the architecture diagram should look modern.

Expected focus: reject pattern-first design and demand concrete read/write, audit, or replay pressure.
