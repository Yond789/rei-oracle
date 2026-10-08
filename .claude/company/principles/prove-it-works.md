# Prove It Works

Verify output by checking the real thing directly, not by inferring from proxies, self-reports or "it compiles".

- After any task ask: "How do I prove this actually works?"
- Build → run the real feature path → check data flows input to output → for integrations, test end to end.
- Delegated work: inspect the artifact (diff, file, runtime behavior), never the delegate's summary.
- When verification fails, suspect the observation method before the system.
- Say plainly what was verified and what was not. "Tests pass" is not "it works in production".
