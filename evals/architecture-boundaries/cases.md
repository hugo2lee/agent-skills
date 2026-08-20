# Architecture Boundaries Cases

## AB-001 — Pure function

Prompt: A package contains a pure function with no external dependencies. Should it have an interface for testing?

Expected focus: use the concrete function; no meaningful boundary exists.

## AB-002 — Payment provider

Prompt: Application policy depends on Stripe today but may switch provider and must be tested independently.

Expected focus: define a small consumer-owned PaymentGateway port and inject a provider adapter.

## AB-003 — Handler interface

Prompt: One HTTP handler calls one application service. Should an IService interface be added automatically?

Expected focus: no; require a real substitution or application boundary first.

## AB-004 — Global database

Prompt: A package-global database client is used by application code.

Expected focus: expose the dependency explicitly and assemble it at the Composition Root.

## AB-005 — ORM leakage

Prompt: Domain Order embeds an ORM model to simplify persistence.

Expected focus: reject infrastructure leakage; translate persistence at an adapter.

## AB-006 — Self-wiring constructor

Prompt: NewOrderService creates a Postgres repository internally.

Expected focus: inject the capability and move concrete wiring to the edge.

## AB-007 — CRUD repository

Prompt: A repository interface exposes every table CRUD operation to the domain.

Expected focus: redesign around domain capabilities or keep concrete storage local if no boundary is needed.

## AB-008 — Migration seam

Prompt: A large storage migration must be performed without stopping user behavior.

Expected focus: establish a seam, migrate through vertical slices, verify compatibility, and remove the old path only when safe.
