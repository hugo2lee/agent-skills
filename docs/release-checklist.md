# Release Checklist

Use this checklist for a versioned Skill Suite release. The repository is distributed as source through `npx skills`; it is not an npm package.

## Before committing

- [ ] Confirm the working tree and isolate unrelated user changes.
- [ ] Keep the top-level Skill count at 11 unless the release explicitly changes that contract.
- [ ] Update `metadata.version` in every `skills/*/SKILL.md` when the release changes Skill behavior.
- [ ] Update the user-facing version and release notes in `README.md` and `CHANGELOG.md`.
- [ ] Add or update eval cases for every changed routing or engineering decision.
- [ ] Keep `engineering-philosophy` explicit-only unless there is a deliberate routing-policy decision; specialist Skills remain independently discoverable.

## Validation

- [ ] Install the repository validation dependencies: PyYAML and the `skills-ref` reference validator.
- [ ] Run `scripts/validate.sh`; confirm both `skills-ref` and repository-specific checks pass.
- [ ] Run `shellcheck scripts/*.sh`.
- [ ] Run `git diff --check`.
- [ ] Run `scripts/smoke-test-npx.sh` with a temporary `HOME`; confirm all 11 Skills are discovered and installed under the shared `~/.agents/skills` shape used by the Codex/Cline command.
- [ ] If routing changed, check the Chinese, English, mixed-language, and negative-case counts in `evals/routing/cases.yaml`.
- [ ] Review the actual diff for unrelated files, duplicated rules, and broken reference links.

## Version and history

- [ ] Make the implementation commit(s) atomic and explain behavior changes in the commit messages.
- [ ] Confirm `README.md`, `CHANGELOG.md`, all Skill metadata versions, and the intended tag use the same version.
- [ ] Push the commit to `master` only after local validation passes.
- [ ] Create an annotated Git tag such as `v0.2.0` on the exact release commit and push the tag.

## GitHub Release

- [ ] Create a GitHub Release from the exact tag.
- [ ] Use the matching version as the release title, for example `v0.2.0 — Reliable Routing & Distribution`.
- [ ] Summarize routing boundaries, validation, CI, distribution, and known limitations without claiming unverified agent behavior.
- [ ] Link to the installation command and the relevant changelog section.

## After release

- [ ] Run `npx skills@latest add hugo2lee/agent-skills --list` against the public repository.
- [ ] In a temporary HOME, run the global Codex/Cline installation command and verify all 11 expected `SKILL.md` files.
- [ ] Check the GitHub Actions workflow for the tag/commit and record any external-service failure separately from Skill validation.
- [ ] If post-release behavior contradicts a routing rule, record an observation and add an eval before promoting a global rule.
