#!/bin/sh
# Prints the always-on zstack context. Claude Code adds it at session start;
# scripts/setup-codex.sh writes the same text into the Codex AGENTS.md.
# Usage: bootstrap.sh [zstack root], defaulting to $CLAUDE_PLUGIN_ROOT.
set -eu
root="${1:-${CLAUDE_PLUGIN_ROOT:-}}"
if [ -z "$root" ] || [ ! -f "$root/router/README.md" ] || [ ! -f "$root/working-with-me.md" ] || [ ! -f "$root/rules/prs.md" ]; then
  echo "bootstrap.sh: pass the zstack root, or set CLAUDE_PLUGIN_ROOT" >&2
  exit 1
fi
# The rules for cutting work into PRs are printed in full, not only linked: an
# agent that reads them when it opens the PR has already written the diff.
cutting=$(awk '/^## /{on = ($0 == "## Cutting")} on && !/^## /' "$root/rules/prs.md" | sed '/./,$!d')
if [ -z "$cutting" ]; then
  echo "bootstrap.sh: rules/prs.md has no Cutting section" >&2
  exit 1
fi

cat <<TEXT
# zstack

zstack is the user's personal development flow, installed for every repo. Its rulebooks are in $root/rules and its skills in $root/skills.

## Working with the user

The user wrote these lines about how they work, so "I" is the user. They hold for every task.

TEXT
# The lines come from working-with-me.md, so this text never drifts from it.
sed -n '/^- /,$p' "$root/working-with-me.md"
cat <<TEXT

## Cutting work into PRs

These rules apply from the first edit.

TEXT
# The rules come from rules/prs.md, so this text never drifts from it.
printf '%s\n' "$cutting"
cat <<TEXT

## Rulebooks

Before writing any content in the table below, read the matching rulebook. That holds for content written in the middle of another task too, such as a code comment inside a code change.

TEXT
# The table and the precedence rule come from router/README.md, so this text
# never drifts from it. Links there are relative to router/.
sed -n '/^| When/,$p' "$root/router/README.md" | sed -E "s#\]\(\.\./#]($root/#g"
