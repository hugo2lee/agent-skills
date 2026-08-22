# Feature Change Lifecycle

Use the Feature Change Lifecycle to keep a meaningful feature change traceable from an uncertain request to released, executable behavior. The lifecycle is a decision aid, not a mandatory document ceremony. Gates protect decisions, not paperwork.

## Lifecycle

1. **Request** — capture the user problem, desired outcome, known constraints, and the smallest useful scope.
2. **Requirement Contract** — define observable inputs, outputs, error behavior, acceptance criteria, non-goals, and unresolved product decisions.
3. **Requirement Reconciliation** — compare the request with existing requirements, implemented capabilities, public contracts, and released behavior. Classify each overlap as new, compatible extension, duplicate, or conflict.
4. **User Decision Gate** — ask the user only about decisions that materially change behavior, compatibility, cost, or scope. Record the decision and rejected alternatives.
5. **Repository Analysis** — inspect the current repository, entry points, tests, persistence, outbound integrations, configuration, and automation before proposing a plan.
6. **Change Analysis** — connect the requested business change to demonstrated change pressure, an architectural requirement, and the smallest useful architectural enabler.
7. **Implementation Plan** — define vertical slices, dependencies, risks, checkpoints, completion conditions, and verification evidence.
8. **Implementation and Discovery** — implement in small runnable increments. Record discoveries, deviations, and newly exposed constraints in the Feature Change Record.
9. **Review Gate** — compare the requirement, plan, actual diff, tests, release baselines, and remaining uncertainty. Planned evolution is allowed when it is recorded; silent drift is not.
10. **Release Baseline** — freeze important released behavior as executable baselines across service behavior, persistence integration, outbound contracts, and inbound mappings.
11. **Release Gate** — verify the exact artifact, required checks, deployment health, and rollback or stop conditions before publishing.

## Four proportional gates

### Gate 1 — Requirement Approved

The behavior contract is clear enough to implement, conflicts with existing behavior are resolved or explicitly accepted, non-goals are visible, and any material user decision is recorded. A one-line typo may satisfy this gate inline; a compatibility-sensitive feature may need a durable record.

### Gate 2 — Ready for Implementation

The repository has been inspected, existing capabilities and reuse opportunities are known, the change pressure and architectural enablers are explicit, and the plan has slices, dependencies, risks, verification, and completion conditions.

### Gate 3 — Ready for Review

The implementation is runnable, the Feature Change Record reflects discoveries and plan evolution, behavior tests and required integration baselines exist, and the diff can be compared against the approved contract without unresolved silent changes.

### Gate 4 — Ready for Release

The release candidate is the artifact that was verified, required quality gates pass, release baselines are protected or intentionally updated, deployment health is checked, and failure or rollback conditions are known.

## Proportionality

For a trivial, isolated change, the contract and gate evidence can live in the task or commit. For a cross-boundary or compatibility-sensitive feature, use a durable record such as `docs/changes/<feature-name>.md`. Do not create a full record merely because a Skill mentions one; create enough evidence to make the decision reproducible.

## Anti-drift rule

When implementation evidence invalidates the plan, update the record and re-evaluate the affected gate. Do not quietly change observable behavior, compatibility, architecture, or scope and then describe the original plan as complete.

## Routing

Use `requirement-engineering` for contract and reconciliation, `change-planning` for repository analysis and executable planning, `architecture-boundaries` or `ddd-lite` for the demonstrated design pressure, `incremental-implementation` for slice sequencing, `test-driven-development` for new behavior, `systematic-debugging` for actual failures, `code-review-and-quality` for Gate 3, and `ci-cd-and-automation` with `git-workflow-and-versioning` for Gate 4.
