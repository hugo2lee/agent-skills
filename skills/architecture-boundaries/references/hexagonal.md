# Hexagonal Boundaries

Ports and Adapters is a way to describe a boundary, not a mandatory directory tree.

## Driving side

Driving actors initiate behavior: HTTP handlers, commands, jobs, or user-facing interfaces. A driving adapter translates the external request into an application operation.

Use an inbound port only when the application boundary is meaningful for substitution, independent testing, or multiple driving protocols. A single handler calling a single application service does not automatically require an interface.

## Driven side

Driven dependencies provide capabilities to policy: payment, persistence, time, messaging, filesystem, or remote services. A driven port should express the capability the policy needs, not the API shape of a provider.

The consumer should own the smallest interface it needs. The adapter implements that contract and translates provider errors, data, and protocols at the edge.

## Composition Root

Keep wiring in a composition root: application startup, command setup, or a dedicated assembly package. Domain and application code should not construct their own infrastructure.

## Boundary test

Test the policy with a fake or in-memory implementation when that proves behavior. Test the adapter separately for protocol translation. Use a contract test when several implementations must honor the same behavior.

## Warning

If the proposed ports, packages, and adapters do not protect a real change boundary, reduce the design. Hexagonal vocabulary is not evidence that the boundary is valuable.
