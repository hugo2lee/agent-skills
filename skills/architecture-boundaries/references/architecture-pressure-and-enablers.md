# Architecture Pressure and Enablers

Architecture should respond to demonstrated change pressure. A desired future capability may be a useful hypothesis, but it is not by itself an architectural requirement.

## Reasoning chain

Write the chain explicitly:

```text
Business change
    -> demonstrated change pressure
    -> architectural requirement
    -> smallest useful enabler
    -> verification evidence
```

Examples of pressure include repeated changes crossing the same unstable boundary, incompatible release cadence between owners, duplicated protocol translation causing observable defects, or a migration that requires old and new paths to coexist. “We may add a second provider someday” is not sufficient pressure for a provider abstraction today.

## Architectural requirement

State what must become possible or protected: isolate a volatile provider, prevent a dependency cycle, preserve compatibility during migration, or make a failure observable at the correct boundary. Do not state the solution as the requirement.

## Enabler

Choose the smallest change that satisfies the requirement: a consumer-owned port, an explicit constructor dependency, a composition-root wiring change, a protocol adapter, a compatibility seam, or a focused package move. Keep concrete types inside a stable boundary and avoid interfaces that merely mirror one implementation.

## Verification

The enabler is justified only if a test, dependency check, migration checkpoint, or observable failure can demonstrate the pressure it relieves. If no evidence would distinguish the enabler from unused scaffolding, defer it.

## Domain boundary

If the pressure is actually a business invariant or consistency boundary, route to `ddd-lite`. If it is only a technical dependency direction or protocol translation problem, keep the decision in `architecture-boundaries`.
