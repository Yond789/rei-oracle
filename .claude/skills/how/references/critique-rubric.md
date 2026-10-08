# Architecture Critique Rubric

Use only the lenses that apply.

- **Abstraction fit**: does each abstraction represent a real concept, with boundaries between things that change independently? Over-abstraction is as bad as under-abstraction.
- **Data model**: does it fit how data is actually accessed? Are types honest about runtime data?
- **Boundary discipline**: validation at entry points, errors handled at boundaries, testable in isolation?
- **Idempotency & failure**: what happens on retry, crash halfway, or duplicate events?
- **Evolution**: if the most likely next requirement landed tomorrow, is it one file or everything?
- **Complexity vs value**: is complexity where it must be (core logic) or accidental (wiring, config)?
- **Consistency**: same problems solved the same way as elsewhere? If not, is there a reason?
- **Cost & operations**: runaway cost paths, missing caps, observability, secrets handling.
