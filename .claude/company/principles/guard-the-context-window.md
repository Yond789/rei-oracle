# Guard the Context Window

Context is finite within a session and cannot be reclaimed.

- Send large payloads (logs, big files, screenshots) to subagents; keep summaries in the main context.
- Read selectively. Don't read what you won't use.
- Content needed on every run belongs inline in the skill; rare detail goes in references/.
- Memory and indexes loaded at startup must stay short. Link, don't inline.
