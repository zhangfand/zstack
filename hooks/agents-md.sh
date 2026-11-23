#!/bin/sh
# Keeps a repo's agent instruction files named AGENTS.md. Claude Code reads
# AGENTS.md only in a folder with no CLAUDE.md, and a CLAUDE.local.md hides it
# too, so either name beside an AGENTS.md silently drops it.
#
# Usage: agents-md.sh check [dir]   list violations in the repo at dir; exit 1 if any
#        agents-md.sh session       SessionStart hook: tell the agent about violations
#        agents-md.sh pre-tool      PreToolUse hook: block writing a CLAUDE.md
#
# One CLAUDE.md is allowed: the user-level ~/.claude/CLAUDE.md, which has no
# AGENTS.md alternative, and its copy in a dotfiles repo (a .claude/CLAUDE.md
# below the repo root).
set -u

# Prints nothing and returns 0 when the path is allowed.
allowed() {
  case "$1" in
    */.claude/CLAUDE.md)
      owner="${1%/.claude/CLAUDE.md}"
      owner_real="$(cd "$owner" 2>/dev/null && pwd -P)" || return 0
      top="$(git -C "$owner_real" rev-parse --show-toplevel 2>/dev/null)" || return 0
      [ "$top" != "$owner_real" ]
      ;;
    *) return 1 ;;
  esac
}

violations() {
  top="$(git -C "${1:-.}" rev-parse --show-toplevel 2>/dev/null)" || return 0
  {
    git -C "$top" ls-files --cached --others --exclude-standard -- \
      ':(glob)**/CLAUDE.md' ':(glob)**/CLAUDE.local.md'
    # A CLAUDE.local.md is usually gitignored, so ls-files misses it.
    [ -e "$top/CLAUDE.local.md" ] && echo CLAUDE.local.md
  } | sort -u | while IFS= read -r rel; do
    [ -e "$top/$rel" ] || continue
    allowed "$top/$rel" || echo "$rel"
  done
}

case "${1:-}" in
  check)
    found="$(violations "${2:-.}")"
    [ -z "$found" ] && exit 0
    echo "$found"
    echo "agents-md: rename each file above to AGENTS.md (merge it into an AGENTS.md already beside it)" >&2
    exit 1
    ;;
  session)
    found="$(violations .)"
    [ -z "$found" ] && exit 0
    echo "## Agent instruction files"
    echo
    echo "The user keeps agent instructions in AGENTS.md only. This repo has these CLAUDE.md files, which hide any AGENTS.md beside them. Tell the user once, and offer to rename each to AGENTS.md:"
    echo
    echo "$found" | sed 's/^/- /'
    ;;
  pre-tool)
    # The first file_path is the tool's own, ahead of any content that quotes one.
    path="$(grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -n 1 | sed 's/.*"\([^"]*\)"$/\1/')"
    case "$path" in
      CLAUDE.md|*/CLAUDE.md|CLAUDE.local.md|*/CLAUDE.local.md) ;;
      *) exit 0 ;;
    esac
    allowed "$path" && exit 0
    echo "Write agent instructions to AGENTS.md, not $(basename "$path"). Claude Code reads AGENTS.md only in a folder with no CLAUDE.md or CLAUDE.local.md. If this file exists, move it to AGENTS.md first (git mv), or move a personal CLAUDE.local.md into agent memory." >&2
    exit 2
    ;;
  *)
    echo "usage: agents-md.sh check [dir] | session | pre-tool" >&2
    exit 64
    ;;
esac
