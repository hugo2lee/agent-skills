# Requirement Engineering Cases

Each case evaluates whether the request is converted into a proportional, observable Requirement Contract before implementation. The evaluator should distinguish clarification from solution design and should preserve user decisions when existing behavior or release promises are affected.

## REQ-001 — Ambiguous outcome

**User request:** “Make notifications better.”

**Necessary context:** The repository already sends email notifications, but the request does not identify the audience, trigger, delivery expectation, failure behavior, or success measure.

**Expected decision process:** Ask for the observable user problem and the smallest useful outcome. Capture audience, trigger, delivery and error behavior, acceptance criteria, non-goals, constraints, and any unresolved product decision before proposing a queue, provider, or redesign.

**Rules triggered:** Requirement Contract; requirement clarification; no implementation-first design.

**Allowed simplification:** For a small follow-up, keep the contract in the task rather than creating a durable document.

**Common errors:** Choosing a message broker; assuming “better” means faster; treating a technology choice as acceptance criteria.

**Prohibited overreach:** Do not introduce a notification platform, provider migration, or broad template rewrite without an approved behavior.

**Acceptance criteria:** The response identifies missing observable behavior and ends with a bounded contract or focused questions, not an invented architecture.

## REQ-002 — Proportional trivial change

**User request:** Fix a spelling mistake in the public README.

**Necessary context:** The target line and correct spelling are unambiguous; no generated file, API, behavior, or release contract changes.

**Expected decision process:** Use a lightweight contract: exact file/line, intended text, non-goal of unrelated wording cleanup, and a direct diff or link check.

**Rules triggered:** Proportionality; scope and non-goals; focused verification.

**Allowed simplification:** Skip a formal reconciliation record and full lifecycle ceremony because the change is isolated and low risk.

**Common errors:** Requesting a complete domain model; expanding into a README rewrite; skipping verification because the edit looks obvious.

**Prohibited overreach:** Do not create a new Skill, architecture layer, or release baseline for the spelling correction.

**Acceptance criteria:** The response is concise, bounded, and names a concrete verification for the exact documentation change.

## REQ-003 — Overlap with an existing capability

**User request:** Add a “customer export” command.

**Necessary context:** Repository analysis shows an existing admin export can already produce the same customer fields, but it is reachable only through an internal HTTP endpoint.

**Expected decision process:** Compare requested behavior with the existing capability. Classify the request as **Overlap**, identify the missing entry point or user authorization behavior, and prefer a thin extension or reuse if it satisfies the contract.

**Rules triggered:** Requirement Reconciliation; existing-capability comparison; reuse before duplication.

**Allowed simplification:** Treat the command as a new adapter over the existing capability when output, authorization, and failure semantics are unchanged.

**Common errors:** Creating a second export service; calling it a duplicate without checking the access and contract differences; ignoring authorization.

**Prohibited overreach:** Do not refactor the entire export subsystem merely because a new entry point is needed.

**Acceptance criteria:** The response states the overlap classification, the behavior delta, and whether reuse or a new capability is justified.

## REQ-004 — Duplicate capability

**User request:** Build a new “account lookup” endpoint that returns account status by ID.

**Necessary context:** A released endpoint already returns the same status, error semantics, authorization, and latency contract at the requested boundary.

**Expected decision process:** Classify the request as **Duplicate** and ask whether the user actually wants a different contract, route, audience, or compatibility promise. Recommend reuse or redirecting the request to the existing endpoint.

**Rules triggered:** Requirement Reconciliation; duplicate detection; avoid parallel implementations.

**Allowed simplification:** A short comparison table is enough when the contracts are demonstrably identical.

**Common errors:** Treating a different route name as a new business capability; duplicating tests and persistence access; assuming a new handler is harmless.

**Prohibited overreach:** Do not create a second repository query or service only to satisfy the word “new.”

**Acceptance criteria:** The response does not plan implementation until the duplicate classification and any real delta are resolved.

## REQ-005 — Compatible extension

