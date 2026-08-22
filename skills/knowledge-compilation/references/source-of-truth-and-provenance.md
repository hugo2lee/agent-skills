# Source of Truth and Provenance

Every knowledge product needs a maintenance authority. Provenance explains the
relationship; it does not promote a summary above its source.

## Precedence

Use this order when deciding what to inspect first:

```text
executable contract / source / test / release baseline
        ↓
approved decision or requirement
        ↓
maintained reference
        ↓
generated summary or index
        ↓
historical evidence and draft notes
```

The order is a starting point, not permission to ignore an explicit conflict.
An approved decision may authorize a future change that code has not yet
implemented; record that state instead of declaring either side wrong.

## Provenance fields

At minimum, record:

- canonical source path(s);
- source commit, revision, or external version;
- owner or maintainer role;
- last verification date when the project uses one;
- generation command and version for generated material;
- related Skills and verification commands.

## Conflicting source claims

If a generated summary says one thing and code or a baseline says another,
preserve the conflict and classify it as stale summary, source drift, authorized
change, or unresolved. Never overwrite the canonical source to make the
registry look consistent.

## Renames and deletion

A rename updates provenance after confirming identity. A deleted source makes
dependent generated knowledge stale until a replacement is established. Do not
silently leave a broken path as if it were active.
