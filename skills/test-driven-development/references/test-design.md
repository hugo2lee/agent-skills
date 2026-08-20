# Test Design

## Behavior over implementation

Prefer inputs, outputs, state transitions, emitted business facts, or public errors over private calls and data structures.

## Boundary choice

Test a pure function directly, a domain invariant through domain behavior, an application capability through a consumer-owned port, and an adapter through protocol or contract checks.

## Test doubles

Use a fake when behavior matters and a simple deterministic implementation is clearer. Use a mock only when an interaction itself is the contract. Use a real integration dependency when translation or persistence behavior is what must be proven.

## Failure quality

A good test fails for one understandable reason, is deterministic, and points to the violated behavior. If a test fails for setup noise, simplify the fixture before adding more assertions.
