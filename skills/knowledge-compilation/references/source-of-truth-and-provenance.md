# Source of Truth and Provenance

Knowledge compilation preserves the difference between an authority and a
derivative. Code, executable schemas, tests, release baselines, approved
decisions, and explicit external contracts may be canonical sources depending
on the artifact. Summaries, generated docs, reports, and Skills do not become
authoritative merely because they are newer or easier to read.

## Provenance record

For every registered artifact, record:

- the artifact path and lifecycle status;
- the owner and project/organization/global scope;
- canonical source paths, or explicitly named external sources;
- the source commit or revision when available;
- verification commands and the last verified revision/time when known;
- generator version, generated-from inputs, and command for generated output.

Source artifacts may have no parent canonical source. Derivative artifacts must
have one or more canonical or external sources. A missing source is a visible
`unverified` or `stale` condition, not permission to invent a replacement.

## Conflict rule

When a generated summary, report, or document conflicts with released behavior,
the executable contract or approved decision remains canonical until the
conflict is investigated and an authorized change is recorded. The compiler
must surface the conflict and preserve both evidence paths; it must not
silently rewrite the baseline.

## Scope rule

Project facts remain project-scoped by default. A project artifact or generated
Skill cannot become a global engineering-philosophy rule without independent
cross-project evidence, redaction of local facts, discriminating evals, and a
separate promotion review.
