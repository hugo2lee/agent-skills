# Artifact Classification

Classify repository knowledge by what it is authoritative for, not by the
directory name or file extension alone.

## Source

The authoritative fact that defines behavior or an executable contract:

- source code and public interfaces;
- API schemas, migrations, and protocol definitions;
- executable tests and release baselines;
- build definitions, deployment manifests, and scripts that are actually run.

Source may be incomplete or in conflict. Classification does not mean that the
source is correct; it means that reconciliation must start there.

## Reference

A maintained explanation that helps an Agent or developer understand a source:

- field mappings and protocol references;
- module or package guides;
- architecture diagrams with linked sources;
- setup and usage documentation.

Reference is not automatically a new task boundary or a global rule.

## Evidence

A record of what happened or was measured:

- incident reports;
- benchmark and baseline results;
- deployment or device verification;
- review findings and investigation notes.

Evidence informs decisions but does not automatically become a `MUST` rule.

## Decision

An explicitly accepted product or engineering choice:

- ADRs;
- approved feature change records;
- compatibility decisions;
- accepted exception records.

A draft is not an active decision until its approval and scope are clear.

## Generated Artifact

A file produced from another source by a repeatable tool or command. It must
record `generated_from` or canonical sources and a regeneration command. It is
never the only design source and cannot outrank the source that produced it.

## Skill

A stable, independent, routable, and verifiable task boundary that changes an
Agent's decisions or workflow. A Skill needs a discriminating description,
canonical sources, validation, and enough evals. Repeated work is evidence for
a Skill; repeated files are not.

## Ambiguous artifacts

If an artifact appears to fit multiple classes, keep the primary type that
matches its maintenance authority and add relationships to the others. Do not
copy the same content into multiple artifacts to avoid making the classification
decision.
