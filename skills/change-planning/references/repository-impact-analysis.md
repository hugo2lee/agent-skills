# Repository Impact Analysis

Repository analysis precedes an implementation plan for any change with more than one meaningful dependency. The goal is to discover the existing system and reuse opportunities, not to produce a decorative inventory.

## Inspect

- repository structure and language/toolchain entry points;
- public commands, handlers, jobs, or event consumers;
- application services and domain rules;
- persistence ports, concrete adapters, schema, migrations, and transaction behavior;
- outbound ports, adapters, protocol clients, timeout and retry behavior;
- inbound transport mapping and error translation;
- existing tests, fixtures, fakes, integration environments, and CI jobs;
- configuration, feature flags, rollout paths, and release automation.

## Record evidence

Name the relevant files, symbols, tests, commands, or commits. Distinguish confirmed facts from hypotheses. Note existing capabilities that can be reused and code paths that must remain compatible.

## Output

The analysis should answer:

1. Where does the requested behavior enter and leave the system?
2. Which existing capability already owns part of it?
3. Which boundary or invariant is actually under pressure?
4. Which tests and release baselines would detect weakening?
5. Which unknown requires a user decision before implementation?

Do not infer a new layer, interface, repository, or service solely from a conventional directory name.
