# Systematic Debugging Cases

## DBG-001 — Timeout

Prompt: Checkout times out after a retry change.

Expected focus: preserve the symptom, reproduce, capture evidence, test hypotheses, make the smallest fix, and add regression coverage.

## DBG-002 — Not reproducible

Prompt: A production-only failure cannot currently be reproduced locally.

Expected focus: state uncertainty and gather targeted evidence rather than claiming a fix.

## DBG-003 — Random edits

Prompt: Change timeout, retry, query, and fixture together until the test passes.

Expected focus: reject the approach because it destroys evidence and cannot identify cause.

## DBG-004 — Earliest incorrect state

Prompt: The final error is “invalid order,” but several state transitions precede it.

Expected focus: trace the earliest incorrect state and boundary crossing.

## DBG-005 — Hypothesis experiment

Prompt: Two plausible causes exist for a cache miss.

Expected focus: write competing hypotheses and one minimal falsifiable experiment for each.

## DBG-006 — Regression

Prompt: The error disappeared after a code change but no test was added.

Expected focus: add a stable regression test and rerun the original reproduction.

## DBG-007 — Compile success

Prompt: The code compiles after a fix, so the incident is closed.

Expected focus: reject compile-only evidence and verify behavior.

## DBG-008 — Boundary cause

Prompt: An adapter returns a provider error that leaks into the domain.

Expected focus: debug the translation boundary and route design changes to architecture-boundaries.
