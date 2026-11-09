---
name: rules
description: Load the matching zstack rulebook before writing a PR title or description, a code comment, a CLAUDE.md, a skill, a GitHub issue, a doc (concept, principle, architecture, ADR), or any other prose, and before a change that breaks an interface other code depends on.
---

# zstack rules

Read the rulebook for the content you are about to write, then write it.

The repo's own rules win where the two disagree. When the repo has its own rulebook for the same kind of content, in its `CLAUDE.md`, `AGENTS.md` or docs, read that one first, and use the zstack rulebook only for what it leaves open.

| When | Read |
|---|---|
| Writing any prose: docs, PR text, issues | [writing.md](../../rules/writing.md) |
| Opening or editing a PR | [prs.md](../../rules/prs.md) |
| Writing or editing a code comment | [comments.md](../../rules/comments.md) |
| Changing code in a way a later consumer depends on | [engineering.md](../../rules/engineering.md) |
| Writing a `CLAUDE.md` or `AGENTS.md` | [claude-md.md](../../rules/claude-md.md) |
| Writing or editing a skill | [skills.md](../../rules/skills.md) |
| Filing a GitHub issue | [issues/README.md](../../rules/issues/README.md), then the type's rulebook |
| Writing a concept, principle, architecture doc, or ADR | [docs/README.md](../../rules/docs/README.md), then the family's rulebook |
| Writing a new rulebook | [rulebooks.md](../../rules/rulebooks.md) |
