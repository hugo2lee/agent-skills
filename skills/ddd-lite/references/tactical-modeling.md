# Tactical Modeling

Start from behavior and invariants, then choose a model shape.

## Entity

Use an Entity when identity remains meaningful while attributes change. Identity alone does not require a large class hierarchy.

## Value Object

Use a Value Object when values have validation, domain operations, or equality by value. A plain scalar is acceptable when it has no domain behavior.

## Aggregate

Use an Aggregate to define the smallest consistency boundary for changes that must remain valid together. Do not make every persistence row an Aggregate.

## Domain Service

Use a Domain Service when a domain operation is real but does not naturally belong to one Entity or Value Object. Do not use it as a dumping ground for all business logic.

## Domain Event

Use a Domain Event for a meaningful business fact that another part of the system must observe. An internal method call is not automatically an event.

## Decision test

For every pattern state:

- the invariant or business pressure;
- the owner;
- the consistency requirement;
- the simpler model rejected;
- the tests that protect the decision.
