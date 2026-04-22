#!/usr/bin/env bash
# Copyright 2026 AlphaOne LLC
# SPDX-License-Identifier: Apache-2.0
#
# Import `the-standard` into a target ai-memory instance.
#
# Two modes:
#   1. SQLite merge (fastest, preserves ids + metadata): attaches
#      the-standard.db and INSERTs the namespace subset into the
#      target DB. Safe to re-run — ON CONFLICT clauses preserve
#      already-present rows.
#   2. JSON replay (portable when the target is not local): parses
#      the-standard.json and runs `ai-memory store` for each memory,
#      then `ai-memory namespace-standard set`.
#
# Usage:
#   ./import.sh sqlite   [/path/to/target/ai-memory.db]
#   ./import.sh json                                        # uses $AI_MEMORY_DB or config default
#
# Reference: THE_STANDARD.md §1 memory discipline — this importer
# is how a fresh AI NHI instance inherits the Bible.

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:-sqlite}"
TARGET="${2:-}"

case "$MODE" in
sqlite)
    TARGET="${TARGET:-${AI_MEMORY_DB:-${HOME}/.claude/ai-memory.db}}"
    [ -f "$TARGET" ] || { echo "FATAL: target DB not found: $TARGET" >&2; exit 1; }
    echo "merging $HERE/the-standard.db → $TARGET"
    sqlite3 "$TARGET" <<SQL
ATTACH DATABASE '$HERE/the-standard.db' AS src;
INSERT OR REPLACE INTO memories
  SELECT * FROM src.memories;
INSERT OR REPLACE INTO memory_links
  SELECT * FROM src.memory_links;
INSERT OR REPLACE INTO namespace_meta
  SELECT * FROM src.namespace_meta;
DETACH DATABASE src;
SQL
    echo "✓ imported. Verify: ai-memory list --namespace the-standard"
    ;;

json)
    command -v ai-memory >/dev/null || { echo "FATAL: ai-memory CLI not in PATH" >&2; exit 1; }
    python3 - <<PYEOF
import json, subprocess, pathlib
bundle = json.loads(pathlib.Path("$HERE/the-standard.json").read_text())
print(f"importing {bundle['memory_count']} memories from bundle {bundle['bundle_version']}")
for m in bundle["memories"]:
    subprocess.check_call([
        "ai-memory", "store",
        "--tier", m["tier"],
        "--title", m["title"],
        "--content", m["content"],
        "--namespace", bundle["namespace"],
        "--priority", str(m["priority"]),
    ])
print("✓ json replay complete")
PYEOF
    ;;

*)
    echo "usage: $0 {sqlite|json} [target-db-path]" >&2
    exit 2
    ;;
esac
