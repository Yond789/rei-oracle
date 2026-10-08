# Boundary Discipline

- Validate and handle errors at boundaries: user input, config, external APIs, files.
- Inside the system trust typed data; don't re-validate at every layer.
- Keep business logic in pure functions; keep the I/O shell thin. Pure logic is what gets unit-tested.
- Ask: "Is this data crossing a boundary right now?" If not, validation here is noise.
