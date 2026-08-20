# Systematic Debugging Expected Outcomes

## DBG-001

- Preserve the timeout evidence.
- Reproduce, collect state and timing, test competing hypotheses, make a minimal fix, and add regression coverage.

## DBG-002

- State that the cause is not proven.
- Gather targeted production evidence or define the next safe reproduction step.

## DBG-003

- Reject changing several variables at once.
- Preserve evidence and run one minimal experiment per hypothesis.

## DBG-004

- Trace the earliest incorrect state and boundary crossing.
- Do not patch only the final error message.

## DBG-005

- Write falsifiable hypotheses.
- Define experiments that distinguish them with minimal side effects.

## DBG-006

- Add a stable regression test.
- Rerun the original reproduction and relevant suite.

## DBG-007

- Reject compile-only closure.
- Verify the original behavior and nearby risks.

## DBG-008

- Inspect adapter translation and provider error mapping.
- Route design changes to architecture-boundaries after the cause is understood.

