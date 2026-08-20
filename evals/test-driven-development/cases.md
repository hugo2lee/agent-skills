# Test-Driven Development Cases

## TDD-001 — New behavior

Prompt: Add a rule that rejects empty orders.

Expected focus: write one failing behavior test, implement minimally, then refactor while green.

## TDD-002 — Test after

Prompt: The entire feature is implemented; now add tests for every private method.

Expected focus: reconsider the order and test observable behavior rather than private details.

## TDD-003 — Bug regression

Prompt: A repeated idempotency key caused duplicate payment.

Expected focus: create a regression test that fails before the fix and passes after it.

## TDD-004 — Interaction assertions

Prompt: A test asserts every internal method call even though the public result is correct.

Expected focus: prefer behavior and stable contracts; keep interaction assertions only when interaction is the contract.

## TDD-005 — Mocking interface

Prompt: A local concrete formatter is hard to mock, so create an interface solely for the test.

Expected focus: avoid the interface unless a real substitution or boundary exists.

## TDD-006 — Large feature

Prompt: A feature crosses handler, application, domain, and persistence layers.

Expected focus: choose a narrow vertical slice and iterate through the loop.

## TDD-007 — Broken fixture

Prompt: A new test fails because its fixture cannot be constructed.

Expected focus: distinguish a broken test setup from a useful red state before changing production code.

## TDD-008 — Refactor

Prompt: The behavior tests are green but the implementation has duplication.

Expected focus: refactor while green and rerun focused and broader verification.
