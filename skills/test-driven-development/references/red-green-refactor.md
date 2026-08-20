# Red-Green-Refactor

## Red

Write one test for one observable behavior. Run it and confirm it fails because the behavior is missing or incorrect. A syntax error or broken fixture is not the useful red state.

## Green

Implement the smallest behavior that passes. Avoid speculative options, abstractions, and future cases that the current test does not require.

## Refactor

With a green suite, improve names, duplication, structure, and boundaries without changing behavior. Re-run focused and broader tests after the refactor.

## Loop discipline

Keep the loop short. If the implementation is too large for one loop, return to incremental-implementation and split a smaller vertical behavior.
