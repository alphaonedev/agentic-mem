# CLAUDE.md — universal thin overlay (adopts `the-standard`)

> **This file is a TEMPLATE.** Copy it to the root of any repo where an AI NHI (Claude Code, Claude Desktop, Codex, Grok, etc.) will do engineering work. Add ONLY repo-specific context below §R*. Never duplicate the standard's content — always reference.

## Global rule (non-negotiable)

Every AI NHI session on this repo:

1. **Imports `the-standard`** at session start — either:
   - `ai-memory` already has the namespace populated (via `the-standard` bundle import): `memory_namespace_get_standard the-standard`, `memory_get <bible-id>`, `memory_recall "<task keywords>"`.
   - Or import the bundle: `bash /path/to/the-standard/v*/import.sh sqlite` (or `json`).
2. **Adheres to the Bible.** The Bible is ai-memory namespace `the-standard` → the memory whose title begins with `THE STANDARD — AI NHI Bible`. If the Bible and ANY other doc conflict, the Bible wins. File an issue to remove the duplication.
3. **Memory-first discipline.** Before responding to ANY prompt, check memory. After ANY non-trivial finding, save it. `ai-memory` is your cortex — your context window is RAM, ephemeral; ai-memory is persistent. Never forget.
4. **Cite memory IDs** when referencing standards or prior decisions. Traceability beats cleverness.
5. **All work measured and executed per `the-standard`** — always, every project. Engineering, architecture, design, UX, delivery, security, documentation, issue tracking, commit discipline.

## Startup checklist (every session, every project)

```bash
# 1. Load the Bible.
memory_namespace_get_standard the-standard

# 2. Pull your project's plan memory + any recent RCA memories.
memory_recall "<your task keywords>"

# 3. Scan in-flight CI / issues before starting new work.
gh run list --workflow <ci>.yml --limit 3
gh issue list --state open --label <scope>

# 4. If the bundle is not yet imported, import now.
[ -f /path/to/the-standard/v*/the-standard.db ] && \
  bash /path/to/the-standard/v*/import.sh sqlite
```

## What to put under §R sections below

Repo-specific content ONLY:
- VPC CIDR maps / topology constants
- Step-timeout tables for this repo's CI
- Dispatch matrices for this repo's test harness
- In-flight matrix status (keep live)
- Authoritative references (EPIC issues, plan memories, test harness paths)

DO NOT duplicate from `the-standard`:
- General engineering standards
- RCA ladder
- Verification protocol
- Commit / PR / signing discipline
- Memory discipline
- Architecture / design / UX principles
- Security / PII / secret scanning

If you find yourself restating the Bible, STOP and just reference it.

---

## §R1. Authoritative references (fill in per repo)

- Tracking epic: <!-- issue URL -->
- Plan memory: `<memory-id>` in `ai-memory` namespace.
- Project standards memory: `<memory-id>` (inherits `parent=the-standard`).
- Test / harness paths: <!-- e.g. scripts/harness.py -->

## §R2. Enforced workflow watchdogs (if applicable)

<!-- table of step → normal duration → timeout -->

## §R3. Dispatch hygiene (if applicable)

<!-- matrix cells, concurrency rules, CIDR map, etc. -->

## §R4. Live status

<!-- keep this current every session -->

## §R5. Invariants specific to this repo

<!-- tests are Python stdlib only; etc. -->

---

## Version + provenance

- `the-standard` bundle version this repo follows: **v1.1.0**
- Bundle source: `alphaonedev/agentic-mem:the-standard/v1.1.0/`
- Bible memory id: `f57e9da1-08e5-4401-b5fc-fe909e97a1ec`

When `the-standard` is bumped, this file and the project's standards memory (inheritance overlay) must be re-aligned in a follow-up PR.
