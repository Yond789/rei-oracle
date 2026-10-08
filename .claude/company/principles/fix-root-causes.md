# Fix Root Causes

- Reproduce first. If you can't reproduce it, you can't verify the fix.
- Ask "why" until you reach bedrock. A guard that silences an error is a symptom fix.
- Fix the pattern, not the instance: grep for the same mistake elsewhere.
- When stuck, instrument (logs, actual error output). Don't guess.
- "Broke after restart": suspect stale state (config, cache, lock files, tokens) before code.
