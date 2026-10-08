---
name: dep-scan
description: Scan dependencies for known vulnerabilities and risky packages before anything ships; write DEP-SCAN.md. Use for "dep scan", "CVE check", "audit dependencies", whenever a manifest changes.
---

# Dependency Scan

## Run the real scanner for the ecosystem

| Manifest | Command |
|----------|---------|
| `package.json` | `npm audit --json` / `pnpm audit --json` / `bun audit` |
| `requirements.txt` / `pyproject.toml` | `pip-audit -r requirements.txt` (install: `pipx install pip-audit`) |
| `go.mod` | `govulncheck ./...` |
| `Cargo.toml` | `cargo audit` |
| Any (fallback) | `osv-scanner --recursive .` |

If the scanner is not installed, say so and install it or mark the scan UNVERIFIED. Never report "no vulnerabilities" without having run one.

## Also check
- Unpinned or wildcard versions in production manifests
- New dependencies in the diff: maintained? popular? typo-squat names? install scripts?
- Abandoned packages (no release > 2 years) on security-relevant paths

## Output — `DEP-SCAN.md`
```
# Dependency Scan — <repo> — <date> — scanner: <tool+version>
| Package | Version | Advisory (CVE/GHSA) | Severity | Fixed in | Reachable? | Action |
New deps reviewed: ...
```
Critical/High with a reachable path blocks ship (`/talk-to yumi`).
