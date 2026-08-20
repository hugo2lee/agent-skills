# Dependencies and Risks

Put discovery before implementation when the result can change the design. Identify external systems, migrations, compatibility, data loss, security-sensitive operations, and user decisions.

For each high-risk item state:

- what is known;
- what is unknown;
- the cheapest safe check;
- the stop condition;
- the fallback or rollback.

Do not parallelize tasks that write overlapping files or depend on an unresolved architectural decision.
