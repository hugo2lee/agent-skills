# Knowledge Registry Contract

The registry is a machine-readable index of project or repository knowledge.
It is not a second source of truth for behavior. It records ownership,
provenance, lifecycle, scope, and routing relationships.

## Minimal shape

```yaml
schema_version: "1"

artifacts:
  - id: example-api-reference
    path: docs/api.md
    type: reference
    status: active
    scope: project
    provenance:
      canonical_sources:
        - api/example.proto
      commit: abc123
    related_skills:
      - example-development
```

## Required decisions

Each artifact should make it possible to answer:

- what is it;
- where is it;
- who owns it;
- what is its lifecycle status;
- what is canonical;
- which revision was verified;
- which Skill or task route consumes it;
- what verification is needed after change.

Generated artifacts additionally record their generator and regeneration
command. External or unavailable sources should be marked `unverified` rather
than copied into the repository.

## Registry versus projection

The registry is the machine source for synchronization. A human-readable
context map is a projection and may be regenerated from it. If the two disagree,
the discrepancy is a validation failure that must be surfaced.

## No secrets

The registry stores paths, classifications, revisions, and relationships. It
must never store passwords, tokens, private keys, production credentials, or
unredacted device/customer data.
