#!/bin/sh
# Prints the always-on zstack context. Claude Code adds it at session start;
# scripts/setup-codex.sh writes the same text into the Codex AGENTS.md.
# Usage: bootstrap.sh [zstack root], defaulting to $CLAUDE_PLUGIN_ROOT.
set -eu
root="${1:-${CLAUDE_PLUGIN_ROOT:-}}"
if [ -z "$root" ] || [ ! -f "$root/rules/README.md" ]; then
  echo "bootstrap.sh: pass the zstack root, or set CLAUDE_PLUGIN_ROOT" >&2
  exit 1
fi

cat <<TEXT
# zstack

zstack is the user's personal development flow, installed for every repo. Its rulebooks are in $root/rules and its skills in $root/skills.

Before writing any content in the table below, read the matching rulebook. That holds for content written in the middle of another task too, such as a code comment inside a code change.

TEXT
# The table comes from rules/README.md, so this text never drifts from it.
grep '^|' "$root/rules/README.md" | sed -E "s#\]\(([^)]*)\)#]($root/rules/\1)#g"
cat <<'TEXT'

The repo's own CLAUDE.md, AGENTS.md and docs take precedence over zstack where they disagree. When the repo has its own rulebook for the same kind of content, read that one first, and use zstack only for what it leaves open.
TEXT
