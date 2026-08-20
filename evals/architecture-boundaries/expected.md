# Architecture Boundaries Expected Outcomes

## AB-001

- Use the concrete function.
- State that no substitution or meaningful boundary is present.

## AB-002

- Define a small consumer-owned PaymentGateway capability.
- Inject it and implement Stripe as an adapter.
- Assemble the concrete provider at the Composition Root.

## AB-003

- Do not create IService mechanically.
- Ask whether substitution, independent testing, or a real application boundary exists.

## AB-004

- Remove the hidden global dependency.
- Pass the capability explicitly and assemble it at the edge.

## AB-005

- Keep ORM types out of the domain.
- Translate persistence data in an adapter.

## AB-006

- Make repository dependency explicit.
- Move Postgres construction to the Composition Root.

## AB-007

- Replace storage-shaped contracts with domain capabilities when a boundary is needed.
- Otherwise keep the concrete storage implementation local.

## AB-008

- Add a seam first.
- Migrate through verified vertical slices.
- Keep old and new paths explicit and remove the old path only after safe verification.

