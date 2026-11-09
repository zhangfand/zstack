#!/bin/sh
# Wires zstack into Codex: the bootstrap text into the global AGENTS file, and
# each zstack skill linked into ~/.agents/skills as zstack-<name>.
# Safe to rerun: it rewrites only its own marked block and its own links.
# Usage: setup-codex.sh [zstack root], defaulting to the root above this script.
set -eu
root="${1:-$(cd "$(dirname "$0")/.." && pwd)}"
[ -f "$root/router/bootstrap.sh" ] || { echo "setup-codex.sh: no zstack at $root" >&2; exit 1; }

codex_home="${CODEX_HOME:-$HOME/.codex}"
# Codex reads AGENTS.override.md instead of AGENTS.md when both exist.
agents="$codex_home/AGENTS.md"
[ -f "$codex_home/AGENTS.override.md" ] && agents="$codex_home/AGENTS.override.md"
mkdir -p "$codex_home"
touch "$agents"

begin='<!-- zstack:begin -->'
end='<!-- zstack:end -->'
block="$(mktemp)"
{ echo "$begin"; sh "$root/router/bootstrap.sh" "$root"; echo "$end"; } > "$block"
rest="$(mktemp)"
# Keep everything outside the old block, minus trailing blank lines.
awk -v b="$begin" -v e="$end" '
  $0==b {skip=1}
  !skip { if ($0=="") blanks++; else { while (blanks > 0) { print ""; blanks-- } print } }
  $0==e {skip=0}
' "$agents" > "$rest"
{ cat "$rest"; [ -s "$rest" ] && echo; cat "$block"; } > "$agents"
rm -f "$block" "$rest"
echo "wrote zstack block to $agents ($(wc -c < "$agents" | tr -d ' ') bytes; Codex reads up to 32768)"

skills_dir="$HOME/.agents/skills"
mkdir -p "$skills_dir"
for link in "$skills_dir"/zstack-*; do
  [ -L "$link" ] && [ ! -e "$link" ] && rm "$link" && echo "removed stale $link"
done
for dir in "$root"/skills/*/; do
  name="$(basename "$dir")"
  ln -sfn "${dir%/}" "$skills_dir/zstack-$name"
done
echo "linked $(ls -d "$root"/skills/*/ | wc -l | tr -d ' ') skills into $skills_dir"
