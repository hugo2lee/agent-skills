# Change Planning Cases

Each case evaluates whether an approved requirement becomes an executable Change Plan grounded in repository evidence. The plan should name affected code and tests, reuse existing capabilities, order dependencies, expose risks, and keep every slice runnable and verifiable.

## CHG-001 — Repository impact analysis

**User request:** Add a `POST /orders/{id}/cancel` behavior that is already approved by the Requirement Contract.

**Necessary context:** The repository has an HTTP router, an order application service, a domain package, a SQL adapter, an event publisher, API contract tests, and CI checks. The plan currently says only “implement cancel.”

**Expected decision process:** Inspect entry points, callers, domain behavior, persistence, outbound events, configuration, existing tests, and automation. Map each affected boundary and identify what is unchanged before splitting work.

**Rules triggered:** Repository Analysis; impact map; evidence before task list.

**Allowed simplification:** For a small repository, record file/package paths and verification commands directly in the plan.

**Common errors:** Listing generic layers without reading the repository; planning a new service before checking the existing order service; ignoring event or contract tests.

**Prohibited overreach:** Do not include unrelated router cleanup or a full persistence rewrite.

**Acceptance criteria:** The plan names the relevant entry point, behavior owner, persistence/outbound impact, tests, automation, and no-change areas.

## CHG-002 — Reuse an existing capability

**User request:** Add an admin report showing overdue invoices.

**Necessary context:** A query service already computes overdue invoices for a scheduled reminder job, but its output is an internal summary and lacks the admin report’s pagination and authorization contract.

**Expected decision process:** Compare the existing capability’s inputs, filtering, authorization, output, and consistency semantics. Plan reuse of the domain/query logic where valid, with a separate presentation adapter or focused extension for the actual delta.

**Rules triggered:** Existing capability reuse; avoid duplicate behavior; boundary ownership.

**Allowed simplification:** Reuse the existing query directly if its contract and authorization are proven identical, documenting that evidence.

**Common errors:** Copying the SQL query; reusing an internal job entry point without checking authorization; refactoring both consumers at once.

**Prohibited overreach:** Do not create a generic reporting platform because one report has two consumers.

**Acceptance criteria:** The plan distinguishes what is reused, what must change, why a new boundary is needed if any, and how both consumers remain verified.

## CHG-003 — Dependency ordering and safety net

**User request:** Move order totals from a denormalized column to a calculated value.

**Necessary context:** Existing data uses the column, several reads depend on it, and there is no regression test for rounding or historical orders. The migration is intended to be backward compatible.

**Expected decision process:** Order discovery and baseline tests first; characterize current rounding and historical behavior; introduce the new calculation behind a safe path; compare old/new results; migrate reads; observe; remove the old path only after evidence.

**Rules triggered:** Dependency ordering; safety net before migration; incremental implementation.

**Allowed simplification:** If the data set is disposable and no released behavior depends on it, state the evidence that permits a shorter path.

**Common errors:** Dropping the column first; changing calculation and migration in one unverified step; postponing tests until after cutover.

**Prohibited overreach:** Do not combine the move with unrelated order schema cleanup.

**Acceptance criteria:** Every task has predecessors, a runnable checkpoint, and evidence required before the next migration step.

## CHG-004 — Architecture pressure analysis

**User request:** Add a second payment provider.

**Necessary context:** The current checkout service directly calls one provider SDK. A second provider is approved, provider error models differ, and two planned slices will select providers by merchant configuration.

**Expected decision process:** Derive the pressure from repeated provider variation and leaked protocol semantics. Plan the smallest consumer-owned payment capability, explicit injection at the composition root, provider adapters, and contract/integration verification.

**Rules triggered:** Business change -> demonstrated pressure -> architecture requirement -> smallest enabler; architecture-boundaries routing.

**Allowed simplification:** Keep the contract narrow and introduce only the adapter boundary required for the first provider-selection slice.

**Common errors:** Creating a platform-wide plugin framework; adding interfaces to every checkout type; treating provider count alone as a reason for a large rewrite.

**Prohibited overreach:** Do not add CQRS, event sourcing, or a service split without separate pressure.

