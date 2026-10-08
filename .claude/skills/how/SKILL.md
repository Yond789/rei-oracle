---
name: how
description: Explain how a subsystem, feature or flow in a codebase works, at the level of a senior engineer onboarding; optionally critique the architecture. Use for "how does X work", "walk me through", "explain the architecture", "critique this design".
---

# How

Adapted from poteto/how (MIT). Two modes: **Explain** (default) and **Critique** (explain first, then independent critics).

## Explain

1. **Scope.** Restate what is being asked (subsystem, feature flow, overview, runtime trace). If ambiguous, state your interpretation and proceed; the user will redirect.
2. **Simple question** (one module, narrow): explore and explain yourself, or with one `Explore` subagent.
   **Complex question** (spans services/many files): split into 2–4 non-overlapping angles (e.g. data model / request path / background jobs). Spawn one `Explore` subagent per angle in a single message, using `references/explorer-prompt.md`. Then synthesize.
3. **Rules for exploring:** start broad (Glob/Grep for entry points), follow the call chain, read real code, stop when you can describe trigger → effect with no hand-waving. Note anything surprising.
4. **Output:**
   - **Overview**: 1–2 paragraphs: what it is, why it exists.
   - **Key Concepts**: only the types/services needed for the rest.
   - **How It Works**: the flow in prose, with `file:line` references. Code only when essential.
   - **Where Things Live**: short map of files to start from.
   - **Gotchas**: non-obvious behaviour, history, sharp edges.

## Critique

After explaining, review against `references/critique-rubric.md`. For independent opinions use `/adversarial-review` (a different model), or 2–3 `general-purpose` subagents each given the explanation, the file list and one rubric lens.

Then judge as a pragmatic lead, not an aggregator:
- **Act on**: worth fixing now
- **Consider**: real, unclear cost/benefit
- **Noted**: valid, low priority
- **Dismissed**: wrong, missing context, or taste

Present the explanation first, critique below it.
