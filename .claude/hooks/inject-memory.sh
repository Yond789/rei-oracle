#!/bin/bash
# inject-memory.sh — SessionStart hook. Prints a short index of this oracle's memory
# so every session starts with it in context (no reliance on remembering /recap).
# Installed by echo-oracle/company/install.sh — edit the source there, not the copy.
cat > /dev/null  # consume hook input

ROOT="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)}"
cd "$ROOT" 2>/dev/null || exit 0
PSI="ψ"
title() { sed -n 's/^# //p' "$1" | head -1; }

echo "# Oracle memory (auto-loaded at session start)"
echo "Read the files relevant to the task before acting. Paths are relative to $ROOT."

P=".claude/company/principles/index.md"
if [ -f "$P" ]; then
  echo
  echo "## Company principles (full text: .claude/company/principles/)"
  grep -E '^\| [0-9]+ \|' "$P" | awk -F'|' '{gsub(/\[|\]\([^)]*\)/,"",$3); gsub(/^ +| +$/,"",$3); gsub(/^ +| +$/,"",$4); print "- " $3 ": " $4}'
fi

H=$(find "$PSI/inbox/handoff" -name '*.md' 2>/dev/null | sort | tail -1)
if [ -n "$H" ]; then
  echo
  echo "## Latest handoff"
  echo "- $H — $(title "$H")"
fi

R=$(find "$PSI/memory/retrospectives" -name '*.md' 2>/dev/null | sort | tail -3)
if [ -n "$R" ]; then
  NEWEST=$(echo "$R" | tail -1)
  AGE=$(( ( $(date +%s) - $(stat -f %m "$NEWEST" 2>/dev/null || stat -c %Y "$NEWEST") ) / 86400 ))
  echo
  echo "## Recent retrospectives (newest is $AGE days old)"
  [ "$AGE" -gt 7 ] && echo "⚠ No /rrr in over a week — run /rrr at the end of this session."
  echo "$R" | sort -r | while read -r f; do echo "- $f — $(title "$f")"; done
fi

L=$(find "$PSI/memory/learnings" -name '*.md' 2>/dev/null | sort)
if [ -n "$L" ]; then
  N=$(echo "$L" | wc -l | tr -d ' ')
  echo
  echo "## Learnings ($N total, newest 10)"
  echo "$L" | tail -10 | sort -r | while read -r f; do echo "- $f — $(title "$f")"; done
fi

if [ -z "$R$L$H" ]; then
  echo
  echo "## No retrospectives, learnings or handoffs yet"
  echo "Run /rrr at the end of this session so the next one starts with context."
fi

if [ -x .claude/hooks/check-skills.sh ]; then
  D=$(.claude/hooks/check-skills.sh "$ROOT" | tr '\n' ' ')
  if [ -n "$D" ]; then
    echo
    echo "## ⚠ Skill drift"
    echo "CLAUDE.md lists skills that are not installed: $D"
    echo "Do not improvise them silently; tell the human, or fix via echo-oracle/company/install.sh."
  fi
fi
exit 0
