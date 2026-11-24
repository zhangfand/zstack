# zstack

A Claude Code plugin in three layers. Everything here must hold in any repo.

- `router/` dispatches: it says what to load for a task, and holds no rules or steps of its own.
- `skills/` documents workflows: the steps for a task, linking rules for what good output is.
- `rules/` holds judgments: one rulebook per kind of content, with no steps.

`working-with-me.md` is the person's own account of how they work. The session-start hook prints it in full into every session, followed by the Cutting section of [`rules/prs.md`](rules/prs.md) and the router's table.

## Playbook

- Before adding or changing a rulebook, read [`rules/rulebooks.md`](rules/rulebooks.md).
- Before writing prose here, read [`rules/writing.md`](rules/writing.md).
- When adding a rulebook, add its row to the table in [`router/README.md`](router/README.md), and its kind of content to the description of [`skills/rules/SKILL.md`](skills/rules/SKILL.md).
- When a skill states a judgment that holds outside that skill, move it to a rulebook and link it.
- When adding a line to `working-with-me.md`, check that it holds for every task. A judgment about one kind of content goes in that content's rulebook.

## Traps

**A rule that names one project's paths, commands, or vocabulary breaks in every other repo.** Examples use neutral names. A rule that only one project needs stays in that project.

**A `version` in `plugin.json` freezes every install.** Claude Code updates a plugin only when its version changes. Without the field, the version is the commit SHA, so each push to main reaches installs. Keep it out of `plugin.json` and `marketplace.json`.
