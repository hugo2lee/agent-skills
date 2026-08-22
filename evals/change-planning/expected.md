# Change Planning Expected Outcomes

## CHG-001

- Inspect and map repository entry points, behavior owners, persistence, outbound effects, tests, configuration, and automation.
- Name affected and intentionally unchanged areas.
- Split work only after evidence establishes the impact surface.

## CHG-002

- Compare the existing capability’s contract, authorization, output, and consistency semantics with the requested report.
- Reuse proven behavior and isolate only the real presentation or contract delta.
- Avoid duplicating queries or building a general platform without pressure.

## CHG-003

- Establish characterization and regression evidence before changing storage or calculation paths.
- Order migration steps so each checkpoint remains runnable and old-path removal follows proof.
- Keep unrelated schema cleanup out of scope.

## CHG-004

- Derive the architecture requirement from repeated provider variation and protocol leakage.
- Use a narrow consumer-owned capability, explicit injection, composition-root wiring, and provider adapters.
- State the smallest enabler and its contract/integration verification.

## CHG-005

- Combine the new business behavior, minimum provider boundary, and verification into one vertical slice.
- Preserve the old flow with a regression check.
- Defer generalized provider infrastructure until further pressure is demonstrated.

## CHG-006

- Inventory old and new contracts and plan a compatibility window, translation/coexistence strategy, deprecation, removal, and rollback/stop conditions.
- Protect response meaning with compatibility and release-baseline tests.
- Do not treat a route rename as a safe migration.

## CHG-007

- Give every meaningful task dependencies, a completion condition, and explicit verification evidence.
- Cover service, persistence, outbound, inbound, review, CI, and artifact evidence where applicable.
- Do not equate compilation or coverage percentage with completed behavior.

## CHG-008

- Record new evidence and update the plan, risk, dependency, Feature Change Record, and affected gate.
- Choose the smallest safe adjustment rather than hiding drift or launching an unrelated rewrite.
- Make the final plan explain what changed, why, and how it was re-verified.
