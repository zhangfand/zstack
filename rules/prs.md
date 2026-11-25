# Pull Requests

The diff already carries what changed and where. A PR description carries only what the diff cannot: why the change exists, its shape at a glance, and how it was proven. Prose follows [writing.md](writing.md).

## Cutting

**A PR either refactors or changes behavior, never both.**

**Try to keep a PR under 400 changed lines.**

**Each PR can merge by itself and leaves main working.**

## Title

**The title is a Conventional Commit.** It takes the form `<type>[(<scope>)][!]: <subject>`, with a lower-case type and scope. Allowed types: `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`. Squash-and-merge makes the title the commit subject on the default branch.

**The subject says what a teammate would notice, in words they already use.** Name the feature and what is different now. A fix names the problem it ends. One change only: if the subject needs "and" or ";", name the bigger change. Keep it under about 60 characters.

> Prefer: `fix(chat): line up agent names and action icons with chat bubbles`
> Over: `fix(chat): put action icons and agent names on the bubble edge`

## Body

**The body runs to 30 lines or fewer, screenshots excluded.** Use these sections in this order. A section with nothing to say is left out, never filled with a placeholder.

| Section | When | Budget |
|---|---|---|
| Why | Always | 1–3 sentences |
| Sketch | Always | One small block, about 10 lines |
| Scope | Always | Up to 3 bullets |
| Merge danger | Always | 1–2 lines |
| Evidence | Always | Up to 3 bullets |

### Why

**Open with the problem, not the change.** Say what was missing, broken, or accreted.

> Prefer: "A crash mid-install left the app half-registered, because two paths could write the lockfile."
> Over: "Adds `installLock` to `AppManager`, updates `install.ts`, adds a test."

### Sketch

**Show the shape of the change as a picture.** Use a `diff` of an API, a call tree, a component tree, or a file tree, and keep only the parts that carry the change. A `refactor:` PR uses the sketch as its contract, since its contract is the code structure.

```diff
 AgentSession
-  sendTurn(input)
-  submitInput(input, onTurn)
+  submit(input, { priority: now | next | after })
```

### Scope

**Say what the PR covers and what it leaves out.** One bullet per deferral, with a one-clause reason or pointer. When a real alternative existed, one bullet names it and what ruled it out, since the code keeps no record of a rejected design.

### Merge danger

**Say whether a revert undoes the change, and what it touches.** A migration, a deleted record, or a published API is a one-way door. Name the blast radius and why it is safe.

### Evidence

**List the behaviors the PR proves, each as a scenario and its outcome.** Mark an item "fails without the change" when it does.

> Prefer: "- Two bots, remove one: the user still reaches the app through the other. Fails without the change."
> Over: "- New cases in `connections.test.ts`."

**Leave out what CI checks on every PR.** List a CI job only when the PR changes what it checks.

**When a user would see the change, show it.** Paste one phone screenshot (390×844) and one desktop screenshot (1280×900). Never commit them.
