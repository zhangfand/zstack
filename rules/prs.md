# Pull Requests

The diff already carries what changed and where. A PR description carries only what the diff cannot: why the change exists, the rules it must keep, and how it was proven. Prose follows [writing.md](writing.md).

## Title

**The title is a Conventional Commit.** It takes the form `<type>[(<scope>)][!]: <subject>`, with a lower-case type and scope. Allowed types: `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`. Squash-and-merge makes the title the commit subject on the default branch.

> Prefer: `feat(api): add request timeout error`
> Over: `Add request timeout error to the API`

## Body

**The body runs to 30 lines or fewer, screenshots excluded.** A section with nothing to say is left out, never filled with a placeholder.

| Section | When | Budget |
|---|---|---|
| Why | Always | 1–3 sentences |
| Changes | Only when the diff does not make the shape obvious | 5 bullets |
| Invariants | Only when the PR adds or changes a product rule | 3 bullets |
| Tradeoffs | Only when a real alternative existed | 2 lines |
| Verification | Always | One line per behavior |
| Not in this PR | When the PR defers something | One line each |

### Why

**Open with the problem, not the change.** Say what was missing, broken, or accreted.

> Prefer: "A crash mid-install left the app half-registered, because two paths could write the lockfile."
> Over: "Adds `installLock` to `AppManager`, updates `install.ts`, adds a test."

### Invariants

**State each invariant as behavior a reader can check in the product.** An invariant names no file, function, type, or field. A `refactor:` PR is the exception: its contract is the code structure, so it names the modules it moves.

> Prefer: "Removing one bot never cuts the user off from the others."
> Over: "Teardown deletes `channel_mappings` only when `connectionsHoldingIn()` is empty."

### Tradeoffs

**Name the alternative and what ruled it out.** The code keeps no record of a rejected design.

### Verification

**List the behaviors the PR proves, each as a scenario and its outcome.** It is a checklist: `[x]` for verified, `[ ]` for what remains. Mark an item "fails without the change" when it does.

> Prefer: "- [x] Two bots, remove one: the user still reaches the app through the other. Fails without the change."
> Over: "- [x] New cases in `connections.test.ts`."

**Leave out what CI checks on every PR.** List a CI job only when the PR changes what it checks.

**When a user would see the change, show it.** Paste one phone screenshot (390×844) and one desktop screenshot (1280×900). Never commit them.

### Not in this PR

**One line per deferral.** Name the deferred thing and give a one-clause reason or pointer.
