# `the-standard` — portable AI NHI engineering Bible bundle

**Commercial secret sauce for AgenticMem (alphaonedev/agentic-mem, private).**

This bundle is the exportable, importable, reproducible form of `the-standard` — a versioned, universal AI NHI (non-human intelligence) governance + engineering standard. Any AI NHI (Claude Code CLI, Claude Desktop, Codex, Grok, Gemini, etc.) can import this bundle into its local `ai-memory` instance and adopt the standards instantly.

## Why this exists

AI NHIs are autonomous engineers. Without shared, durable, versioned governance, each session rediscovers standards from scratch. `the-standard` is:
- **Portable** — a single SQLite file + Markdown + YAML/JSON mirrors.
- **Importable** — `import.sh` drops it into any `ai-memory` instance.
- **Reproducible** — `build-bundle.sh` rebuilds from the canonical live `ai-memory` namespace.
- **Versioned** — semver. This is v1.1.0.

This is the differentiator that makes AgenticMem > plain ai-memory.

## Contents

| File | What |
|---|---|
| `the-standard.db` | SQLite subset — schema + memories for namespace `the-standard` + namespace_meta + links. Plug-compatible with `ai-memory-mcp`. |
| `THE_STANDARD.md` | Human-readable Bible (same content as the pinned ai-memory Bible entry). |
| `the-standard.yaml` | Machine-parseable mirror of every memory in the namespace. |
| `the-standard.json` | Structured JSON mirror, ideal for programmatic consumption. |
| `CLAUDE.md` | Universal thin-overlay template — any repo drops this in to adopt `the-standard`. |
| `import.sh` | Imports into a target `ai-memory` (SQLite merge OR JSON replay). |
| `build-bundle.sh` | Rebuilds every artifact from a live `ai-memory` source DB. |
| `manifest.json` | Bundle provenance (version, generation timestamp, Bible memory id). |
| `VERSION` | semver pin (current: `1.1.0`). |

## Import

### Fast path (local ai-memory)

```bash
bash import.sh sqlite [/path/to/target/ai-memory.db]
# If omitted, defaults to $AI_MEMORY_DB or ~/.claude/ai-memory.db.
```

### Portable path (any ai-memory reachable via CLI)

```bash
bash import.sh json
# Invokes `ai-memory store` for each memory in the bundle.
```

### Verification

```bash
ai-memory list --namespace the-standard
# Should list the Bible + any commercial-framing entries.

ai-memory namespace-standard get the-standard
# Should return the Bible memory as the pinned standard.
```

## Rebuild (maintainers only)

```bash
SOURCE_DB=/root/.claude/ai-memory.db bash build-bundle.sh
# Regenerates .db + .md + .yaml + .json + manifest from live namespace.
```

## Adopting in a new repo

1. Copy `CLAUDE.md` to the repo root.
2. Fill in `§R1–R5` with repo-specific context ONLY (no duplication of the Bible).
3. Add a line to the repo's README: *"This repo adheres to `the-standard` v1.1.0 — see CLAUDE.md."*
4. Bootstrap the ai-memory on any CI runner / dev box via `import.sh` so the AI NHI has the Bible on first session.

## Versioning policy

- **Patch (v1.1.x)** — clarifications, typo fixes.
- **Minor (v1.x.0)** — add sections (e.g., §13 project docs added in v1.1).
- **Major (vX.0.0)** — breaking changes to governance contract (require reviewer sign-off across repos adopting the bundle).

Every bump regenerates this bundle and cuts a release tag `standard-vX.Y.Z`.

## Canonical source

Bible memory id: **`f57e9da1-08e5-4401-b5fc-fe909e97a1ec`** in `ai-memory` namespace `the-standard`.

AgenticMem private tracking issue: [alphaonedev/agentic-mem#1](https://github.com/alphaonedev/agentic-mem/issues/1).

---

Authored by AI NHI Claude Opus 4.7 on behalf of AlphaOne LLC, 2026-04-22.
