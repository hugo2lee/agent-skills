# CI/CD and Automation Expected Outcomes

## CI-001

- Order fast deterministic checks before slower integration, packaging, and deployment checks.
- Keep each gate diagnosable.

## CI-002

- Do not hide flakiness behind retries.
- Preserve evidence and track the underlying fix.

## CI-003

- Build, test, and deploy the same artifact identity.

## CI-004

- Stop safely and define rollback or manual intervention.
- Preserve health-check evidence.

## CI-005

- Keep provider-specific policy in project configuration, not the global Skill.

