#!/usr/bin/env bash
# Copyright 2026 AlphaOne LLC
# SPDX-License-Identifier: Apache-2.0
#
# Rebuild the-standard portable bundle from the live ai-memory database.
# Pulls the `the-standard` namespace subset into a standalone SQLite file,
# regenerates THE_STANDARD.md / YAML / JSON mirrors, and refreshes
# provenance metadata.
#
# Usage: SOURCE_DB=/path/to/ai-memory.db ./build-bundle.sh

set -euo pipefail
SOURCE_DB="${SOURCE_DB:-/root/.claude/ai-memory.db}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="$HERE/the-standard.db"
VERSION="$(cat "$HERE/VERSION")"
STAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

[ -f "$SOURCE_DB" ] || { echo "FATAL: source ai-memory DB not found: $SOURCE_DB" >&2; exit 1; }

echo "building the-standard-$VERSION bundle from $SOURCE_DB"
rm -f "$OUT"

# Step 1: portable SQLite. Copy schema + the-standard namespace subset.
# Keep the schema intact so an importer can just attach this file to
# a new ai-memory instance without running migrations.
sqlite3 "$SOURCE_DB" <<SQL
ATTACH DATABASE '$OUT' AS bundle;
CREATE TABLE bundle.schema_version AS SELECT * FROM schema_version;
CREATE TABLE bundle.memories AS SELECT * FROM memories WHERE namespace = 'the-standard';
CREATE TABLE bundle.namespace_meta AS SELECT * FROM namespace_meta WHERE namespace = 'the-standard';
CREATE TABLE bundle.memory_links AS SELECT l.* FROM memory_links l
  INNER JOIN memories m ON (m.id = l.source_id OR m.id = l.target_id)
  WHERE m.namespace = 'the-standard';
DETACH DATABASE bundle;
SQL

# Step 2: regenerate human + machine mirrors from the live DB.
# Bible is memory f57e9da1... by convention; pull it by id.
BIBLE_ID="$(sqlite3 "$SOURCE_DB" \
  "SELECT id FROM memories WHERE namespace='the-standard' AND title LIKE 'THE STANDARD%' LIMIT 1;")"
[ -n "$BIBLE_ID" ] || { echo "FATAL: bible memory missing in source DB" >&2; exit 1; }

sqlite3 "$SOURCE_DB" \
  "SELECT content FROM memories WHERE id='$BIBLE_ID';" > "$HERE/THE_STANDARD.md"

# YAML mirror: title, id, content, tags — one doc per memory in the namespace.
python3 <<PYEOF > "$HERE/the-standard.yaml"
import sqlite3, json, sys
conn = sqlite3.connect("$SOURCE_DB")
conn.row_factory = sqlite3.Row
rows = conn.execute(
    "SELECT id, title, content, tier, priority, tags, metadata, created_at, updated_at "
    "FROM memories WHERE namespace='the-standard' ORDER BY priority DESC, created_at"
).fetchall()
print("# the-standard bundle — YAML mirror of ai-memory namespace 'the-standard'")
print(f"# bundle_version: $VERSION")
print(f"# generated_at: $STAMP")
print(f"# source_db: $SOURCE_DB")
print(f"memories:")
for r in rows:
    print(f"  - id: {r['id']}")
    print(f"    title: {json.dumps(r['title'])}")
    print(f"    tier: {r['tier']}")
    print(f"    priority: {r['priority']}")
    print(f"    tags: {r['tags']}")
    print(f"    metadata: {r['metadata']}")
    print(f"    created_at: {r['created_at']}")
    print(f"    updated_at: {r['updated_at']}")
    # indent multi-line content
    content = r['content']
    print(f"    content: |")
    for line in content.splitlines():
        print(f"      {line}")
PYEOF

# JSON mirror — simpler structure for programmatic consumption.
python3 <<PYEOF > "$HERE/the-standard.json"
import sqlite3, json
conn = sqlite3.connect("$SOURCE_DB")
conn.row_factory = sqlite3.Row
rows = conn.execute(
    "SELECT id, title, content, tier, priority, tags, metadata, created_at, updated_at "
    "FROM memories WHERE namespace='the-standard' ORDER BY priority DESC, created_at"
).fetchall()
out = {
    "bundle_version": "$VERSION",
    "generated_at": "$STAMP",
    "namespace": "the-standard",
    "memory_count": len(rows),
    "memories": [
        {k: (json.loads(r[k]) if k in ("tags","metadata") else r[k]) for k in r.keys()}
        for r in rows
    ],
}
print(json.dumps(out, indent=2, sort_keys=True))
PYEOF

echo "  wrote $OUT"
echo "  wrote $HERE/THE_STANDARD.md"
echo "  wrote $HERE/the-standard.yaml"
echo "  wrote $HERE/the-standard.json"

# Provenance stamp for importers.
cat > "$HERE/manifest.json" <<MEOF
{
  "bundle_version": "$VERSION",
  "generated_at": "$STAMP",
  "source_db": "$SOURCE_DB",
  "contents": [
    "the-standard.db",
    "THE_STANDARD.md",
    "the-standard.yaml",
    "the-standard.json",
    "CLAUDE.md",
    "import.sh",
    "build-bundle.sh",
    "README.md",
    "VERSION"
  ],
  "bible_memory_id": "$BIBLE_ID"
}
MEOF
echo "  wrote $HERE/manifest.json"
echo "bundle ready"
