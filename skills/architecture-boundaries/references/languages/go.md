# Go Boundary Guidance

This reference contains Go-specific applications of the general boundary rules. It is not a project-specific package template.

## Interfaces

Define an interface near the consumer when the consumer needs a replaceable capability. Keep it small and behavior-oriented.

~~~go
type PaymentGateway interface {
    Authorize(ctx context.Context, amount Money) (Authorization, error)
}
~~~

Do not mirror a large concrete client merely to make it mockable.

## Constructors and composition

Constructors should receive dependencies. They should not create databases, HTTP clients, queues, or global configuration as hidden side effects.

~~~go
func NewCheckout(gateway PaymentGateway, clock Clock) *Checkout {
    return &Checkout{gateway: gateway, clock: clock}
}
~~~

The executable or startup package assembles concrete implementations.

## Packages

Keep imports directed toward policy. Avoid package cycles and avoid placing infrastructure types in domain packages. A package boundary is useful only when it clarifies ownership or change.

## Errors and protocols

Adapters should translate provider errors and wire representations at the edge. Domain code should not need to know whether a failure came from HTTP, SQL, or a vendor SDK.

## Concrete by default

Within a cohesive package, a concrete type is usually the simplest choice. Add an interface when a real consumer-owned boundary, substitution, or contract test requires it.
