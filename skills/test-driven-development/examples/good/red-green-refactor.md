# Good TDD Trace

1. Behavior: confirming a non-empty draft order changes its status to confirmed.
2. Red: add a test and observe the missing transition failure.
3. Green: implement only the transition and invariant check.
4. Refactor: extract a name or value object while the test remains green.
5. Verify: run the focused test and the relevant package suite.

The trace records a meaningful failure before the implementation and keeps the
test focused on observable behavior.