**User request:** Add an optional `locale` field to invoice emails while preserving current recipients and subject lines.

**Necessary context:** Existing email behavior is released and covered by a baseline. The field changes rendering for callers that opt in but has a defined default for existing callers.

**Expected decision process:** Classify the request as **Compatible Extension**. Define the opt-in/default behavior, rendering acceptance cases, unchanged behavior for existing callers, and baseline coverage for both paths.

**Rules triggered:** Requirement Reconciliation; compatibility; released behavior baseline.

**Allowed simplification:** Keep the default behavior in the existing contract and add only the new opt-in cases.

**Common errors:** Treating every field addition as a breaking change; changing the default template; updating the baseline without an explicit behavior statement.

**Prohibited overreach:** Do not introduce a template engine or notification abstraction unless the repository shows actual pressure.

**Acceptance criteria:** The contract makes old and new observable behavior explicit and identifies the baseline tests that protect both.

## REQ-006 — Conflict with released behavior

**User request:** “Stop retrying failed payments immediately.”

**Necessary context:** The released payment contract retries transient provider failures twice, and merchants rely on the current attempt semantics. The request does not say whether this is a product change or a local incident workaround.

**Expected decision process:** Classify the request as **Conflict** with released behavior. Present the current promise, the proposed behavior, affected compatibility and risk, and ask for an authorized decision before weakening the baseline.

**Rules triggered:** Requirement Reconciliation; User Decision Gate; baseline protection.

**Allowed simplification:** If the user confirms a temporary incident flag, record its scope and expiry without redesigning payment orchestration.

**Common errors:** Deleting retry tests; changing configuration silently; treating a failing provider as proof that the released contract is wrong.

**Prohibited overreach:** Do not implement the behavior change or rewrite the baseline without the decision.

**Acceptance criteria:** The response stops at a decision gate and names the requirement, baseline, implementation, and release-note updates required after approval.

## REQ-007 — Explicit breaking replacement

**User request:** Replace the legacy customer status values `pending` and `active` with `trial` and `paid`.

**Necessary context:** Existing clients, stored records, and reports consume the old values. The requester says the new lifecycle is the desired long-term model but does not define migration or compatibility timing.

**Expected decision process:** Classify the request as **Replacement**. Define the new semantics, mapping, compatibility window, data migration, client contract, deprecation and removal conditions, and explicit acceptance for old records and mixed versions.

**Rules triggered:** Requirement Reconciliation; breaking-change scope; compatibility and migration decisions.

**Allowed simplification:** If the user confirms an offline one-time migration with no supported old clients, use a smaller contract while retaining evidence for records and rollback/stop conditions.

**Common errors:** Renaming constants only; assuming old data has no consumers; mixing migration, cleanup, and unrelated reporting changes.

**Prohibited overreach:** Do not choose a dual-write or event-sourcing migration by default.

**Acceptance criteria:** The response makes replacement consequences visible and does not call the change approved until compatibility decisions are resolved.

## REQ-008 — User decision gate with two valid outcomes

**User request:** “When a user deletes an account, should invoices remain downloadable?”

**Necessary context:** Both retaining invoices for legal/audit reasons and removing them for privacy minimization are plausible. Existing requirements and released behavior do not decide the policy.

**Expected decision process:** Explain the competing product outcomes and trade-offs, ask the user to choose the retention policy, and record the decision before defining deletion behavior, authorization, storage handling, and acceptance tests.

**Rules triggered:** User Decision Gate; do not disguise product policy as an architecture choice.

**Allowed simplification:** Present two concise options with consequences rather than writing a complete specification before the decision.

**Common errors:** Picking the “safer” policy silently; deciding based only on database convenience; jumping to soft delete or encryption.

**Prohibited overreach:** Do not implement either retention policy or add compliance infrastructure without the product decision and applicable constraints.

**Acceptance criteria:** The response clearly separates the unresolved product decision from subsequent technical choices and records the selected/rejected option.
