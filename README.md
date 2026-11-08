# zstack

A personal development flow for working with coding agents: the rules and skills that hold in any repo. Project-specific rules stay in each project's own `CLAUDE.md` and `docs/`.

## Install

In Claude Code:

```
/plugin marketplace add zhangfand/zstack
/plugin install zstack@zstack
```

## Layout

- [`rules/`](rules/README.md): rulebooks, one per kind of content. The `rules` skill points the agent at the right one.
  - [`writing.md`](rules/writing.md): prose rules for docs, PR text, issues, and comments.
  - [`prs.md`](rules/prs.md): PR title and a short PR body.
  - [`comments.md`](rules/comments.md): when a code comment exists and what it says.
  - [`engineering.md`](rules/engineering.md): traps that pass every gate.
  - [`claude-md.md`](rules/claude-md.md): the format and admission bar for `CLAUDE.md` files.
  - [`issues/`](rules/issues/README.md): bug reports, feature requests, task specs.
  - [`docs/`](rules/docs/README.md): concepts, principles, architecture docs, ADRs.
  - [`rulebooks.md`](rules/rulebooks.md): how to write a new rulebook.
- [`skills/`](skills/): procedures the agent runs on some tasks.
  - `rules`: load the matching rulebook before writing.
  - `respond-to-review`, `babysit-pr`: drive a PR through review and CI.
  - `file-issue`, `todos-to-github-project`: turn a description or a todo list into issues.
  - `ddd`: build a shared domain language with a person as the domain expert.
  - `loop-northstar`, `loop-reconcile`: write an ideal-state doc, then file the work that closes the gap to it.

## Using it from a repo

A repo's `CLAUDE.md` keeps only what is specific to that repo, and leans on zstack for the rest. When the repo needs to tighten a rule, it states the override in its own `CLAUDE.md`, which wins.
