# Changelog

## v0.2.0 - Reliable Routing & Distribution

### Added

- Added an explicit-only `engineering-philosophy` governance and routing entrypoint.
- Added discriminating discovery descriptions for all 11 Skills, with primary decision ownership and exclusions.
- Added `skills/engineering-philosophy/references/routing-matrix.md` with primary, secondary, forbidden, and escalation guidance.
- Added 30 machine-readable routing eval cases with 12 Chinese, 12 English, and 6 mixed-language prompts, including negative routing cases.
- Added the C++ boundary realization reference under `architecture-boundaries` without creating a C++ top-level Skill.
- Added a GitHub Actions validation workflow and an isolated `npx skills` discovery/installation smoke test.
- Added a maintainer release checklist covering validation, versioning, tags, GitHub Releases, and post-release installation verification.

### Changed

- Bumped all Skill metadata versions to `0.2.0`.
- Made `skills-ref` the standards-level validator and retained repository-specific validation plus the bundled skill-creator check as supplemental coverage.
- Made `~/.agents/skills` the default shared Codex/Cline destination in `deploy.sh`; explicit root flags remain available for legacy or isolated layouts.
- Reframed `deploy.sh` as a maintainer local-development helper while making `npx skills@latest` the ordinary user installation path.
- Reworked the README around quick start, routing, verification, updates, contributor workflow, and releases.

### Design intent

This release improves selection and distribution reliability without increasing the 11-Skill surface area. The routing matrix is guidance rather than a mandatory full workflow, and negative cases protect against activating DDD, architecture, planning, or delivery ceremony from incidental keywords alone.

## v0.1.0 - Initial Skill Suite

### Added

- Added engineering-philosophy as the governance and routing entrypoint.
- Added architecture-boundaries with pragmatic Ports and Adapters, dependency inversion, explicit dependency injection, test seams, and Go references.
- Added ddd-lite with invariant-first modeling and conditional DDD decisions.
- Added test-driven-development with a behavior-first Red-Green-Refactor loop.
- Added systematic-debugging with reproduction, evidence, hypotheses, minimal fixes, and regression verification.
- Added spec-driven-development, planning-and-task-breakdown, and incremental-implementation for the front half of the delivery workflow.
- Added code-review-and-quality, git-workflow-and-versioning, and ci-cd-and-automation for the delivery and verification stages.
- Added independent eval cases for every Skill.
- Added static validation and safe copy-based deployment scripts for Cline, Codex, and OpenClaw.

### Design intent

This release establishes a portable personal engineering baseline. It favors meaningful boundaries over mechanical abstractions, conditional use of heavyweight patterns, explicit verification, and small reversible changes.

The suite intentionally does not include C++, security-hardening, observability, documentation-and-ADRs, or an Agent-specific automatic eval runner.
