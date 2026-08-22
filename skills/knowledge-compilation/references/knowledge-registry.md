# Knowledge Registry Contract

The registry is a machine-readable index of project or repository knowledge.
It is not a second source of truth for behavior. It records ownership,
provenance, lifecycle, scope, verification, generation, and routing
relationships.

## Minimal shape

```yaml
schema_version: "1"

artifacts:
  - id: example-api-reference
    path: docs/api.md
    type: reference
    status: active
    scope: project
    owner: example-team
    provenance:
      canonical_sources:
        - api/example.proto
      commit: abc123
    verification:
      commands:
        - make test-example
      last_verified_commit: abc123
      last_verified_at: "2026-08-22T00:00:00Z"
    related_skills:
      - example-development
```

Source artifacts may omit `canonical_sources` when the source itself is the
authority. Derivative artifacts (`reference`, `evidence`, `decision`,
`generated`, and `skill`) must identify canonical or explicitly external
sources. Generated artifacts additionally record `generation.generated_from`,
the generator `version`, and a reproducible `command` when available.

Verification may contain commands plus `last_verified_commit` and
`last_verified_at`. Unverified or stale historical records may retain missing
commands, but their status must make that limitation visible.

Organization and global scope require a reviewed, approved `promotion` record
with evidence references. Project scope is the default and does not need
promotion evidence.

`owner` identifies the maintenance responsibility and `scope` identifies the
lifecycle or promotion scope. The registry has one canonical owner/scope
representation: both fields are top-level artifact properties. It must not
duplicate them in a nested `ownership` object. A generated Skill sidecar uses
a separate contract and may retain its structured `ownership` object.

## Registry versus projection

The registry is the machine source for synchronization. A human-readable
context map is a projection and may be regenerated from it. If the two
disagree, the discrepancy is a validation failure that must be surfaced.

## No secrets

The registry stores paths, classifications, revisions, relationships, and
verification commands. It must never store passwords, tokens, private keys,
production credentials, or unredacted device/customer data.
