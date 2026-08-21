---
name: engineering-philosophy
description: Govern cross-project engineering decisions and route ambiguous, cross-cutting, or global-versus-project rule questions to the smallest focused Skill. Use as an explicit engineering entrypoint; ordinary architecture, domain, testing, debugging, review, Git, and CI requests should go directly to their specialist.
license: AGPL-3.0-only
metadata:
  version: "0.2.0"
  category: "engineering-governance"
---

# Engineering Philosophy

## Use this skill when

Use this Skill as an explicit engineering governance and routing entrypoint when:

- the user asks for an overall engineering analysis;
- it is unclear which specialist Skill owns the decision;
- one request genuinely crosses several engineering concerns;
- a rule may belong in global philosophy rather than project-local guidance; or
- the process should be made lighter or heavier based on risk.

Most normal requests should activate the focused specialist directly. Do not make this Skill a mandatory prelude to architecture, domain modeling, testing, debugging, review, Git, or CI work.

Do not use it as a replacement for a project rule file, a framework manual, a detailed language guide, or a specialist Skill that already owns the primary decision.

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

## Routing behavior

Select the smallest set of Skills needed for the current decision. Use [routing-matrix.md](references/routing-matrix.md) for signal-to-owner guidance, secondary collaboration rules, and negative routing cases. The matrix is a decision aid, not a mandatory workflow: a tiny explicit change may need no planning Skill, and a cross-cutting request may need one primary plus one or two focused secondary Skills.

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
