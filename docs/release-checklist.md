# Release Checklist

Use this checklist for a versioned Skill Suite release. The repository is distributed as source through `npx skills`; it is not an npm package.

## v0.4.0 scope

- [ ] Confirm the working tree is clean of unrelated user changes and keep Phase 1 separate from any project-specific implementation.
- [ ] Keep exactly 12 active top-level Skills, with the intended published surface recorded in `skills/registry.yaml`.
- [ ] Confirm `VERSION` is `0.4.0` and all Skill metadata, registry entries, README, and CHANGELOG versions agree.
- [ ] Confirm `knowledge-compilation` is the single new top-level Skill; do not split knowledge governance into adjacent duplicate Skills.
- [ ] Confirm Source, Reference, Evidence, Decision, Generated Artifact, and Skill classification is documented.
- [ ] Confirm provenance, canonical-source precedence, conflict surfacing, redaction, write scope, and project/global promotion gates are documented.
- [ ] Confirm candidate, active, deprecated, and archived lifecycle semantics are documented and generation is not activation.
- [ ] Confirm `skills/registry.yaml` and the filesystem Skill set agree, with no fixed 12-name validator list.
- [ ] Add or update specialist routing cases and at least 8 `knowledge-compilation` cases plus 30 knowledge lifecycle cases.
- [ ] Confirm `engineering-philosophy` contains no project-specific paths, facts, credentials, or local project rules.
- [ ] Do not create a universal crawler, bot, RAG platform, automatic global promotion, or project-specific executor in v0.4.0.
- [ ] Do not create the v0.4.0 tag or GitHub Release until the feature branch is approved and all gates pass.

## Historical v0.3.0 scope

- [ ] Confirm the working tree and isolate unrelated user changes.
- [ ] Keep exactly 11 top-level Skills.
- [ ] Confirm the public repository identity is `hugo2lee/engineering-philosophy`.
- [ ] Confirm `VERSION` is `0.3.0` and all Skill metadata versions agree.
- [ ] Confirm `requirement-engineering` and `change-planning` replace the two v0.2.x names.
- [ ] Confirm the Feature Change Lifecycle, four proportional gates, and Feature Change Record are documented.
- [ ] Confirm repository analysis, architecture pressure/enabler, and four release baseline references are present and linked.
- [ ] Add or update eval cases for changed routing and lifecycle decisions, including the 30 lifecycle cases.
- [ ] Keep `engineering-philosophy` explicit-only; specialist Skills remain independently discoverable.
- [ ] Confirm the applicable Release Behavior Baseline is established before Gate 3 change review.
- [ ] Confirm the v0.2.x released CHANGELOG history was restored and not rewritten for current branding.
- [ ] Confirm `skills/architecture-boundaries/references/languages/cpp.md` is present and linked without creating a C++ top-level Skill.
- [ ] Confirm `requirement-engineering` specialist evals use `REQ-*` IDs and v0.3 semantic cases.
- [ ] Confirm `change-planning` specialist evals use `CHG-*` IDs and v0.3 semantic cases.
- [ ] Confirm README, deploy, and npx smoke-test path terminology distinguishes native Agent paths from current npx CLI behavior.
- [ ] Do not create a C++ Skill, additional top-level Skill, v0.3.0 tag, or GitHub Release until the release commit is approved.

## Before committing

- [ ] Compare Requirement Contract, reconciliation result, repository analysis, Change Plan, actual diff, and Feature Change Record.
- [ ] Confirm architecture changes are tied to demonstrated change pressure and a smallest useful enabler.
- [ ] Confirm business and architectural work is represented as runnable vertical slices.
- [ ] Confirm service, persistence, outbound, and inbound baselines are protected or intentionally updated.
- [ ] Establish applicable Release Behavior Baselines before Gate 3 review.
- [ ] Confirm Gate 3 requires a runnable implementation, green relevant behavior tests, recorded requirement/plan deviations, and an updated Feature Change Record when applicable.
- [ ] Confirm no silent plan drift, unapproved behavior change, or baseline weakening remains.

## Validation

- [ ] Install PyYAML and the `skills-ref` reference validator.
- [ ] Run `scripts/validate.sh`; confirm the registry-discovered Skill set, metadata, references, routing, lifecycle evals, and version consistency pass.
- [ ] Run `shellcheck scripts/*.sh`.
- [ ] Run `bash -n scripts/*.sh`.
- [ ] Run `git diff --check`.
- [ ] Run `scripts/smoke-test-npx.sh` with a temporary HOME; confirm every registry Skill is discovered and installed without stale renamed directories.
- [ ] Run `scripts/deploy.sh --dry-run` with temporary roots; confirm there are no writes.
- [ ] Run a real temporary-root deployment and repeat it to verify idempotence.
- [ ] Create an unmanaged same-named target directory and confirm deployment stops without `--force`; test explicit `--force` takeover only in a temporary root.
- [ ] Confirm the Codex system Skill directory is never touched.
- [ ] Review Go examples and references for readability and compilation or explicit pseudocode labeling.

## Version and history

- [ ] Make implementation commits atomic and explain behavior changes.
- [ ] Confirm `README.md`, `CHANGELOG.md`, `VERSION`, all Skill metadata, and the intended tag use the same version.
- [ ] Review the exact commit and CI result before merging to the release branch.
- [ ] Keep `v0.1.0`, `v0.2.0`, and `v0.2.1` immutable.
- [ ] Create an annotated `v0.3.0` tag only on the approved release commit.

Suggested release command after the final commit and successful CI:

```sh
git tag -a v0.3.0 <release-commit> \
  -m "v0.3.0 — Evidence-Driven Feature Lifecycle"
git push origin v0.3.0
```

## Repository identity

- [ ] Verify the GitHub repository is named `engineering-philosophy`.
- [ ] Update existing clones with `git remote set-url origin git@github.com:hugo2lee/engineering-philosophy.git`.
- [ ] Verify `npx skills@latest add hugo2lee/engineering-philosophy --list` against the public repository.

## GitHub Release

- [ ] Confirm the tag matches `vMAJOR.MINOR.PATCH`; pushing it starts the release workflow.
- [ ] Confirm the tag's validation job passes all Skill validation, ShellCheck, and npx smoke checks.
- [ ] Confirm the dependent publish job creates a non-draft latest release from the same tag.
- [ ] Confirm generated notes contain the intended user-visible changes and known limitations.
- [ ] If the release job lacks `contents: write`, update workflow permissions and use a new tag; do not reuse or move an existing published tag.

## After release

- [ ] Run `npx skills@latest add hugo2lee/engineering-philosophy --list` against the public repository.
- [ ] In a temporary HOME, run the global installation command and verify every registry Skill has an expected `SKILL.md` file.
- [ ] Run `npx skills@latest ls -g` and confirm the renamed Skills are present and the old names are absent.
- [ ] Check the GitHub Actions workflow for the tag/commit and record any external-service failure separately from Skill validation.
- [ ] If post-release behavior contradicts a routing or philosophy rule, record an observation and add an eval before promoting a global rule.
