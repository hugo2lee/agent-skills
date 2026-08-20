# TDD in Vertical Slices

Start with the smallest user-visible or domain-visible path. A slice may cross handler, application, domain, and adapter code if that is the behavior being proved.

Protect one behavior, then add the next. Keep incomplete layers out of the main path unless they are required to reach the behavior.

When a feature has several rules, order them by risk or user value. Each new rule should have a focused test and leave the system runnable.
