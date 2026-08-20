# Branches and Commits

A branch should have one coherent purpose. Commit after a behavior or migration slice is verified, not after arbitrary file edits.

A useful commit message states the change and, when it is not obvious, the reason. Keep formatting-only changes separate from behavior changes.

Before a commit:

1. inspect status and diff;
2. confirm the files belong to the task;
3. run proportional verification;
4. check for secrets and generated artifacts;
5. record residual risk.
