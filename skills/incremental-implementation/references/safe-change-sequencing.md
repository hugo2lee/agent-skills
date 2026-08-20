# Safe Change Sequencing

For a risky migration:

1. Observe current behavior.
2. Add a seam or compatibility point.
3. Introduce the new path behind a small boundary.
4. Verify old and new behavior.
5. Move traffic or callers in slices.
6. Remove the old path only after usage and rollback concerns are resolved.

Avoid dual writes or fallback logic unless consistency, reconciliation, and removal conditions are explicit. Temporary code must have an owner and a removal trigger.
