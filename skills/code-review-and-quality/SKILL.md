---
name: code-review-and-quality
description: Review a diff or proposed implementation for behavior correctness, boundary violations, regressions, error handling, maintainability, scope, and verification evidence before merge or handoff. Do not use it as the primary Skill for live failure diagnosis or new implementation planning.
license: AGPL-3.0-only
metadata:
  version: "0.2.0"
  category: "quality"
---

# Code Review and Quality

## Use this skill when

Use this Skill before merging, handing off, or declaring a meaningful change complete. It is for reviewing a diff and its evidence, not for rewriting the task into a new project.

## Review order

1. Confirm the requested behavior and non-goals.
2. Check correctness and important edge cases.
3. Check dependency direction and meaningful boundaries.
4. Check error handling, state transitions, and compatibility.
5. Check whether tests protect behavior rather than implementation details.
6. Check maintainability and whether abstractions are purposeful.
7. Check the verification evidence and remaining uncertainty.
8. Report findings by severity with file and behavior context.

## MUST

- Review the actual diff and relevant surrounding code.
- Distinguish blocking defects from suggestions.
- Explain why each finding matters.
- Verify claims with tests, reproduction, or direct evidence.
- Check that the change stays within scope.

## SHOULD

- Review high-risk paths before stylistic details.
- Look for missing regression tests.
- Check public contracts and boundary ownership.
- Prefer a small actionable finding over a speculative redesign.
- State what was checked and what was not.

## Do not

- approve because tests are green without checking behavior;
- reject a change only because it differs from personal taste;
- request an interface or pattern without a concrete benefit;
- mix unrelated cleanup into a required fix;
- claim security or performance properties that were not evaluated.

Read [review-rubric.md](references/review-rubric.md) for finding quality and [verification.md](references/verification.md) for evidence.

## Routing

Route architecture findings to architecture-boundaries or ddd-lite. Route missing behavior tests to test-driven-development. Route an observed defect to systematic-debugging. Route merge and release concerns to git-workflow-and-versioning and ci-cd-and-automation.

## Verification

A review is complete when each finding has a severity, location, impact, recommendation, and evidence; the final summary states residual risk and checks performed.
