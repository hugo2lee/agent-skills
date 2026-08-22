# Knowledge Reconciliation

Knowledge compilation must reconcile new evidence with existing owners before
creating anything new.

## Decision tree

```text
New evidence
      ↓
Existing owner covers the task or fact?
  ├── Yes → update owner, provenance, and affected evals
  └── No
        ↓
Independent repeatable task boundary?
  ├── No → register Source / Reference / Evidence / Decision
  └── Yes → create a Skill candidate and its eval plan
```

Prefer one clear owner over parallel summaries, duplicate Skills, or a new
index that merely repeats an existing index.

## Conflicts

Surface, classify, and record conflicts among:

- new documentation and existing documentation;
- code and an approved requirement;
- code and a released behavior baseline;
- generated output and its canonical source;
- a candidate Skill and an active Skill;
- project rules and global guidance.

Useful classifications include stale documentation, implementation drift,
authorized behavior change, missing decision, and unverifiable evidence.

Never turn a conflict into a silent merge. If the change is user-visible,
compatibility-sensitive, or scope-changing, stop for the relevant decision
gate.

## Update versus create

Update an owner when the task signal, canonical source, and verification method
are already inside its responsibility. Create a candidate only when the new
work has a stable boundary that neighboring descriptions cannot distinguish,
and when an independent verification path exists.

The filename, number of documents, or size of a directory is not sufficient
evidence for a new Skill.
