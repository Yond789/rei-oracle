---
name: adversarial-review
description: Challenge a diff, plan or design with a reviewer running on a DIFFERENT model, then give a lead verdict. Use for "adversarial review", "second opinion", "challenge this", before merging large changes or committing to a design.
---

# Adversarial Review

Adapted from poteto/noodle (MIT). The point is independence: a reviewer on the same model shares your blind spots.
The deliverable is a verdict. **Do not change code in this skill.**

## 1. Intent and scope

State in 2–3 lines what the author is trying to achieve. Reviewers judge whether the work achieves the intent well, not whether the intent is right.
Collect the material: `git diff <base>...HEAD`, the plan file, or the design doc. Write it to a temp file.

| Size | Lenses |
|------|--------|
| < 50 lines / 1–2 files | Skeptic |
| 50–200 lines / 3–5 files | Skeptic + Architect |
| > 200 lines or > 5 files, or a plan/design | Skeptic + Architect + Minimalist |

- **Skeptic**: what breaks? Edge cases, failure paths, retries, security, wrong assumptions, missing verification.
- **Architect**: boundaries, data model, idempotency, how the next likely change lands (see `how/references/critique-rubric.md`).
- **Minimalist**: what can be removed? Speculative features, duplicate paths, needless config.

## 2. Pick the opposing model (first available wins)

```bash
command -v codex  >/dev/null && echo codex    # if you are Claude
command -v gemini >/dev/null && echo gemini
command -v claude >/dev/null && echo claude   # if you are Codex
```

- `codex exec "<prompt>" < /dev/null` (read-only)
- `gemini -p "<prompt>"`
- `claude -p --model <a different model than yours> "<prompt>"`, the weakest option: same family. Say so in the verdict.

If none is available, run the lenses as `general-purpose` subagents and **label the verdict "same-model review"**.

Prompt per lens: intent, lens definition, the path of the material file, the company principles path (`.claude/company/principles/`), and: "Return numbered findings: severity (high/med/low), location, problem, concrete failure scenario, suggested fix. No praise."

Run lenses in parallel (background shells or one message of subagents).

## 3. Lead verdict

Verify each finding against the code yourself (prove-it-works). Then classify:

| Bucket | Meaning |
|--------|---------|
| **Must fix** | Real bug or risk, verified |
| **Should consider** | Real, cost/benefit unclear |
| **Noted** | Valid, low priority |
| **Dismissed** | Wrong or missing context (say why) |

Output: reviewer model(s) used, intent, the table of findings by bucket, and a one-line overall verdict (ship / fix first / rethink).
