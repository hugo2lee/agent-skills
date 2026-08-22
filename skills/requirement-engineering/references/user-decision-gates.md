# User Decision Gates

Ask the user when a missing answer changes the product behavior, compatibility, data shape, operational cost, or public scope. Do not ask for approval of mechanical implementation details that can be chosen safely from the contract.

## Gate output

Present:

1. the unresolved decision in user language;
2. the smallest set of viable options;
3. observable behavior and compatibility impact for each option;
4. migration, cost, or risk trade-offs;
5. the recommended option and why;
6. the decision needed and the time at which it blocks progress.

Record the answer, rejected alternatives, and affected requirement or baseline in the Feature Change Record.

## Typical decisions

- Whether a conflicting released behavior remains compatible or is intentionally replaced.
- Whether a duplicate capability should be reused, extended, or deprecated.
- Whether a new failure is retried, surfaced, ignored, or made idempotent.
- Whether a data migration is required and whether old callers remain supported.
- Whether a demonstrated change pressure justifies an architectural enabler now.

## Proportionality

For a trivial change, an inline question and answer is enough. For a release-sensitive or cross-boundary change, the answer must be durable and linked to the tests, baseline, and release notes that implement it.
