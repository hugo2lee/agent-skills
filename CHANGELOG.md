# Changelog

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
