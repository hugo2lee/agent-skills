# Generated Knowledge Contract

Generated knowledge must carry enough metadata to answer where it came from,
which revision was used, how it was produced, and whether it is safe to use.

## Minimum metadata

```yaml
metadata:
  generated: true
  generated_by: knowledge-compiler
  provenance:
    source_paths:
      - path/to/canonical/source
    source_commit: abc123
  generation:
    version: "0.1.0"
    generated_at: "2026-08-22T00:00:00Z"
    command: "./scripts/knowledge-compiler"
  lifecycle:
    status: candidate
    confidence: medium
  ownership:
    scope: project
```

`source_paths` must identify canonical inputs, not only a generated summary.
`source_commit` must be a real revision when the repository supports one.
`scope` defaults to `project`; automatic generation cannot set `global`.

## Skill metadata

Generated Skill instructions should retain this metadata in frontmatter or a
linked machine-readable record. Its `agents/openai.yaml` must still be valid,
its `default_prompt` must name the Skill, and its eval cases must be kept in
the repository's normal eval surface.

## Regeneration

When the generator can be rerun, record the command and version. A generated
artifact with a stale source commit is stale knowledge, not a new authority.
Regeneration must be deterministic enough to review and must not include secret
values in logs or output.
