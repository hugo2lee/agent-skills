# Generated Knowledge Contract

Generated knowledge must carry enough metadata to answer where it came from,
which revision was used, how it was produced, who owns it, and whether it is
safe to use. Generation is a proposal and provenance operation; it is not an
activation operation.

## Agent Skills frontmatter

Every generated Skill must first remain valid under the standard `SKILL.md`
frontmatter contract. Keep the frontmatter small and interoperable:

```yaml
---
name: example-generated-skill
description: Apply a verified generated workflow in its declared scope.
license: AGPL-3.0-only
metadata:
  version: "0.4.0"
  generated: "true"
  generated_by: "knowledge-compiler"
  knowledge_record: "knowledge.yaml"
---
```

Do not put nested provenance, generation, lifecycle, ownership, or promotion
objects in `SKILL.md` frontmatter. The Agent Skills standard frontmatter is the
source of truth for the Skill's `name` and `description`; structured
provenance must not become a second instruction or identity source.

## Sidecar knowledge record

Link the structured record through a simple metadata pointer such as
`metadata.knowledge_record: "knowledge.yaml"`:

```yaml
schema_version: "1"
generated: true
generated_by: knowledge-compiler
skill_path: generated/skill-candidates/example-generated-skill
provenance:
  source_paths:
    - docs/example.md
  source_commit: abc123
generation:
  version: "0.1.0"
  command: ./scripts/knowledge-compiler
lifecycle:
  status: candidate
  confidence: medium
ownership:
  owner: example-team
  scope: project
```

The sidecar is validated by
`schemas/generated-skill-record.schema.yaml`. It must not redefine the Skill's
name or description. It records `source_paths`, a source revision, generator
version, regeneration command, lifecycle status, owner, and scope. A
non-project scope additionally requires reviewed promotion evidence.

## Regeneration and conflict handling

`source_paths` must identify canonical inputs, not only a generated summary.
`source_commit` must be a real revision when the repository supports one. When
the generator can be rerun, record the command and version. A generated
artifact with a stale source commit is stale knowledge, not a new authority.
Canonical source conflicts are surfaced for reconciliation; generated output
never silently overwrites the source.

Regeneration must be deterministic enough to review and must not include secret
values, private identifiers, or unredacted production configuration in logs or
output. The sidecar is a knowledge record, not an alternative instruction
source.
