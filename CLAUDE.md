# zstack

A Claude Code plugin in three layers. Everything here must hold in any repo.

- `router/` dispatches: it says what to load for a task, and holds no rules or steps of its own.
- `skills/` documents workflows: the steps for a task, linking principles for what good output is.
- `principles/` holds judgments: one rulebook per kind of content, with no steps.

## Playbook

- Before adding or changing a rulebook, read [`principles/rulebooks.md`](principles/rulebooks.md).
- Before writing prose here, read [`principles/writing.md`](principles/writing.md).
- When adding a rulebook, add its row to the table in [`router/README.md`](router/README.md), and its kind of content to the description of [`skills/principles/SKILL.md`](skills/principles/SKILL.md).
- When a skill states a judgment that holds outside that skill, move it to a rulebook and link it.

## Traps

**A rule that names one project's paths, commands, or vocabulary breaks in every other repo.** Examples use neutral names. A rule that only one project needs stays in that project.
