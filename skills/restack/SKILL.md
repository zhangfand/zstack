---
name: restack
description: Rebase the PRs left in a stack after the PR below them was squash-merged, with one script and no hand-resolved conflicts. Use when a PR in a stack merged, when a branch's base PR was squash-merged, or when a rebase onto the default branch conflicts on commits that already landed.
---

# Restack after a squash merge

Goal end-state: every surviving branch of the stack sits on the one below it, the bottom one on the trunk, all pushed, and the bottom PR targets the trunk.

## Steps

1. **Check whether the forge already did it.** On GitHub, `gh api repos/<owner>/<repo>/stacks` returns 404 when stacked PRs are off. When they are on and the PR merged through GitHub, the forge has already rebased and retargeted the stack: fetch, confirm, stop.

2. **Run the script** with the merged PR and the surviving branches, bottom first:

   ```sh
   node <skill-dir>/restack.ts --push '#<merged-pr>' <bottom-branch> ... <top-branch>
   ```

   `<skill-dir>` is the directory holding this file. It needs Node 22.18 or later and nothing installed. On a forge without `refs/pull/<N>/head`, pass the merged branch's last commit SHA instead of `#<N>`. When several PRs merged at once, pass the highest one.

3. **On a conflict**, the script stops mid-rebase. The conflict is real, not a squash artifact: resolve it, run `git rebase --continue`, then run the push command it printed.

4. **Retarget the bottom PR** to the trunk if it still targets the merged branch.

## Traps

- `--update-refs` moves every local branch that points into the rebased range, a backup branch included. Keep a backup as a tag.
- A plain `git rebase <trunk>` succeeds when the parent PR had one commit, and conflicts once it had two. Do not fall back to it.
- When the repo's CI runs only on PRs that target the default branch, stacked PRs get no CI until retargeted. Tell the user.
