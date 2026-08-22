# Feature Change Record

Use this record when a change is large enough, risky enough, or cross-boundary enough that decisions must survive beyond the current chat. The recommended project-local location is `docs/changes/<feature-name>.md`; do not assume that every repository has a `docs/specs/` directory.

The record is a traceability artifact, not a second implementation plan. Keep it concise, link to source and tests, and update it when evidence changes a decision.

## Template

```markdown
# <Feature name>

## Requirement Clarification
- Problem:
- Desired outcome:
- Requester and date:
- Known constraints and open questions:

## Requirement Reconciliation
- Existing requirements:
- Existing implemented capabilities:
- Existing contracts and released behavior:
- Classification: New | Overlap | Duplicate | Compatible Extension | Conflict | Replacement
- Conflicts and user decisions:

## Approved Requirement Contract
- Goal:
- Inputs:
- Outputs:
- Observable behavior:
- Error behavior:
- Scope:
- Acceptance criteria:
- Non-goals:

## Repository Analysis
- Entry points and callers:
- Relevant services, domain objects, adapters, persistence, and tests:
- Existing capabilities to reuse:
- Automation and release paths:
- Evidence links or commands:

## Business Change / Impact Analysis
- Business change:
- Demonstrated change pressure:
- Derived architectural requirement:
- Smallest architectural enabler:
- Alternatives considered:

## Design Decisions
- Decision:
- Reason and trade-off:
- Rejected alternatives:

## Implementation Plan
1. Slice, dependency, and completion condition.
2. Slice, dependency, and completion condition.
- Risks and checkpoints:
- Verification commands:

## Incremental Implementation / Discovery Notes
- Implemented slices:
- Plan deviations and why:
- New evidence or unresolved uncertainty:

## Release Behavior Baseline
### Service Behavior Baseline
- Business input and output:
- Success and error semantics:
- State changes and important side effects:

### Persistence Integration Baseline
- Adapter and real storage behavior:
- Save/Load/Update/Transaction/Constraint/Mapping/Migration behavior, as applicable:

### Outbound Contract Baseline
- Port and adapter:
- Protocol/provider request, response, error, timeout, and retry semantics:

### Inbound Mapping Baseline
- Transport-to-command mapping:
- Result/error-to-transport mapping:

## Change Review / Gate 3
- Implementation runnable:
- Relevant behavior tests green:
- Applicable release baselines established:
- Requirement or plan deviations recorded:
- Feature Change Record updated when applicable:
- Review findings, severity, evidence, residual risk, and explicit follow-up:

## Verification
- Unit and behavior tests:
- Integration tests:
- Build, static checks, and CI evidence:
- Deployment or health checks:
- Residual risk:

## Release Traceability
- Source commit:
- Verified artifact:
- Version and tag:
- Release notes:
```

## Baseline guidance

The four baseline sections protect different contracts. A service behavior test does not prove that a real database adapter maps constraints correctly. An adapter test does not prove that an HTTP transport maps domain errors correctly. Keep the tests at the boundary that owns the behavior and avoid duplicating the entire business suite at every layer.

## Update rule

If a baseline fails and there is no authorized behavior change, fix the implementation or test setup. If the behavior is intentionally changed, update the requirement contract, reconciliation decision, record, baseline, and release notes together before calling the change complete.
