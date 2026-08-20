# Testing Seams

A test seam is a place where behavior can be observed or a dependency can be replaced without rewriting the policy under test.

## Useful seams

- a public application operation;
- a domain method that protects an invariant;
- a consumer-owned port;
- an adapter contract;
- a deterministic clock or identifier source;
- a real integration boundary with isolated test data.

## Test selection

Use unit tests for pure policy and local invariants. Use contract tests for a capability implemented by multiple adapters. Use integration tests for actual protocol, persistence, or composition behavior. Use end-to-end tests only where the full path is the behavior being protected.

## Mock boundary

Do not create an interface only because a mocking library expects one. If a concrete dependency is local and stable, use it directly. If replacement is valuable, define a behavior-focused port and test the consumer against a meaningful fake.

## Verification questions

For every seam ask:

1. What behavior does it protect?
2. What change can it isolate?
3. Who owns the contract?
4. Can the test fail for a useful reason?
5. What integration check proves the real adapter works?
