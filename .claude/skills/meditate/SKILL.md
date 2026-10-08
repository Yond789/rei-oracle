---
name: meditate
description: Audit and evolve this oracle's memory and instructions — archive stale notes, merge duplicates, fix CLAUDE.md drift, turn repeated lessons into hooks/scripts/skill changes. Use monthly or when the user says "meditate", "audit memory", "clean up the brain".
---

# Meditate

Monthly maintenance for an oracle's memory (`ψ/memory/`), `CLAUDE.md` and auto-memory.
Quality bar: a note earns its place only if it is **high-signal** (the agent would get this wrong without it), **high-frequency** (comes up often) or **high-impact** (getting it wrong is costly).

Nothing is Deleted: outdated notes are **moved** to `ψ/archive/meditate-YYYY-MM-DD/`, never removed.

## 1. Snapshot (one read instead of dozens)

```bash
ROOT=$(git rev-parse --show-toplevel); SNAP=$(mktemp -d)
find "$ROOT/ψ/memory" -name '*.md' | sort | while read -r f; do echo "=== ${f#$ROOT/} ==="; cat "$f"; done > "$SNAP/memory.md"
wc -c "$SNAP/memory.md"
```

If the snapshot is over ~150 KB, hand it to one `general-purpose` subagent as the auditor instead of reading it yourself.

## 2. Structural checks (scripts, not judgment)

```bash
.claude/hooks/check-skills.sh "$ROOT"     # skills CLAUDE.md claims but are not installed
```

Also check: every path mentioned in CLAUDE.md exists; the team table matches the repos in `~/repos/*-oracle`.

## 3. Audit (judgment)

For each memory note, CLAUDE.md section and auto-memory entry (`~/.claude/projects/<project>/memory/`), flag:

| Flag | Meaning | Action |
|------|---------|--------|
| Outdated | References work, tools or decisions that changed | Update, or archive |
| Redundant | Says what another note says | Merge into the stronger one, archive the other |
| Low-value | Fails the quality bar | Archive |
| Verbose | Same content in fewer words is possible | Condense |
| Stale session state | Finished tasks, old IDs | Archive or rewrite |
| Drift | CLAUDE.md claims something untrue (e.g. skills from step 2) | Fix CLAUDE.md or install the skill |

## 4. Distil and route (the important step)

Look across notes for patterns that repeat in **2+ separate notes**. For each, apply `encode-lessons-in-structure`:

1. Can it be a hook, script, test or a step in a skill? → make that change (or file a todo with the owner oracle) and archive the note.
2. Is it a new, independent principle? → propose it for `echo-oracle/company/principles/` (Echo owns that folder; tell the human).
3. Otherwise → keep as one condensed learning note.

## 5. Report, then apply

Present to the human first (CLAUDE.md: humans keep decisions):

```
## Meditate — <oracle> — YYYY-MM-DD
- Archive: N notes (one line each, why)
- Merge: N → M
- Condense: N
- CLAUDE.md fixes: N (list)
- Structural changes proposed: N (what mechanism replaces which note)
- New principles proposed: N (with evidence count)
```

Apply only what is approved. Commit with `docs: meditate — <summary>`.
