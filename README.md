# zstack

A personal development flow for working with coding agents: the rules and skills that hold in any repo. Project-specific rules stay in each project's own `CLAUDE.md` and `docs/`.

## Install

In Claude Code:

```
/plugin marketplace add zhangfand/zstack
/plugin install zstack@zstack
```

Then run `/zstack:setup`. It turns on the Codex side and lists the one step you take by hand: enabling auto-update for the marketplace.

## Layout

- [`rules/`](rules/README.md): rulebooks, one per kind of content. The `rules` skill points the agent at the right one.
  - [`writing.md`](rules/writing.md): prose rules for docs, PR text, issues, and comments.
  - [`prs.md`](rules/prs.md): PR title and a short PR body.
  - [`comments.md`](rules/comments.md): when a code comment exists and what it says.
  - [`engineering.md`](rules/engineering.md): traps that pass every gate.
  - [`claude-md.md`](rules/claude-md.md): the format and admission bar for `CLAUDE.md` files.
  - [`skills.md`](rules/skills.md): the format and admission bar for skills.
  - [`issues/`](rules/issues/README.md): bug reports, feature requests, task specs.
  - [`docs/`](rules/docs/README.md): concepts, principles, architecture docs, ADRs.
  - [`rulebooks.md`](rules/rulebooks.md): how to write a new rulebook.
- [`skills/`](skills/): procedures the agent runs on some tasks.
  - `rules`: load the matching rulebook before writing.
  - `respond-to-review`, `babysit-pr`: drive a PR through review and CI.
  - `file-issue`, `todos-to-github-project`: turn a description or a todo list into issues.
  - `ddd`: build a shared domain language with a person as the domain expert.
  - `loop-northstar`, `loop-reconcile`: write an ideal-state doc, then file the work that closes the gap to it.
  - `research-first`: survey and test prior art before building a new workflow, then write it as a skill.
  - `setup`: install or repair zstack for Claude Code and Codex on this machine.
- [`hooks/`](hooks/): the SessionStart hook that puts the rulebook index and the precedence rule into every Claude Code session.
- [`scripts/setup-codex.sh`](scripts/setup-codex.sh): writes the same text into the Codex `AGENTS.md` and links the skills.

## Using it from a repo

zstack is installed per machine, never per repo, so it works in repos you do not own and nothing gets committed.

| Situation | Do this |
|---|---|
| Any repo | Nothing. zstack applies. |
| The repo has its own `CLAUDE.md`, `AGENTS.md`, or rulebooks | Nothing. The repo wins where the two disagree, and its rulebook is read first. |
| zstack clashes with a repo | Set `"enabledPlugins": {"zstack@zstack": false}` in that repo's `.claude/settings.local.json`. |
| You want a personal note for one repo | Leave it to the agent's memory. If it has to be an instruction, use `CLAUDE.local.md` hidden through `.git/info/exclude`, and only where the repo has a `CLAUDE.md`, because a `CLAUDE.local.md` stops Claude Code from reading `AGENTS.md`. |
| A cloud environment | Put step 1 of `/zstack:setup` in the environment's setup script. Cloud sessions do not load the plugins on your machine. |
