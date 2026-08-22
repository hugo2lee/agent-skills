# C++ Boundary Realization

This is a language-specific realization of the architecture-boundaries principles, not a C++ architecture template. Start with the meaningful boundary and its change risk, then choose the smallest C++ mechanism that preserves it.

## Concrete types inside a boundary

Prefer concrete classes inside a cohesive package or component. Use an abstract base class, a narrow concept, or a function object only when the consumer needs a purposeful substitution point, an independently testable capability, an ownership boundary, or a protocol boundary.

Do not make every class polymorphic so a test can replace it. A test-only virtual method is usually evidence to reconsider the seam, not proof that an interface is needed.

## Consumer-owned contracts and constructor injection

Put a small abstract contract near the policy that consumes it. Inject the implementation through a constructor or an explicit factory, and assemble concrete objects in the composition root:

```cpp
class PaymentGateway {
public:
    virtual ~PaymentGateway() = default;
    virtual PaymentReceipt charge(const PaymentRequest&) = 0;
};

class Checkout {
public:
    explicit Checkout(PaymentGateway& gateway) : gateway_(gateway) {}

    Receipt confirm(const Order& order);

private:
    PaymentGateway& gateway_; // non-owning: the composition root owns it
};
```

Use a reference or a value when the dependency is non-owning or value-like. Use `std::unique_ptr` when one object owns a polymorphic dependency. Use `std::shared_ptr` only when shared lifetime is part of the domain or infrastructure contract; do not use it as the default injection type.

## RAII and ownership

- Acquire resources in constructors or factories and release them in destructors or RAII wrappers.
- Make ownership visible in the type and lifetime relationship.
- Keep third-party clients, file handles, sockets, and transactions behind the adapter that owns their protocol and cleanup rules.
- Avoid raw owning pointers and ambiguous borrowing across a boundary.

RAII protects resource lifetime; it does not decide whether a domain boundary exists. Keep that architectural decision explicit.

## Adapters and external protocols

Wrap a third-party SDK, C API, wire protocol, or platform facility in an adapter when its types or error model would otherwise leak into policy code. Translate at the edge, keep the consumer contract in terms of the capability it needs, and test the translation separately from the business behavior.

For a C API, isolate handle ownership, null/error-code conversion, thread-safety assumptions, and cleanup in one adapter. Do not spread `extern "C"` calls and vendor status codes across the application.

## pImpl and link-time boundaries

Use pImpl when compile-time coupling, ABI stability, or private implementation size is a real concern. It can hide vendor headers and reduce rebuild scope, but it also adds allocation, indirection, and ownership complexity. Do not introduce pImpl solely because the pattern is familiar.

Use a shared library or link-time boundary when deployment, ABI, ownership, or independent release is a real boundary. A separate target in a build file is not automatically a domain boundary.

## Test seams

Test policy through observable behavior. A narrow consumer-owned contract can provide a deterministic fake or in-memory adapter when the external system is slow, costly, or unavailable. Prefer a real adapter contract test for protocol translation and integration tests for the real external behavior.

If introducing virtual methods, templates, or concepts only for mocking makes the production design harder to understand, first consider a concrete collaborator, a function parameter, a fake at the true boundary, or a higher-level test.

## Verification checklist

Before approving a C++ boundary, show:

- the responsibility or change source it protects;
- who owns the contract and who owns each object;
- constructor/factory wiring and lifetime semantics;
- the adapter translation point for external protocols;
- the reason for virtual dispatch, pImpl, or a link-time boundary;
- a behavior test and any contract/integration test that proves the seam.
