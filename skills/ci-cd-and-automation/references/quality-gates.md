# Quality Gates

Choose a gate for a failure class:

- formatting and static analysis for obvious structural errors;
- unit tests for local behavior;
- integration tests for real persistence and protocol translation;
- build and packaging checks for artifact integrity;
- deployment checks for runtime health.

Run cheap deterministic gates early. Keep slower checks for changes that need them. A gate must produce enough output to diagnose failure and should not silently become an unowned bottleneck.
