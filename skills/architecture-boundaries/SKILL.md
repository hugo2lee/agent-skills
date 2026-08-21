---
name: architecture-boundaries
description: Decide whether a technical dependency boundary is meaningful and design Ports, Adapters, dependency inversion, explicit injection, and test seams. Use for DI, interfaces, package direction, infrastructure isolation, and protocol translation; not for primarily business invariants or active failure diagnosis.
license: AGPL-3.0-only
metadata:
  version: "0.2.0"
  category: "architecture"
---

# Architecture Boundaries

## Use this skill when

Use this Skill for architecture design, refactoring, dependency direction, ports and adapters, infrastructure isolation, dependency injection, package boundaries, or test seam decisions.

Do not use it to justify a full architecture template for every project. For business modeling and invariants, route to ddd-lite. For a concrete failure, route to systematic-debugging.

## Governing rule

Prefer the simplest architecture that preserves meaningful boundaries.

A meaningful boundary protects at least one real responsibility, substitution point, independent test, protocol, deployment unit, ownership boundary, or source of change. A type name alone is not evidence of a boundary.

## Decision sequence

1. State the behavior and change risk the boundary should protect.
2. Identify the caller, capability owner, implementation, and direction of dependency.
3. Decide whether concrete types are sufficient inside the boundary.
4. If the boundary is real, define the smallest purposeful contract on the consumer side.
5. Inject the implementation explicitly and assemble it at the Composition Root.
6. Keep protocol and provider translation in an Adapter.
7. Check that Domain and application policy do not depend on infrastructure details.
8. Add a test seam that verifies the boundary behavior.
9. Re-evaluate whether DDD modeling is needed; route that decision to ddd-lite.

## MUST

- Dependencies must point toward the policy or business core.
- Domain code must not depend on database, HTTP, queue, ORM, or cloud implementations.
- Cross-boundary contracts must express a purposeful capability.
- Dependencies must be explicit and injectable.
- Concrete implementations must be assembled at the Composition Root.
- Important boundaries must have a meaningful verification seam.
- Do not create interfaces solely to make local mocking convenient.

## SHOULD

- Let the consumer own a small interface when it needs a replaceable capability.
- Keep interfaces focused on behavior rather than mirroring a concrete type.
- Let repositories express domain capabilities instead of exposing storage CRUD.
- Keep application services responsible for orchestration, not hidden domain invariants.
- Let adapters translate protocols and providers without leaking them inward.
- Migrate large systems through small vertical slices.

## CONDITIONAL

Introduce an inbound port only when it protects a meaningful boundary or substitute. An HTTP handler calling an application service does not automatically require an interface.

Introduce a repository abstraction only when storage is a real change boundary, the domain needs a capability, or independent testing requires it.

Introduce an Aggregate, Domain Event, CQRS, or another DDD pattern only when its business invariant or consistency requirement is real. Route the modeling decision to ddd-lite.

## Anti-patterns

Reject these unless there is unusually strong evidence:

- one interface for every struct or service;
- an application service depending directly on a concrete database client;
- hidden package globals for databases, clocks, or network clients;
- constructors that create their own infrastructure;
- ORM base types leaking into domain objects;
- a repository that exposes every table operation without domain meaning;
- a giant service that owns every domain rule.

Read [hexagonal.md](references/hexagonal.md) for port and adapter terminology, [testing-seams.md](references/testing-seams.md) for verification boundaries, [languages/go.md](references/languages/go.md) for Go package and constructor guidance, and [languages/cpp.md](references/languages/cpp.md) when applying the same decisions in C++.

## Verification

Before accepting a design, show:

- the boundary and the reason it is meaningful;
- the dependency direction;
- the contract owner and smallest capability surface;
- the Composition Root or injection path;
- the adapter translation point;
- the test or contract that proves the boundary;
- the reason any conditional pattern was or was not introduced.
