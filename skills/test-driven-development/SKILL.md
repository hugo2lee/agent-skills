---
name: test-driven-development
description: Develop or change observable behavior through focused Red-Green-Refactor loops, regression tests, and vertical slices. Use when implementation can be driven by acceptance behavior; not as the primary Skill for unclear requirements, active diagnosis, or code review.
license: AGPL-3.0-only
metadata:
  version: "0.2.0"
  category: "implementation"
---

# Test-Driven Development

## Use this skill when

Use this Skill for a new behavior, a change with clear acceptance criteria, a bug fix that needs a regression test, or an incremental refactor that must preserve behavior.

Use a lighter form for trivial configuration or documentation changes. Route unclear requirements to spec-driven-development before writing tests.

## Governing loop

1. Choose one observable behavior.
2. Write the smallest test that expresses the behavior and confirm it fails for the expected reason.
3. Implement only enough code to make that test pass.
4. Run the focused test and the relevant existing suite.
5. Refactor the design while keeping the tests green.
6. Repeat for the next behavior.

The loop is Red → Green → Refactor. A test that never failed has not demonstrated that it protects the intended behavior.

## MUST

- Test behavior through a stable public interface or meaningful boundary.
- Keep one focused behavior per iteration.
- Confirm the failure is caused by the missing behavior, not by a broken test.
- Keep the implementation minimal until the next behavior requires more.
- Preserve a regression test for every confirmed bug.
- Run the relevant verification after refactoring.

## SHOULD

- Prefer a vertical slice over a large layer-first implementation.
- Use domain and application behavior as the test vocabulary.
- Use fakes or contract tests when a real boundary is expensive or unstable.
- Keep tests deterministic and easy to diagnose.
- Let test friction reveal a boundary or dependency problem.
- Refactor duplication after behavior is protected.

## Avoid

- writing all production code first and adding tests afterward;
- testing private implementation details when public behavior is available;
- adding interfaces only to satisfy a mocking library;
- asserting every incidental call or internal data structure;
- increasing coverage with tests that do not protect a decision;
- changing the test and implementation together without observing the failure.

Read [red-green-refactor.md](references/red-green-refactor.md) for the loop, [test-design.md](references/test-design.md) for behavior and boundary choices, and [vertical-slices.md](references/vertical-slices.md) for larger changes.

## Routing

Route unclear scope or acceptance criteria to spec-driven-development. Route a large change to incremental-implementation. Route a failing test or unexpected result to systematic-debugging.

## Verification

Before declaring a TDD step complete, record:

- the behavior under test;
- the observed failing reason;
- the minimal implementation;
- the focused test result;
- the broader verification result;
- the refactoring performed while green.
