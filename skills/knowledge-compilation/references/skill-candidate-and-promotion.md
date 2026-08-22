# Skill Candidate and Promotion

## Candidate gate

A proposed Skill should have:

- a clear task signal and explicit exclusion boundary;
- at least one canonical source and a provenance path;
- a responsibility not already owned by an active Skill;
- repeated work or a sufficiently high-cost/high-risk failure mode;
- an independent verification method;
- at least five discriminating eval cases, unless a documented high-risk gate
  justifies a smaller initial set for quarantine;
- no secrets, private customer data, device identifiers, or production-only
  configuration in its instructions or generated references.

One transient incident, one new document, one bounded context, or a future
possibility is not enough by itself.

## Lifecycle

```text
candidate → active → deprecated → archived
```

### candidate

The material is generated or proposed for evaluation. It is not a stable
project rule and should not be a default route unless the project explicitly
defines a safe candidate mode.

### active

The source, provenance, links, evals, redaction checks, route distinction, and
verification gates pass. It may participate in normal Agent discovery.

### deprecated

An active replacement exists, but consumers may still need the old material.
Record `replaced_by` and keep a migration path.

### archived

The material is historical only and must not participate in default discovery.

## Promotion

Activation is a governed decision, not a side effect of generation. Project
automation may produce candidates and run objective gates; it must not promote
project knowledge to the global engineering-philosophy scope. Global promotion
requires independent project evidence and a separate review.
