# AGENTS.md Files

An **AGENTS.md** is a file of repo guidance that its own location loads into agent context. The root file loads on every turn of every session. A nested file loads when the agent works in that directory. This file defines the format of an AGENTS.md and the bar an entry clears to enter one. It governs `AGENTS.md` files only, not skills. Prose rules come from [writing.md](writing.md).

The miss this family guards against is bloat. An entry that restates a source of truth elsewhere spends context on every load and goes stale when that source moves. It takes two shapes here: one rule copied into several files, so a change lands in one and not the others, and a reference doc parked inside a package's AGENTS.md, where it loads on every turn that touches the package.

## Format

**The file is named `AGENTS.md`, never `CLAUDE.md`.** Claude Code reads an `AGENTS.md` only in a folder with no `CLAUDE.md` and no `CLAUDE.local.md`, so either name beside it silently drops it, and Codex reads only `AGENTS.md`. The one `CLAUDE.md` is the user-level `~/.claude/CLAUDE.md`, which has no `AGENTS.md` alternative, with its copy in a dotfiles repo. The zstack hooks block writing any other, and `sh hooks/agents-md.sh check` lists them in a repo.

> Prefer: `packages/web/AGENTS.md`, and a personal note in agent memory.
> Over: `packages/web/CLAUDE.md`, an `AGENTS.md` symlink to a `CLAUDE.md`, or a `CLAUDE.local.md`.

**An AGENTS.md is titled by what it governs.** It sits at the repo root, or at the root of a directory whose contents share the same guidance. It opens with an H1 naming what it governs: the repo, the package, or the directory path. A topic title fails.

> Prefer: `# web`, `# docs/ui/`.
> Over: `# Design System`, `# Documentation Rules`.

**Every entry pairs a condition with an action.** The condition comes first, per [writing.md](writing.md#structure).

> Prefer: "Before opening a PR, read [`prs.md`](prs.md)."
> Over: "[`prs.md`](prs.md) — the rulebook for the title and every description section."

**The body holds at most `## Playbook` then `## Traps`.** A file may omit either. A file with nothing to say is an empty file, and an empty file is deleted.

**An orientation lead is allowed when the environment cannot answer it.** Before the first section, the file may carry a lead: what this directory is, and where its parts sit. The lead is the one place an entry states a fact rather than pairing a condition with an action.

> Prefer: a lead naming each package and its role, where the `package.json` files carry no `description`.
> Over: a lead restating a directory listing.

**The root file runs to 80 lines, every other file to 50.**

**Only `## Traps` may contain a fenced code block.**

**Link other files, never import them.** No entry uses the `@path` import syntax, which loads the target on every load of this file.

### Playbook

**A playbook entry states the trigger and the next move, then stops.** A **playbook** entry sends the agent to the doc or the command that handles the condition. Unlike a runbook, which walks one procedure start to finish, a playbook entry states the trigger and the next move, and stops.

**Each entry is one bullet.**

### Traps

**A trap is a wrong default that every gate passes.** Unlike a known issue, which some check reports, a trap leaves typecheck, lint, and the test suite green.

**Each trap is a paragraph led by a bold sentence** naming the wrong default, followed by the correct call. No entry uses a heading.

## What to keep

**Every entry names the failure it prevents.** If the author cannot state what the agent does wrong without the entry, the entry stays out.

> Prefer: "Apps render inside a Shadow DOM. A portal that escapes it silently loses the app's styles."
> Over: "Apps render inside a Shadow DOM."

**Four tests reject an entry.**

**Default: the agent does it anyway.** Leave out what the agent does without being told.

> Prefer: "All imports use `.js` extensions, even for TypeScript files."
> Over: "Read the existing code before changing it."

**Lookup: point at the source.** When one file or one command holds the answer and the agent looks there on its own, point at that source instead of copying it.

> Prefer: "Root `package.json` scripts delegate to the right workspace. Read it for the full list."
> Over: a fenced block listing `dev`, `build`, `typecheck`, and `lint`.

**Aspiration: no failure behind it.** Leave out an entry when nothing goes wrong if the agent ignores it.

> Prefer: "Sequence a migration so the break lands last, or behind a switch."
> Over: "Keep the codebase healthy."

**Scope: it applies to only some of the work.** A procedure that runs on some tasks becomes a skill, and reference material becomes a doc under `docs/`. The file keeps a `Playbook` entry naming the trigger.

> Prefer: "Before building or editing a plugin, read `plugins/authoring/SKILL.md`."
> Over: the create and scaffold steps written out in `plugins/AGENTS.md`.

**A playbook entry must change the next move.** It enters when the agent, meeting the condition, would otherwise take a different action.

> Prefer: "When doing frontend-only work in `packages/web`, use `pnpm start:web:mock`."
> Over: "`pnpm start:web:mock` runs the dashboard against mock data."

**A trap must survive every gate.** It enters when typecheck, lint, and the test suite all pass and the code is still wrong. If a gate catches it, fix the gate.

> Prefer: "Floating UI portals into `document.body`, outside the app's shadow root, where it silently drops the app's styles. Pass `getPortalContainer()` to every `Portal`."
> Over: "Sort imports before committing."

**An entry points at values, it does not copy them.** It names the failure and the corrective action, and carries no values, utility classes, or token names that a doc already owns — those sit behind the pointer, where one edit updates them.

> Prefer: "Focus renders invisible when only part of the outline recipe is written. `docs/design-system.md` carries the full set."
> Over: the same entry with the five focus utilities spelled out in a fenced block.

**A nested file holds only what is new for its directory.** An entry enters a nested file when it holds in that directory and no file above already states it.

> Prefer: a nested SDK file holding only the CLI naming rule.
> Over: two nested SDK files repeating the release rule the root file already states.

## When to cut

**An entry leaves when its failure can no longer happen.**

**Recheck the file when its directory changes.** Re-run the bar on that directory's file. An entry that now fails leaves.

**Overflow moves out, it does not vanish.** When a file exceeds its line budget, the overflow leaves and the file keeps one `Playbook` entry pointing at it. Content that fails "What to keep" but stays true moves rather than disappears, and it moves by kind: a procedure the agent runs on some tasks becomes a skill, and reference material becomes a doc under `docs/`.

**When the agent ignores an entry, cut entries.** The file is too long. Emphasis does not recover a rule the file lost in noise.

## When to add a rule

**A recurring correction gets an answer.** It becomes an entry, or the maintainer rejects it in writing and states the reason. A correction that recurs with neither outcome means the file is dead.

**A question an entry already answers means the entry is ambiguous.** Rewrite it, or cut it.

**An entry lands in the file closest to the code it governs.**

> Prefer: a rule about `packages/ui` landing in `packages/ui/AGENTS.md`.
> Over: the same rule landing in the root file.
