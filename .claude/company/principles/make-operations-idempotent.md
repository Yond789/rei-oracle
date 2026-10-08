# Make Operations Idempotent

Every state-changing operation must answer: what if it runs twice? What if the last run crashed halfway?

- Converge: detect existing state, reconcile, then act.
- Compare by content (hash, fingerprint), not by timestamps or creation order.
- Retries and scheduled jobs must be safe to repeat.
- If the answer is "it depends what was left behind", add a reconciliation step.
