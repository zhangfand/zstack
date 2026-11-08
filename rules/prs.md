# Pull Requests

The diff already carries what changed and where. A PR description carries only what the diff cannot: why the change exists, the rules it must keep, and how it was proven. Prose follows [writing.md](writing.md).

## Title

A PR title is a Conventional Commit: `<type>[(<scope>)][!]: <subject>`, with a lower-case type and scope. Allowed types: `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`. Squash-and-merge makes the title the commit subject on the default branch. `[mech]`

> Prefer: `feat(api): add request timeout error`
> Over: `Add request timeout error to the API`

## Body

The body runs to 30 lines or fewer, screenshots excluded. A section with nothing to say is left out, never filled with a placeholder. `[mech]`

| Section | When | Budget |
|---|---|---|
| Why | Always | 1–3 sentences |
| Changes | Only when the diff does not make the shape obvious | 5 bullets |
| Invariants | Only when the PR adds or changes a product rule | 3 bullets |
| Tradeoffs | Only when a real alternative existed | 2 lines |
| Verification | Always | One line per behavior |
| Not in this PR | When the PR defers something | One line each |

### Why

Open with the problem: what was missing, broken, or accreted. Not with what changed. `[llm]`

> Prefer: "A crash mid-install left the app half-registered, because two paths could write the lockfile."
> Over: "Adds `installLock` to `AppManager`, updates `install.ts`, adds a test."

### Invariants

State each rule as behavior a reader checks against the product without opening the code. An invariant names no file, function, type, or field. A `refactor:` PR is the exception: its contract is the code structure, so it names the modules it moves. `[llm]`

> Prefer: "Removing one bot never cuts the user off from the others."
> Over: "Teardown deletes `channel_mappings` only when `connectionsHoldingIn()` is empty."

### Tradeoffs

Name the alternative and the force that ruled it out. The code keeps no record of a rejected design.

### Verification

A checklist of the behaviors the PR proves: `[x]` for verified, `[ ]` for what remains. Each item is a scenario and its observable outcome. Mark an item "fails without the change" when it does. `[llm]`

> Prefer: "- [x] Two bots, remove one: the user still reaches the app through the other. Fails without the change."
> Over: "- [x] New cases in `connections.test.ts`."

Leave out the checks CI runs on every PR. List a CI job only when the PR changes what it checks.

When the PR changes what a user sees, paste one phone screenshot (390×844) and one desktop screenshot (1280×900). Never commit them.

### Not in this PR

One line per deferral: the deferred thing and a one-clause reason or pointer.
