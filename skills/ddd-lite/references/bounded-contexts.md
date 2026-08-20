# Bounded Contexts

A Bounded Context protects a model and language when two parts of a system cannot share one coherent meaning.

## Evidence for a context boundary

Look for diverging terminology, ownership, lifecycle, consistency, release cadence, or external model pressure. Separate contexts only when the boundary reduces confusion or change coupling.

## Translation

Use an explicit translation or Anti-Corruption Layer when an external model must not distort the internal one. Keep the translation at the boundary and document which model owns each term.

## Integration

Choose an integration style based on the required consistency and coupling:

- direct call for simple synchronous capability;
- published event for an important fact;
- batch or reconciliation when eventual consistency is acceptable.

Do not introduce a context, event bus, or ACL solely to make a diagram look complete.
