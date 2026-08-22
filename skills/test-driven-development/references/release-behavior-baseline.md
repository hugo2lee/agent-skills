# Release Behavior Baseline

TDD protects a behavior while it is being developed. A Release Behavior Baseline protects important behavior after it has shipped. The baseline is executable evidence at the boundary that owns the contract, not a demand to duplicate every test at every layer.

## Service Behavior Baseline

Protect the transport-independent service contract:

- business input and output;
- success and error semantics;
- meaningful state changes;
- important side effects and idempotency behavior;
- boundary conditions that users or callers can observe.

These tests should express behavior, not private call sequences.

## Persistence Integration Baseline

Protect the real adapter and storage integration when persistence matters:

- adapter mapping and real Save, Load, or Update behavior;
- transaction boundaries and rollback;
- constraints, conflict behavior, and nullability;
- schema mapping, serialization, and migrations;
- behavior that an in-memory fake cannot prove.

Service tests do not prove persistence integration.

## Outbound Contract Baseline

Protect the port-to-adapter-to-provider contract:

- request and response mapping;
- provider errors, timeouts, retries, and idempotency;
- protocol headers, status, serialization, or message shape when relevant;
- the boundary's behavior when the provider is unavailable.

Do not replace this with a mock that only proves a method was called.

## Inbound Mapping Baseline

Protect transport-to-service and result-to-transport translation:

- request parsing and command mapping;
- authentication or context mapping when in scope;
- success response mapping;
- domain or application error mapping;
- malformed input and protocol-level failure behavior.

Do not repeat the full business behavior suite here. Test the mapping and keep the service baseline as the owner of business behavior.

## Anti-weakening flow

When a baseline fails:

1. confirm the failure and its evidence;
2. if no behavior change was authorized, fix the implementation, adapter, mapping, or test setup;
3. if behavior change was authorized, update the Requirement Contract, reconciliation decision, Feature Change Record, baseline, implementation, and release notes together;
4. rerun the affected baseline and adjacent verification before release.

Never delete or weaken a baseline merely to make the pipeline green.
