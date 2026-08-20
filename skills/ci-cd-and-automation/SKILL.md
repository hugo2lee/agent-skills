---
name: ci-cd-and-automation
description: Design and verify proportional CI/CD quality gates, builds, tests, release checks, and failure handling without confusing pipeline success with product correctness.
license: AGPL-3.0-only
metadata:
  version: "0.1.0"
  category: "delivery"
---

# CI/CD and Automation

## Use this skill when

Use this Skill when adding or changing automated checks, build pipelines, release workflows, deployment verification, or failure handling.

Do not invent provider-specific configuration without repository evidence. Keep project-specific commands in project rules or pipeline files.

## Quality-gate sequence

1. Define the behavior or artifact the pipeline must protect.
2. Identify the cheapest reliable check for each failure class.
3. Run fast feedback first, then slower integration or release checks.
4. Preserve actionable logs and artifacts on failure.
5. Verify the built artifact and deployment target, not only the source checkout.
6. Define stop, retry, rollback, or manual intervention conditions.
7. Keep the pipeline proportional to the risk.

## MUST

- Keep required checks deterministic enough to diagnose.
- Fail when a required quality gate fails.
- Preserve evidence that explains a failed job.
- Verify the artifact produced by the pipeline.
- Define what happens after a failed deployment or health check.
- Keep secrets and environment-specific policy out of general Skill instructions.

## SHOULD

- Run fast unit and static checks before slower integration checks.
- Cache only when cache invalidation cannot hide failures.
- Separate build, test, package, deploy, and post-deploy verification responsibilities.
- Make flaky checks visible and track their removal.
- Prefer a reversible rollout when the failure cost is high.

## Do not

- treat a green pipeline as proof of all business correctness;
- add a quality gate that nobody can diagnose;
- hide failures through retries without measuring the underlying cause;
- deploy an artifact different from the one verified;
- encode a project-specific provider assumption as a global rule.

Read [quality-gates.md](references/quality-gates.md) for check design and [release-verification.md](references/release-verification.md) for artifact and deployment verification.

## Routing

Use code-review-and-quality to inspect pipeline changes. Use git-workflow-and-versioning for release history. Use systematic-debugging for failed jobs or deployments.

## Verification

A pipeline change is complete when the required checks, failure evidence, artifact identity, deployment verification, and rollback or stop conditions are demonstrably defined.
