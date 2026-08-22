# Knowledge Compilation Lifecycle

Knowledge compilation manages the evolution of the Agent knowledge surface. It
is a repository-evidence workflow, not a second implementation workflow and
not a license to rewrite product source.

## Flow

```text
Repository Change
        ↓
Discover Changed Evidence
        ↓
Classify Knowledge Artifact
        ↓
Resolve Canonical Source and Provenance
        ↓
Reconcile Existing Knowledge
        ↓
Choose Knowledge Product
        ↓
Synthesize or Update
        ↓
Validate Provenance and Redaction
        ↓
Register
        ↓
Candidate / Active Decision
        ↓
Agent Discovery
        ↓
Staleness / Deprecation / Retirement
```

The process is proportional. A typo in a local README may only need a direct
reference update. A new deployment workflow may need classification, source
linkage, a runbook, a Skill candidate, evals, and an activation gate.

## Step 1: Discover

Inspect the repository diff, not just filenames. Record added, modified,
deleted, and renamed paths together with the relevant source commit. Include
code, tests, build definitions, generated outputs, documentation, decisions,
evidence, and project Skill changes when they can alter Agent decisions.

## Step 2: Classify

Assign the smallest useful artifact type: Source, Reference, Evidence,
Decision, Generated Artifact, or Skill. A file can point to another artifact as
its canonical source, but its own type must remain explicit.

## Step 3: Resolve source and provenance

Find the authoritative behavior or decision. Store source paths, commit or
revision, owner, and regeneration command where relevant. A summary is not
authoritative merely because it is newer or easier to read.

## Step 4: Reconcile

Compare new evidence with existing references, active Skills, released
baselines, and project decisions. Surface conflicts such as code versus a
released contract, a generated file versus its source, or a proposed Skill
versus an existing owner. Do not silently choose a winner.

## Step 5: Choose a product

Use the following preference order:

```text
existing owner update
    > new Source / Reference / Evidence / Decision registration
    > Skill candidate
    > active Skill
```

Repeated work can justify a Skill; repeated files cannot. A new bounded context
or one incident is evidence to investigate, not an automatic activation signal.

## Step 6: Synthesize and validate

Generated material must be small, linked to its sources, and safe to publish.
Generate references and discriminating evals when a candidate is justified.
Validate frontmatter, links, IDs, provenance, redaction, scope, and write
allowlists before registration.

## Step 7: Register and operate

The machine registry is the source for discovery and synchronization. Human-
readable maps may be generated projections. Active, deprecated, and archived
knowledge must not be treated as equivalent by an Agent.

## Step 8: Retire stale knowledge

When a canonical source is deleted, renamed, replaced, or no longer verified,
mark the dependent knowledge stale and choose deprecated or archived status.
Do not silently preserve a statement whose source has disappeared.
