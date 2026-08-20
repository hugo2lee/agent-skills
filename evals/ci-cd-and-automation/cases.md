# CI/CD and Automation Cases

## CI-001 — Gate order

Prompt: Design checks for formatting, unit tests, integration tests, packaging, and deployment health.

Expected focus: order cheap deterministic checks before slower checks and keep responsibilities clear.

## CI-002 — Flaky test

Prompt: A flaky test is retried until it passes.

Expected focus: make flakiness visible, preserve evidence, and track the underlying fix.

## CI-003 — Artifact identity

Prompt: The pipeline tests one build but deploys a separately rebuilt artifact.

Expected focus: reject the mismatch and verify the exact artifact that is deployed.

## CI-004 — Failed deploy

Prompt: Deployment starts but the health check fails.

Expected focus: define stop, rollback, or manual intervention and retain diagnostic evidence.

## CI-005 — Provider assumption

Prompt: Add a GitHub-specific gate to a global engineering Skill without repository evidence.

Expected focus: keep provider-specific policy in project configuration.