**Acceptance criteria:** The plan states the pressure, contract owner, dependency direction, adapter translation point, composition-root change, and boundary tests.

## CHG-005 — Business change plus architecture enabler in one vertical slice

**User request:** Let merchants choose a payment provider for one new checkout flow.

**Necessary context:** The provider boundary from CHG-004 is not yet implemented. The business value is limited to the new flow; the old checkout flow must remain unchanged.

**Expected decision process:** Shape a vertical slice containing provider selection for the new flow, the minimum capability/adapter enabler, focused behavior tests, and a regression check for the old flow. Keep later provider migration out of the slice.

**Rules triggered:** Business Value + Just-enough Architecture + Verification; incremental vertical slice.

**Allowed simplification:** Use one real provider adapter and a deterministic fake for the new flow while deferring generalized configuration.

**Common errors:** Building all provider adapters first; implementing the abstraction with no user-visible slice; changing both old and new flows together.

**Prohibited overreach:** Do not make the entire checkout system provider-agnostic before the first slice proves the boundary.

**Acceptance criteria:** The slice is runnable, has a clear old/new compatibility boundary, and includes behavior and adapter verification.

## CHG-006 — Migration compatibility and risk

**User request:** Replace the legacy invoice API with a versioned endpoint.

**Necessary context:** External clients still use the legacy route; the new response changes a field from string to structured data. The release must support a transition period.

**Expected decision process:** Plan contract inventory, compatibility tests, new endpoint implementation, dual observation or translation as appropriate, client communication, deprecation criteria, and removal only after evidence. Identify rollback/stop conditions and data meaning risks.

**Rules triggered:** Migration compatibility; release behavior baseline; risk and dependency planning.

**Allowed simplification:** If all clients are controlled and can migrate atomically, document that evidence and shorten the compatibility path.

**Common errors:** Renaming the route and assuming compatibility; removing old tests; changing response meaning without mapping; omitting a removal condition.

**Prohibited overreach:** Do not force all clients to migrate in the same change unless that is an approved constraint.

**Acceptance criteria:** The plan identifies old/new contracts, coexistence strategy, compatibility tests, deprecation/removal evidence, and stop conditions.

## CHG-007 — Completion evidence

**User request:** “Implement the refund workflow.”

**Necessary context:** The approved contract defines accepted refund states, provider errors, idempotency, persistence changes, and a refund event. The draft plan has tasks but no completion conditions.

**Expected decision process:** Convert each task into a bounded outcome with dependencies, verification command or evidence, and a runnable checkpoint. Define final evidence for service behavior, persistence integration, outbound provider contract, inbound mapping if applicable, review, CI, and artifact identity.

**Rules triggered:** Completion criteria; evidence-driven planning; Gate 2 readiness.

**Allowed simplification:** Combine low-risk documentation checks into one task while keeping behavior and release evidence separate.

**Common errors:** Calling a task complete when code compiles; relying on coverage percentage; omitting idempotency or provider contract evidence.

**Prohibited overreach:** Do not require every private helper to have a separate test.

**Acceptance criteria:** A reviewer can determine exactly what “done” means and which evidence proves each meaningful behavior and boundary.

## CHG-008 — Evidence-driven plan evolution

**User request:** Implement the approved import flow according to the existing plan.

**Necessary context:** Repository analysis reveals that the planned parser cannot preserve a released timestamp format. A smaller adapter translation is sufficient, but it changes one task dependency and adds a compatibility check.

**Expected decision process:** Record the discovery, compare alternatives, update the plan and Feature Change Record, re-evaluate affected risks/gates, and continue with the smallest safe slice. Do not pretend the original plan was followed unchanged.

**Rules triggered:** Plan evolution; evidence and traceability; no silent drift.

**Allowed simplification:** Update the task list inline for a low-risk change and link the evidence; use a durable record for a compatibility-sensitive change.

**Common errors:** Continuing with the invalid parser; silently editing the plan; expanding into a parser rewrite; treating discovery as failure of planning itself.

**Prohibited overreach:** Do not redesign unrelated import formats because one timestamp boundary was exposed.

**Acceptance criteria:** The final plan shows what changed, why, the affected dependency/risk, new verification, and the gate that was rechecked.
