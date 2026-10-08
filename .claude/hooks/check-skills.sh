#!/bin/bash
# check-skills.sh — print skills this oracle's CLAUDE.md claims but are not installed.
# Scope: the "## Installed Skills" section plus this oracle's own row in the team table.
# Usage: check-skills.sh [repo_root]   (prints one /name per line; empty = no drift)
ROOT="${1:-${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)}}"
CLAUDE_MD="$ROOT/CLAUDE.md"
[ -f "$CLAUDE_MD" ] || exit 0
SELF=$(basename "$ROOT" | sed 's/-oracle$//')

{
  awk '/^## Installed Skills/{f=1;next} /^## /{f=0} f && !/Short codes/' "$CLAUDE_MD"
  grep -E "^\| \`$SELF\` \|" "$CLAUDE_MD"
} | grep -oE '`/[a-z0-9][a-z0-9-]*`' | tr -d '`/' | sort -u | while read -r s; do
  [ -d "$ROOT/.claude/skills/$s" ] || [ -d "$HOME/.claude/skills/$s" ] || echo "/$s"
done
