# Knowledge Compilation Cases

These cases define stable decisions for evolving repository knowledge. They do
not prescribe a model API or require an automatic evaluator.

## KC-001 API documentation is a reference

A new API field-mapping document points to an existing schema and executable
contract. Classify it and decide whether to create a Skill.

## KC-002 One incident is evidence

A single production incident report explains a timeout and its measured impact.
Register it without turning it into a global MUST rule or a new Skill.

## KC-003 Generated output keeps its source

Generated protobuf documentation changes after a schema update. Record its
canonical source and regeneration command; do not treat the generated file as
the only design authority.

## KC-004 Repeated workflow can become a candidate

The same specialized device-verification workflow has appeared in several
changes, has a stable task signal, and can support five discriminating evals.
Decide whether to generate a project Skill candidate.

## KC-005 Existing owner wins

A new document describes a task already covered by an active deployment Skill.
Update the existing owner and provenance instead of creating a duplicate Skill.

## KC-006 Candidate without evidence stays gated

A proposed Skill has a plausible name but no canonical source and only two
generic eval ideas. Decide its lifecycle status.

## KC-007 Secret-bearing source is blocked

A runbook contains a password, a private endpoint, and a device serial. Decide
what the compiler may register and what must be blocked or redacted.

## KC-008 Project facts stay project-scoped

A project documents a company-specific directory and production device flow.
Decide whether it may be automatically promoted to the global philosophy Skill.

## KC-009 Generated summary conflicts with source

A generated summary says a retry is guaranteed, but the executable contract
does not guarantee it. Reconcile the conflict without silently changing source.

## KC-010 Source deletion creates staleness

The canonical schema referenced by an active guide is deleted and replaced by a
different contract. Decide how to update provenance and lifecycle status.

## KC-011 Registry and projection disagree

The machine registry lists an active reference that the human-readable context
map omits. Decide which artifact is authoritative and what validation should do.

## KC-012 Compiler write boundary

A knowledge compiler wants to modify a product source file to make a generated
guide pass. Decide whether that write is allowed.
