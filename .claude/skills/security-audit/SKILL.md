---
name: security-audit
description: Audit code for vulnerabilities with severity and CWE/OWASP/CVE citations and file:line evidence; produce SECURITY-AUDIT.md. Shared by Rei (owner) and Kira (security test coverage). Use for "security audit", "is this secure", before shipping anything handling secrets, auth, money or personal data.
---

# Security Audit

Every finding needs: severity (Critical / High / Medium / Low), location (file:line), CWE or OWASP or CVE reference, a concrete exploit or failure scenario, and a fix. No gut-feel warnings.

## Process

1. **Scope:** the diff or component; its entry points (HTTP, CLI, schedulers, queues, webhooks, file uploads) and assets (secrets, PII, money, client data).
2. **Secrets:** `git log -p` and the tree for keys, tokens, `.env`, service-account JSON. Any hit in a repo that was ever public = Critical: rotate first, clean history second.
3. **Walk the checklist** (`/owasp-check` has the full list): injection, authn/z, access control, SSRF, unsafe deserialization, path traversal, XSS/CSRF for web, logging of secrets, error leakage, rate limits / cost caps, least privilege for service accounts and API keys.
4. **Dependencies:** run `/dep-scan` if manifests changed.
5. **Verify each finding** by reading the code path end to end (prove-it-works). Drop what you cannot substantiate, or mark it "unconfirmed".
6. **Kira's angle:** for each confirmed finding, is there a test that would catch a regression? If not, list it for `/test-plan`.

## Output — `SECURITY-AUDIT.md`

```
# Security Audit — <scope> — <date>
Verdict: CLEAR | ISSUES | SHIP BLOCKED
| Sev | Finding | file:line | Ref | Scenario | Fix |
Unconfirmed: ...
Regression tests needed: ...
```

Critical or High → `/talk-to yumi "SHIP BLOCKED: <reason>"` and `/talk-to haru "security issues: <file:line + ref>"`.
