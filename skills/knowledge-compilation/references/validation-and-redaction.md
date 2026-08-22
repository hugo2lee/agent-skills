# Validation and Redaction

Generated knowledge is publishable only after content, provenance, scope, and
write-boundary checks pass.

## Validation gates

Check:

1. frontmatter and `agents/openai.yaml` are valid;
2. Skill name, directory, prompt, and registry entry agree;
3. references and registry paths resolve or are explicitly external;
4. source commits and canonical paths exist or are marked stale/unverified;
5. eval case IDs are unique and match their expected outcomes;
6. lifecycle status and scope are allowed;
7. generated artifacts declare source and regeneration information;
8. no unfinished placeholders or unsupported claims remain;
9. the generated output stays inside its approved write allowlist.

## Redaction

Block or redact before registration:

- passwords, tokens, API keys, credentials, and private keys;
- unredacted production configuration and secret-bearing endpoints;
- device serials, MAC addresses, unique identifiers, and customer data;
- private logs or payloads whose contents are not intended as project knowledge.

Use an explicit marker such as `<redacted-device-id>` when the fact that a value
exists matters. Never invent a replacement value or silently change a source
file to make redaction pass.

## High-risk material

Production deployment, migrations, device operations, and credentials may be
registered as a candidate or an unverified runbook, but automatic activation
requires a project policy and verification evidence. A compiler cannot replace
authorization for a high-risk operation.

## Stop conditions

Fail closed when a secret cannot be separated from the generated output, when a
canonical source is missing, when a proposed write targets product source or
production data, or when a conflict would be hidden by the generated result.
