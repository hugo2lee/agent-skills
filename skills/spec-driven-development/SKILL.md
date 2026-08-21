---
name: spec-driven-development
description: Clarify an ambiguous or risky engineering request into a problem statement, constraints, acceptance criteria, non-goals, decisions, and open questions before implementation. Do not make full specification ceremony mandatory for small, explicit edits or task scheduling.
license: AGPL-3.0-only
metadata:
  version: "0.2.0"
  category: "planning"
---

# Spec-Driven Development

## Use this skill when

Use this Skill when a request has ambiguity, multiple stakeholders, meaningful risk, a new behavior, a migration, or acceptance criteria that need to be made explicit.

Use a lightweight specification for simple, obvious changes. Do not create ceremony when the desired behavior and verification are already clear.

## Specify before building

Write down:

- the user or system problem;
- the desired outcome;
- constraints and invariants;
- acceptance criteria;
- explicit non-goals;
- risks and unknowns;
- decisions that require user input;
- evidence that will prove completion.

Separate facts discovered from the repository, assumptions made for progress, and preferences that need confirmation.

## MUST

- State what success looks like in observable terms.
- Keep non-goals visible so the implementation does not expand silently.
- Identify missing information that materially changes the result.
- Preserve the user's authorization and scope.
- Define verification before claiming the work is complete.

## SHOULD

- Prefer examples and edge cases over vague adjectives.
- Keep specifications proportional to risk and complexity.
- Record alternatives only when they affect the decision.
- Let the specification expose boundary, dependency, and migration risks.

## Do not

- turn implementation details into requirements without evidence;
- invent product decisions to avoid asking for necessary input;
- write a specification that merely restates a solution;
- force a long document on a one-line safe change.

Read [requirements-and-acceptance.md](references/requirements-and-acceptance.md) for behavior language and [scope-and-non-goals.md](references/scope-and-non-goals.md) for boundary control.

## Routing

Route a sufficiently clear specification to planning-and-task-breakdown. Route design boundaries to architecture-boundaries or ddd-lite. Route implementation feedback to test-driven-development and failures to systematic-debugging.

## Verification

A specification is ready when another engineer can identify the goal, constraints, non-goals, decisions, and acceptance checks without guessing product intent.
