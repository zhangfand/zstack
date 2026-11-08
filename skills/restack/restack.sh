#!/usr/bin/env bash
# Rebase the branches left in a stack after the PR below them was squash-merged.
#
# Usage: restack.sh [--trunk <branch>] [--remote <name>] [--push] <old-base> <branch>...
#
#   <old-base>  the merged parent's last commit: a SHA, a ref, or "#<N>" for
#               PR N on GitHub, read from refs/pull/<N>/head.
#   <branch>    the surviving branches, bottom first. The last one is the top.
#
# A plain rebase replays the parent's original commits against its squash
# commit and conflicts. `--onto <trunk> <old-base>` replays only the commits
# above the parent, and `--update-refs` moves every branch in between.
set -euo pipefail

remote=origin trunk="" push=0
while [ $# -gt 0 ]; do
  case $1 in
    --trunk) trunk=$2; shift 2 ;;
    --remote) remote=$2; shift 2 ;;
    --push) push=1; shift ;;
    -h|--help) sed -n '2,13p' "$0"; exit 0 ;;
    --) shift; break ;;
    -*) echo "restack: unknown flag $1" >&2; exit 2 ;;
    *) break ;;
  esac
done
[ $# -ge 2 ] || { echo "usage: restack.sh [--trunk B] [--remote R] [--push] <old-base> <branch>..." >&2; exit 2; }
old=$1; shift
branches=("$@")
top=${branches[-1]}

if [ -z "$trunk" ]; then
  trunk=$(git symbolic-ref --quiet --short "refs/remotes/$remote/HEAD" 2>/dev/null | sed "s|^$remote/||") || true
  [ -n "$trunk" ] || trunk=main
fi

if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
  echo "restack: the working tree has uncommitted changes; commit or stash them first" >&2; exit 1
fi

# --update-refs skips any branch checked out in a worktree, this one included,
# and leaves it stale without a warning.
checked_out=$(git worktree list --porcelain | sed -n 's|^branch refs/heads/||p')
for b in "${branches[@]}"; do
  git rev-parse --verify --quiet "refs/heads/$b" >/dev/null || { echo "restack: no local branch $b" >&2; exit 1; }
  if grep -qxF "$b" <<<"$checked_out" && [ "$(git symbolic-ref --quiet --short HEAD || true)" != "$b" ]; then
    echo "restack: $b is checked out in another worktree; switch that worktree away first" >&2; exit 1
  fi
done

if [[ $old == \#* ]]; then
  git fetch --quiet "$remote" "refs/pull/${old#\#}/head"
  old=$(git rev-parse FETCH_HEAD)
fi
onto="refs/remotes/$remote/$trunk"
git fetch --quiet "$remote" "+refs/heads/$trunk:$onto"

git merge-base --is-ancestor "$old" "$top" || {
  echo "restack: $old is not in $top's history; it is not this stack's old base" >&2; exit 1; }

if ! git rebase --update-refs --onto "$onto" "$old" "$top"; then
  echo "restack: real conflict, not a squash artifact. Resolve it and run 'git rebase --continue';" >&2
  echo "then push with: git push --atomic --force-with-lease $remote ${branches[*]}" >&2
  exit 1
fi

status=0
prev=$onto
for b in "${branches[@]}"; do
  if ! git merge-base --is-ancestor "$prev" "$b"; then
    echo "restack: $b does not sit on $prev after the rebase" >&2; status=1
  fi
  prev=$b
done
[ $status -eq 0 ] || exit 1

for b in "${branches[@]}"; do
  echo "$b: $(git rev-list --count "$onto..$b") commit(s) above $remote/$trunk"
done

if [ $push -eq 1 ]; then
  git push --atomic --force-with-lease "$remote" "${branches[@]}"
else
  echo "push with: git push --atomic --force-with-lease $remote ${branches[*]}"
fi
