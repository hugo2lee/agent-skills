# Dependencies and Risks

Treat dependencies and risks as executable planning information, not a list of anxious possibilities.

## Dependency types

- **Behavioral** — one behavior or contract must exist before another can be tested.
- **Data** — schema, migration, fixture, or persisted compatibility is required.
- **Boundary** — a port, adapter, transport, or provider contract must be aligned.
- **Operational** — configuration, rollout, health check, or rollback support is required.
- **Decision** — a user answer blocks a material behavior or compatibility choice.

For each dependency, name the owner, prerequisite, evidence, and removal or completion condition. Keep dependency ordering visible in the vertical slices.

## Risk format

For each material risk record:

- scenario and affected behavior;
- evidence or assumption;
- likelihood and impact in plain language;
- smallest mitigation or experiment;
- checkpoint and stop condition;
- residual uncertainty.

Prefer an experiment or safety net over a speculative platform. A risk that can only be reduced by introducing a new abstraction must first show the change pressure and the smallest enabler that addresses it.
