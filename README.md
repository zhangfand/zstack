# zstack

A personal development flow for working with coding agents: the rules and skills that hold in any repo. Project-specific rules stay in each project's own `AGENTS.md` and `docs/`.

## Install

In Claude Code:

```
/plugin marketplace add zhangfand/zstack
/plugin install zstack@zstack
```

Then run `/zstack:setup`. It turns on marketplace auto-update and the Codex side.

## Layout

zstack has three layers. The router dispatches, skills document workflows, and rules hold judgments. Beside them, [`working-with-me.md`](working-with-me.md) says how I work, and every session reads it in full.

- [`router/`](router/README.md): what to load for a task.
  - [`README.md`](router/README.md): the table from kind of content to rulebook, and the precedence rule.
  - [`bootstrap.sh`](router/bootstrap.sh): prints `working-with-me.md`, the rules for cutting work into PRs, and the table into every session. The SessionStart hook in [`hooks/`](hooks/) runs it, and [`scripts/setup-codex.sh`](scripts/setup-codex.sh) writes the same text into the Codex `AGENTS.md`.
- [`hooks/agents-md.sh`](hooks/agents-md.sh): keeps agent instruction files named `AGENTS.md`. It lists a repo's `CLAUDE.md` files at session start and blocks the agent from writing one.
- [`skills/`](skills/): procedures the agent runs on some tasks. Each one routes itself through its description.
  - `rules`: load the matching rulebook before writing. It is the router's entry point for a session that missed the bootstrap text.
  - `respond-to-review`, `babysit-pr`: drive a PR through review and CI.
  - `ddd`: build a shared domain language with a person as the domain expert.
  - `research-first`: survey and test prior art before building a new workflow, then write it as a skill.
  - `pursue-goal`: turn an ambiguous goal into rules agreed with the person, then build and evaluate until every rule passes.
  - `write-promises`: agree with the person on what one component promises, and write the list into the component's `AGENTS.md`.
  - `check-promises`: find where code breaks what a component promises in its `AGENTS.md`, mark each place, and get the person's verdict on each.
  - `setup`: install or repair zstack for Claude Code and Codex on this machine.
- [`rules/`](rules/README.md): rulebooks, one per kind of content.
  - [`writing.md`](rules/writing.md): prose rules for docs, PR text, issues, and comments.
  - [`prs.md`](rules/prs.md): PR title and a short PR body.
  - [`comments.md`](rules/comments.md): when a code comment exists and what it says.
  - [`engineering.md`](rules/engineering.md): traps that pass every gate.
  - [`abstraction.md`](rules/abstraction.md): designing one interface, at any scale.
  - [`architecture.md`](rules/architecture.md): how components own decisions, depend on, and talk to each other.
  - [`agents-md.md`](rules/agents-md.md): the format of `AGENTS.md` files and what to keep in them.
  - [`skills.md`](rules/skills.md): the format of skills and what to keep in them.
  - [`rulebooks.md`](rules/rulebooks.md): how to write a new rulebook.

## Using it from a repo

zstack is installed per machine, never per repo, so it works in repos you do not own and nothing gets committed.

| Situation | Do this |
|---|---|
| Any repo | Nothing. zstack applies. |
| The repo has its own `CLAUDE.md`, `AGENTS.md`, or rulebooks | Nothing. The repo wins where the two disagree, and its rulebook is read first. |
| zstack clashes with a repo | Set `"enabledPlugins": {"zstack@zstack": false}` in that repo's `.claude/settings.local.json`. |
| You want a personal note for one repo | Leave it to the agent's memory. A `CLAUDE.local.md` stops Claude Code from reading `AGENTS.md`. |
| You want to find `CLAUDE.md` files in a repo | Run `sh <zstack root>/hooks/agents-md.sh check`. Every session also lists them at start, and the agent cannot write a new one. |
| A cloud environment | Put step 1 of `/zstack:setup` in the environment's setup script. Cloud sessions do not load the plugins on your machine. |
