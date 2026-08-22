# Knowledge Compilation Expected Outcomes

## KC-001 API documentation is a reference

- Classify the document as `reference`.
- Link it to the schema or contract as canonical source.
- Update the existing knowledge owner or registry; do not create a Skill merely because a file was added.

## KC-002 One incident is evidence

- Classify it as `evidence`.
- Preserve measured facts and provenance.
- Do not promote one incident to a global MUST rule or independent Skill without repeated evidence and evals.

## KC-003 Generated output keeps its source

- Classify the output as `generated`.
- Record the schema, commit, generator version, and regeneration command.
- The schema and executable contract outrank the generated documentation.

## KC-004 Repeated workflow can become a candidate

- Check existing Skill coverage first.
- If the boundary is independent and the eval gate is satisfied, generate a project-scoped `candidate`.
- Do not activate it merely because generation succeeded.

## KC-005 Existing owner wins

- Update the active deployment Skill or its reference and provenance.
- Reject a duplicate Skill candidate.

## KC-006 Candidate without evidence stays gated

- Keep it as an unactivated proposal or reject it.
- Require canonical sources, a distinguishing description, and discriminating evals before activation.

## KC-007 Secret-bearing source is blocked

- Do not copy the password, private endpoint credentials, or device serial into generated knowledge.
- Redact with an explicit marker or block the artifact when safe separation is impossible.
- Do not invent substitute values.

## KC-008 Project facts stay project-scoped

- Register the knowledge with `scope: project`.
- Do not automatically modify the global engineering philosophy repository.
- Promote only after independent cross-project evidence and review.

## KC-009 Generated summary conflicts with source

- Surface the conflict and classify it as stale summary, source drift, or unresolved behavior.
- Preserve the executable contract as the authority until an authorized decision changes it.

## KC-010 Source deletion creates staleness

- Mark the dependent guide stale or deprecated until a replacement source is verified.
- Update provenance to the replacement only after confirming that it is semantically equivalent or an authorized change.

## KC-011 Registry and projection disagree

- Treat the registry as the machine source and the context map as a projection.
- Fail synchronization/validation and regenerate or reconcile the projection; do not silently discard the discrepancy.

## KC-012 Compiler write boundary

- Reject the product-source write.
- Limit automation to the approved knowledge/eval/registry/compiler paths and report the required product change separately.
