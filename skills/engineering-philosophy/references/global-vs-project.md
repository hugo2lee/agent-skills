# Global versus Project Rules

## Global Skill

Global rules answer: how should software generally be designed, changed, tested, reviewed, debugged, and delivered?

Good global rules are stable across languages and projects. They describe decisions such as making dependencies explicit, protecting meaningful boundaries, verifying behavior, and limiting abstractions to real change pressure.

## Project rule

Project rules answer: how does this repository implement those principles?

Project rules may specify:

- Go and toolchain versions;
- package layout;
- database and message broker choices;
- required commands;
- CI provider and branch workflow;
- team vocabulary;
- project-specific aggregates and invariants.

## Classification test

Ask:

1. Would this rule remain useful in a different project?
2. Does it depend on a specific tool, vendor, or team?
3. Can it be validated without knowing one repository's schema?
4. Would applying it globally cause unnecessary work?

If the answer to the second or fourth question is yes, keep it project-local.

## Conflict handling

An explicit project rule may override a global SHOULD. It should not silently override a global MUST without documenting the risk and rationale. A global CONDITIONAL rule must first be checked for its trigger conditions.
