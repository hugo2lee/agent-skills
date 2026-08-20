# DDD Anti-Patterns

## Table-shaped domain

Every table becomes an Entity, every row an Aggregate, and every CRUD method becomes a Repository. This models storage rather than behavior.

## Service dumping ground

Entities contain only fields while a large service owns all rules. Move behavior to the owner of the invariant when that improves correctness; otherwise keep the model simple.

## Event renaming

Every internal function call is renamed as a Domain Event without a meaningful business fact or independent consumer.

## Pattern-first design

The design starts with Aggregate, CQRS, or Event Sourcing before a business problem is stated. Reverse the order: invariant, consistency, pressure, then pattern.

## Context explosion

Every package or team boundary becomes a Bounded Context. Require model divergence, ownership, or change pressure before splitting.
