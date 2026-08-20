# Regression Verification

A fix is not complete when the error disappears once. Add a regression test or a stable reproduction that fails before the fix and passes after it.

Re-run the original failure, the focused regression check, and the relevant broader suite. Check nearby behavior and state transitions. Report residual uncertainty when the original environment cannot be reproduced.
