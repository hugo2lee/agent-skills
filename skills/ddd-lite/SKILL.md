---
name: ddd-lite
description: Model domain behavior pragmatically by starting from business invariants and consistency needs, using DDD patterns only when their conditions are present.
license: AGPL-3.0-only
metadata:
  version: "0.1.0"
  category: "domain-modeling"
---

# DDD Lite

## Use this skill when

Use this Skill when a task involves domain rules, business invariants, lifecycle, state transitions, aggregate boundaries, domain events, bounded contexts, or deciding whether DDD is justified.

Do not use it to decorate a simple CRUD application with domain terminology. For technical dependency direction and adapters, route to architecture-boundaries.

## Governing rule

Model the business pressure first. Choose the smallest domain structure that protects the real invariant.

Do not select a pattern because its name is familiar, its diagram looks complete, or another team uses it.

## Decision sequence

1. Describe the business capability in the user's language.
2. Identify the invariant, state transition, or decision that must remain true.
3. Identify who owns that rule and what must be consistent together.
4. Choose the smallest object or boundary that can protect it.
5. Keep application orchestration separate from domain decisions.
6. Decide whether an external context or model needs an explicit translation boundary.
7. Add tests for the invariant and important transitions.
8. Re-check whether the chosen model is simpler than the problem it solves.

## MUST

- State the invariant before introducing a DDD pattern.
- Keep business rules close to the model that owns them when that improves correctness.
- Make consistency boundaries explicit when they matter.
- Preserve domain language in names and behavior.
- Test important invariants through observable behavior.
- Keep infrastructure concerns outside the domain model.

## SHOULD

- Use a Value Object when value semantics and validation are important.
- Use an Entity when identity and lifecycle matter.
- Keep Aggregates small enough to protect one consistency boundary.
- Use Domain Services only for behavior that does not naturally belong to one domain object.
- Use Domain Events for meaningful facts that other parts of the system must react to.
- Use Bounded Contexts when models, ownership, or language genuinely diverge.

## CONDITIONAL patterns

- Aggregate: introduce it when multiple state changes must remain atomically consistent.
- Domain Event: introduce it when the fact of a completed business action matters beyond the local transaction.
- Anti-Corruption Layer: introduce it when an external model would otherwise distort the internal model.
- CQRS: introduce it when read and write models have materially different needs.
- Event Sourcing: introduce it only when event history and replay are core requirements.

## Reject cargo-cult modeling

Do not introduce an Aggregate for every database table, a Domain Event for every method call, or a Value Object for every scalar without a behavior or invariant to protect.

Do not turn an anemic data bag into an anemic model with more classes. Add behavior where it clarifies ownership, or keep the data structure simple when no invariant requires more.

Read [tactical-modeling.md](references/tactical-modeling.md) for pattern conditions, [bounded-contexts.md](references/bounded-contexts.md) for context boundaries, and [anti-patterns.md](references/anti-patterns.md) before approving a complex model.

## Routing

Route to architecture-boundaries when the question becomes one of dependency direction, ports, adapters, infrastructure isolation, or composition.

Route to test-driven-development when implementing a new invariant. Route to systematic-debugging when an invariant fails in a running system.

## Verification

An acceptable design can name:

- the business invariant;
- the owner of that invariant;
- the consistency boundary;
- the reason for each introduced pattern;
- the behavior tests that protect it;
- the simpler alternative that was rejected and why.
