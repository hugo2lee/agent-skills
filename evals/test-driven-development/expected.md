# Test-Driven Development Expected Outcomes

## TDD-001

- Write a focused failing behavior test.
- Implement the smallest passing behavior.
- Refactor only while green and rerun broader checks.

## TDD-002

- Do not blindly test every private method after implementation.
- Reframe around observable behavior and use the Red-Green-Refactor loop.

## TDD-003

- Add a regression test that fails before the fix.
- Fix the smallest behavior and rerun the original scenario.

## TDD-004

- Prefer public behavior and stable contracts.
- Keep interaction assertions only when the interaction itself is the contract.

## TDD-005

- Do not add an interface solely for a mocking library.
- Use a concrete dependency or identify a real replaceable boundary.

## TDD-006

- Select one narrow vertical behavior.
- Avoid implementing empty layers or the entire feature before feedback.

## TDD-007

- Diagnose the fixture or test setup first.
- Do not treat a construction error as useful red evidence.

## TDD-008

- Refactor while tests are green.
- Rerun focused and broader verification after structural changes.

