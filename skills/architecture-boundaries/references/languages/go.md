# Go Boundary Guidance

This is the first-version language realization for `architecture-boundaries`. It keeps the conceptual rules language-independent while making the Go trade-offs concrete.

## Package direction

Keep domain and application packages independent from database clients, HTTP frameworks, queue SDKs, and cloud providers. Put provider-specific code in an adapter package and wire the concrete implementation in the composition root, commonly `cmd/<app>/main.go` or an equivalent bootstrap package.

Avoid import cycles as an architectural signal. If package A and package B need each other, identify the policy owner and move the small consumer-owned contract or shared value type toward that owner rather than adding a broad common package by reflex.

## Concrete types by default

Use concrete structs and functions within a stable package boundary. Define a small interface at the consumer when a real boundary needs substitution, independent testing, or ownership separation:

```go
type PaymentAuthorizer interface {
    Authorize(ctx context.Context, request AuthorizationRequest) (AuthorizationResult, error)
}

type CheckoutService struct {
    authorizer PaymentAuthorizer
}

func NewCheckoutService(authorizer PaymentAuthorizer) *CheckoutService {
    return &CheckoutService{authorizer: authorizer}
}
```

Do not create an interface for every service, repository, mapper, or validator. A same-package mock convenience is not enough evidence.

## Constructors and composition

Constructors should receive required dependencies explicitly and should not create network clients, database pools, clocks, or hidden global state. The composition root owns concrete wiring:

```go
provider := payments.NewProviderClient(config.ProviderURL, httpClient)
service := checkout.NewCheckoutService(provider)
handler := httpapi.NewCheckoutHandler(service)
```

If a constructor needs many unrelated dependencies, inspect whether the boundary or responsibility is too broad before introducing a dependency container.

## Adapter translation

Keep provider request/response types at the adapter boundary. Convert them into the consumer-owned capability contract, preserving error, timeout, retry, and idempotency semantics that the application can reason about. Do not leak ORM models or SDK errors into domain behavior unless that coupling is an explicit, accepted boundary.

## Verification

Use a focused fake or stub for the consumer-owned contract when the service behavior needs fast feedback. Add an integration or contract test for real database, HTTP, queue, or provider behavior that a fake cannot prove. A compiling package graph is useful evidence, but it does not prove observable boundary behavior.
