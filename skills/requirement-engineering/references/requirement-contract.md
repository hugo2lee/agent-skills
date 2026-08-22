# Requirement Contract

A Requirement Contract turns a request into observable behavior without pretending that every task needs a long specification. Use the smallest form that makes the intended change testable and the non-goals visible.

## Required thinking

- **Goal** — what user or business problem changes?
- **Inputs** — commands, events, data, permissions, or environmental conditions.
- **Outputs** — returned values, state changes, emitted facts, or user-visible results.
- **Observable behavior** — what a caller can observe on success.
- **Error behavior** — invalid input, conflicts, unavailable dependencies, and retry or idempotency semantics.
- **Scope** — the paths and behavior intentionally changed.
- **Acceptance criteria** — conditions that can be checked.
- **Non-goals** — tempting adjacent work explicitly excluded.

Use examples or tables when words such as “better”, “fast”, “support”, or “handle” hide multiple possible behaviors. A contract can be a few bullets in a task for a trivial change and a durable Feature Change Record for a cross-boundary feature.

## Quality test

Another engineer should be able to answer what to implement, what not to implement, how to test it, and which answer must come from the user. If two reasonable implementations still satisfy the text but have materially different user-visible effects, the contract is not ready for implementation.

## Relation to design

Define behavior before selecting Aggregate, interface, queue, cache, or workflow patterns. Architecture and domain modeling may expose new questions, but they must not silently invent product semantics.
