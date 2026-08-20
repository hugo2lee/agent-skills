# Anti-Pattern: Test After

The implementation is written across handlers, services, repositories, and
adapters first. A large batch of tests is added afterward and mostly asserts
private calls and mock interactions.

This provides weak evidence: the tests may preserve the implementation rather
than the behavior, and no red state proved that the tests could detect the
missing requirement.
