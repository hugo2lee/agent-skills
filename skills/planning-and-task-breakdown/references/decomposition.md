# Decomposition

A good task names a behavior, boundary, or verification outcome. It has a clear input, output, dependency, and completion condition.

Prefer:

1. discover and confirm constraints;
2. establish a safety net;
3. implement one behavior;
4. integrate and verify;
5. clean up temporary structure.

Avoid splitting a tightly coupled decision into artificial file-based tasks. Split when a slice can be reviewed, tested, or safely handed off independently.
