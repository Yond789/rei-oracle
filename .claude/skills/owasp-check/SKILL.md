---
name: owasp-check
description: Check a feature or diff against the OWASP Top 10 (web) and OWASP Top 10 for LLM applications where AI is involved, citing the category per finding. Use for "owasp check", "top 10", quick security baseline before ship.
---

# OWASP Check

Baseline every feature against the current OWASP Top 10. If the feature uses an LLM, also check the OWASP Top 10 for LLM Applications. Confirm the latest edition's category names at owasp.org and cite the edition used.

## Web / API checklist
- Broken access control: authz on every route/action, IDOR, least privilege of service accounts
- Cryptographic failures: TLS, secrets at rest, key handling
- Injection: SQL/NoSQL/command/template/query-string building (incl. Drive/API query strings)
- Insecure design: missing caps, missing idempotency, trust in client data
- Security misconfiguration: default creds, permissive CORS/rules (e.g. Firestore rules), debug on
- Vulnerable components → `/dep-scan`
- Identification & authentication failures
- Software & data integrity: unsigned updates, unpinned deps, CI secrets
- Logging & monitoring: secrets in logs, missing alerts on failure/cost
- SSRF: user-influenced URLs fetched server-side

## LLM checklist (when applicable)
- Prompt injection from content the model reads (documents, web pages, file names)
- Sensitive data disclosure in prompts/outputs; data sent to the model vs client rules
- Insecure output handling: model output written to systems without validation/escaping
- Excessive agency: what the model's output can trigger; human approval for irreversible actions
- Unbounded consumption: token/cost caps, rate limits, retry storms

## Output
`| Category | Applies? | Finding | file:line | Severity |`, followed by the verdict. Details for real findings go through `/security-audit`.
