---
name: threat-model
description: Rei's shift-left threat model for a spec or feature — assets, entry points, trust boundaries, STRIDE threats, mitigations — before Haru builds. Use for "threat model", "attack surface", "is this design secure".
---

# Threat Model

Output: `THREAT-MODEL.md` (or `.planning/<feature>-THREAT-MODEL.md`). Done at spec stage; issues found here are cheap.

## Process

1. **Assets:** what is worth stealing or breaking (secrets, client files, PII, money, availability, cost/quota).
2. **Actors:** external attacker, malicious insider, compromised dependency, curious user, the AI model itself (prompt injection via content it reads).
3. **Data-flow sketch:** components, data stores, external services, and the **trust boundaries** between them (text diagram is fine).
4. **STRIDE per boundary crossing:** Spoofing, Tampering, Repudiation, Information disclosure, Denial of service (incl. cost exhaustion), Elevation of privilege.
5. **Mitigations:** for each threat: existing control, gap, recommended control, and where it lives (code, config, IAM, process). Prefer structural controls (least-privilege accounts, caps in code, secret manager) over guidance.
6. **Residual risk** the humans must accept explicitly.

## Format

```
# Threat Model — <feature> — <date>
Assets / Actors / Data flow
| # | Boundary | STRIDE | Threat | Likelihood | Impact | Mitigation | Status |
Residual risks for human sign-off: ...
```

`/talk-to sora "security findings: <path>"`. Anything High → also tell Yumi.
