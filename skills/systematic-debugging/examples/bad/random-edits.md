# Anti-Pattern: Random Edits

The agent changes the timeout, removes a retry, rewrites the query, and changes
the test fixture in one batch. The failure disappears locally, so the work is
declared complete.

This destroys evidence, does not identify the earliest incorrect state, and
cannot show which change fixed the defect or whether the failure will return.
