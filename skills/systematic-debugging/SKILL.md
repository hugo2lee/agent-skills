---
name: systematic-debugging
description: Investigate an actual test, build, runtime, integration, timeout, regression, or deployment failure with reproduction, evidence, falsifiable hypotheses, minimal fixes, and regression verification. Do not replace diagnosis with architecture redesign, broad refactoring, or compile-only confidence.
license: AGPL-3.0-only
metadata:
  version: "0.2.0"
  category: "debugging"
---

# Systematic Debugging

## Use this skill when

Use this Skill when a test, build, runtime behavior, deployment, data flow, or integration fails or behaves unexpectedly.

Do not use it to hide uncertainty. If the failure cannot be reproduced, record the uncertainty and define the next evidence-gathering step.

## Governing rule

Debugging is an evidence loop, not a sequence of guesses.

Reproduce → Observe → Hypothesize → Test → Fix → Reproduce → Verify.

## Procedure

1. State the observed failure, expected behavior, scope, and first known occurrence.
2. Build the smallest stable reproduction.
3. Capture inputs, environment, logs, state, timing, and relevant changes.
4. List competing hypotheses and what evidence would distinguish them.
5. Run one minimal experiment at a time.
6. Identify the earliest incorrect state, not only the final symptom.
7. Apply the smallest fix that addresses the confirmed cause.
8. Add or strengthen a regression test.
9. Re-run the reproduction and relevant broader checks.
10. Report what is proven, what remains uncertain, and what was not changed.

## MUST

- Preserve the original failure evidence before changing behavior.
- Separate facts, hypotheses, and conclusions.
- Change one meaningful variable per experiment when possible.
- Fix the confirmed cause rather than only the visible symptom.
- Add a regression test for a confirmed defect.
- Verify both the original failure and nearby behavior after the fix.

## SHOULD

- Prefer deterministic reproduction over broad log scanning.
- Use binary search, tracing, instrumentation, or minimal probes when they reduce uncertainty.
- Check recent changes and boundary crossings without assuming they are the cause.
- Keep a short hypothesis log for failures that require several experiments.
- Stop and ask for missing information when the next safe experiment needs user input.

## Do not

- randomly edit several files and hope the failure disappears;
- change tests to match a broken implementation without proving the intended behavior;
- treat a successful compile as a behavior fix;
- remove logging or assertions before understanding their signal;
- declare success without re-running the original reproduction.

Read [reproduction-and-evidence.md](references/reproduction-and-evidence.md) for evidence collection, [hypothesis-driven-debugging.md](references/hypothesis-driven-debugging.md) for experiments, and [regression-verification.md](references/regression-verification.md) for the final loop.

## Routing

Route new behavior to test-driven-development. Route unclear acceptance criteria to spec-driven-development. Route dependency or boundary causes to architecture-boundaries or ddd-lite.

## Verification

A debugging report is complete only when it includes:

- the original symptom and reproduction;
- the confirmed root cause or explicit remaining uncertainty;
- the minimal change;
- the regression test;
- the original reproduction result after the fix;
- relevant broader checks and any residual risk.
