# Feature Change Lifecycle

Use the Feature Change Lifecycle to keep a meaningful feature change traceable from an uncertain request to released, executable behavior. The lifecycle is a decision aid, not a mandatory document ceremony. Gates protect decisions, not paperwork.

## Lifecycle

1. **User Request** — capture the user problem, desired outcome, known constraints, and the smallest useful scope.
2. **Requirement Clarification** — make the observable behavior, audience, inputs, outputs, errors, acceptance criteria, non-goals, and open questions explicit.
3. **Requirement Reconciliation** — compare the request with existing requirements, implemented capabilities, public contracts, and released behavior. Classify each overlap as new, compatible extension, duplicate, or conflict.
4. **User Decision Gate, when required** — ask the user only about decisions that materially change behavior, compatibility, cost, or scope. Record the decision and rejected alternatives.
5. **Approved Requirement Contract** — record the clarified and reconciled behavior that is authorized for implementation.
6. **Repository Analysis** — inspect the current repository, entry points, tests, persistence, outbound integrations, configuration, and automation before proposing a plan.
7. **Business Change / Impact Analysis** — connect the approved behavior to affected capabilities, callers, data, contracts, and operational impact.
8. **Architecture Pressure Analysis** — connect demonstrated change pressure to an architectural requirement and the smallest useful architectural enabler.
9. **Conditional architecture-boundaries / ddd-lite routing** — choose technical or domain modeling only when the corresponding pressure, invariant, or consistency need is present.
10. **Implementation Plan** — define vertical slices, dependencies, risks, checkpoints, completion conditions, and verification evidence.
11. **Incremental Implementation** — implement small runnable slices and record discoveries, deviations, and newly exposed constraints in the Feature Change Record.
12. **TDD / Focused Verification** — protect each accepted behavior with focused tests, regression tests, and relevant boundary checks.
13. **Release Behavior Baseline** — establish or update the applicable executable baselines across service behavior, persistence integration, outbound contracts, and inbound mappings before review.
14. **Change Review / Gate 3** — confirm that the implementation is runnable, relevant behavior tests are green, applicable baselines exist, requirement or plan deviations are recorded, and the Feature Change Record is updated when applicable; then compare the requirement, plan, actual diff, tests, baselines, and remaining uncertainty.
15. **CI / Artifact / Release Verification / Gate 4** — verify the exact artifact, required checks, deployment health, and rollback or stop conditions before publishing.
16. **Version / Tag / Release** — publish only the verified artifact with traceable version, tag, release notes, and release evidence.

## Four proportional gates

### Gate 1 — Requirement Approved

The behavior contract is clear enough to implement, conflicts with existing behavior are resolved or explicitly accepted, non-goals are visible, and any material user decision is recorded. A one-line typo may satisfy this gate inline; a compatibility-sensitive feature may need a durable record.

### Gate 2 — Ready for Implementation

The repository has been inspected, existing capabilities and reuse opportunities are known, the change pressure and architectural enablers are explicit, and the plan has slices, dependencies, risks, verification, and completion conditions.

### Gate 3 — Ready for Review

The implementation is runnable, relevant behavior tests are green, applicable release baselines have been established, requirement and plan deviations are recorded, the Feature Change Record is updated when applicable, and the diff can be compared against the approved contract without unresolved silent changes.

### Gate 4 — Ready for Release

The release candidate is the artifact that was verified, required quality gates pass, release baselines are protected or intentionally updated, deployment health is checked, and failure or rollback conditions are known.

## Proportionality

For a trivial, isolated change, the contract and gate evidence can live in the task or commit. For a cross-boundary or compatibility-sensitive feature, use a durable record such as `docs/changes/<feature-name>.md`. Do not create a full record merely because a Skill mentions one; create enough evidence to make the decision reproducible.

## Anti-drift rule

When implementation evidence invalidates the plan, update the record and re-evaluate the affected gate. Do not quietly change observable behavior, compatibility, architecture, or scope and then describe the original plan as complete.

## Routing

Use `requirement-engineering` for contract and reconciliation, `change-planning` for repository analysis and executable planning, `architecture-boundaries` or `ddd-lite` for the demonstrated design pressure, `incremental-implementation` for slice sequencing, `test-driven-development` for new behavior, `systematic-debugging` for actual failures, `code-review-and-quality` for Gate 3, and `ci-cd-and-automation` with `git-workflow-and-versioning` for Gate 4.
