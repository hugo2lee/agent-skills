# Requirement Reconciliation

Every non-trivial new request is compared with the system that already exists. Reconciliation prevents a feature from being planned as new when the capability already exists, or from silently weakening a released contract.

## Compare four sources

1. Existing requirement documents, decisions, and non-goals.
2. Implemented behavior, entry points, tests, configuration, and integrations.
3. Public or internal contracts, including persistence and transport semantics.
4. Released behavior baselines and versioned release notes.

## Classification

- **New** — no relevant behavior or contract exists.
- **Overlap** — the request touches an existing capability and needs a precise delta.
- **Duplicate** — the requested behavior already exists; verify rather than reimplement.
- **Compatible Extension** — the request adds behavior while preserving the existing contract.
- **Conflict** — the request contradicts an existing requirement or baseline and needs an explicit decision.
- **Replacement** — the old behavior is intentionally retired or changed with migration and release evidence.

## Decision rule

Do not resolve a material conflict by guessing. Present the alternatives, compatibility impact, migration cost, and affected baselines, then ask the user for the decision. Once decided, record the choice and rejected alternative so implementation and review have a stable reference.

## Evidence

Record concrete paths, symbols, tests, commands, or release identifiers. “The repository seems to use…” is a hypothesis until confirmed. If a behavior cannot be found, state the search and the uncertainty instead of treating absence of evidence as evidence of absence.
