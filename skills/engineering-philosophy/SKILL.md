---
name: engineering-philosophy
description: Apply a pragmatic, evidence-based engineering philosophy across design, implementation, testing, review, and delivery; keep global principles separate from project rules and route specialized decisions to focused Skills.
license: AGPL-3.0-only
metadata:
  version: "0.1.0"
  category: "engineering-governance"
---

# Engineering Philosophy

## Use this skill when

Use this Skill when a request asks how software should be designed, tested, reviewed, debugged, delivered, or improved across projects. Use it to choose a focused Skill and to decide whether a project lesson belongs in the global engineering philosophy.

Do not use it as a replacement for a project rule file, a framework manual, or a detailed language guide.

## Core principle

Prefer the simplest architecture that preserves meaningful boundaries.

Treat a boundary as meaningful only when it protects a real business responsibility, substitution point, independent test, protocol, deployment unit, ownership boundary, or source of change. Do not create abstractions merely because a type, function, service, or repository exists.

## Rule levels

Use these levels consistently:

- MUST: a stable engineering constraint. Violating it requires an explicit, high-quality reason.
- SHOULD: the default practice. A project may deviate when the reason, cost, and alternative are stated.
- CONDITIONAL: apply only when its trigger conditions are present. Never introduce a pattern by name alone.

For every important rule, explain:

1. Rule
2. Why
3. Do
4. Do not
5. Verification

## Global versus project rules

Keep cross-project principles here. Keep project-specific facts in the project:

- language or framework versions;
- database, message broker, or cloud provider choices;
- repository layout and team naming conventions;
- GitLab or other hosting workflow;
- domain-specific aggregates and terminology;
- mandatory test libraries and CI commands.

When a project rule conflicts with a global SHOULD, follow the explicit project rule and record the trade-off. Do not silently convert a local convention into a universal principle.

## Decision workflow

1. Clarify the user-visible outcome and constraints.
2. Identify the smallest meaningful boundary or feedback loop involved.
3. Choose the focused Skill that owns the decision.
4. Prefer the simplest design that preserves the boundary.
5. Make dependencies, assumptions, and verification evidence explicit.
6. Separate observed facts from hypotheses and preferences.
7. Before changing a global rule, check whether the lesson is repeated and generalizable.

Use this delivery chain when it fits the request:

spec-driven-development → planning-and-task-breakdown → incremental-implementation → test-driven-development → code-review-and-quality → git-workflow-and-versioning → ci-cd-and-automation

Route any observed failure to systematic-debugging. Route architecture and domain modeling questions to architecture-boundaries and ddd-lite respectively; those two Skills are peers, not layers of one mandatory architecture.

## Rule promotion

Do not promote an isolated workaround into global doctrine. Follow:

Observation → Repeated Pattern → Candidate Rule → Eval Case → Real-project Validation → Global Rule

A rule may be promoted when at least one of these is true:

- the same pattern appears in two independent projects;
- a high-cost incident yields a clear, general safeguard;
- repeated reviews identify the same failure mode.

Otherwise keep it as a project rule, ADR, or observation note.

Read [rule-lifecycle.md](references/rule-lifecycle.md) when changing the philosophy or promoting a rule. Read [global-vs-project.md](references/global-vs-project.md) when deciding where a rule belongs.

## Verification

Before declaring work complete, identify the evidence that supports the claim: test output, reproduction steps, review findings, build result, deployment check, or an explicit statement of remaining uncertainty.

Never claim that a design is correct merely because it compiles, follows a familiar pattern name, or resembles a diagram.
