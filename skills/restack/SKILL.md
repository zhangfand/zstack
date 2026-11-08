---
name: restack
description: Rebase the PRs left in a stack after the PR below them was squash-merged, with one script and no hand-resolved conflicts. Use when a PR in a stack merged, when a branch's base PR was squash-merged, or when a rebase onto the default branch conflicts on commits that already landed.
---

# Restack after a squash merge

A squash merge replaces the parent PR's commits with one new commit. A plain `git rebase <trunk>` on the child then replays the parent's original commits against that squash commit and conflicts on changes that already landed. Resolving those by hand costs tokens and risks a wrong resolution. `git rebase --update-refs --onto <trunk> <old-base> <top>` replays only the commits above the parent and moves every branch in between, so it has no such conflicts.

The parent's old head is the `<old-base>`. GitHub keeps it at `refs/pull/<N>/head` after the branch is deleted, so the recipe works from a fresh clone with no stacking tool and no local stack state.

## Steps

1. **Check whether the forge already did it.** On GitHub, `gh api repos/<owner>/<repo>/stacks` returns 404 when stacked PRs are off. When they are on and the PR was merged from the GitHub UI or `gh stack merge`, GitHub rebases the rest of the stack and retargets the next PR itself. Fetch and confirm each branch sits on the trunk, then stop.

2. **List the stack.** Find the merged PR's number and the surviving branches, bottom first. Each PR's base is the branch below it.

3. **Run the script** from a clean working tree, with no stack branch checked out in another worktree:

   ```sh
   <skill-dir>/restack.sh '#<merged-pr>' <bottom-branch> ... <top-branch>
   ```

   `<skill-dir>` is the directory holding this file. The script fetches the old head and the trunk, rebases, checks that each branch sits on the one below, and prints the push command. Add `--push` to push all branches in one atomic `--force-with-lease` push. `--trunk` and `--remote` override the defaults (the remote's `HEAD` and `origin`). Pass a SHA instead of `#<N>` on a forge without `refs/pull`.

4. **Retarget the next PR.** If the bottom surviving PR still targets the merged branch, change its base to the trunk. GitHub does this on its own when the merged branch was deleted.

5. **On a conflict**, the script stops mid-rebase. That conflict is real: the child and a later trunk commit changed the same lines. Resolve it, run `git rebase --continue`, then run the push command the script printed.

## Other cases

- **A lower PR got new commits** and nothing merged: `git rebase --update-refs <lower-branch> <top-branch>`, then force-push the branches above it. The shared history makes `--onto` unnecessary.
- **Several PRs merged at once:** pass the highest merged PR as `#<N>`. Its head contains the ones below it.
- **The repo merges with merge commits:** a plain rebase or merge works; this skill is not needed.

## Traps

- `--update-refs` skips any branch checked out in a worktree and leaves it stale without a warning. The script refuses to run in that case.
- `--update-refs` also moves every other local branch that points into the rebased range, such as a backup branch. Keep a backup as a tag instead.
- A plain rebase succeeds when the parent PR had exactly one commit, because git drops it as a cherry-pick. It conflicts as soon as the parent had two commits or a review fix, so do not rely on it.
- If the repo's CI runs only on PRs that target the default branch, stacked PRs get no CI until they are retargeted. Tell the user rather than working around it.
