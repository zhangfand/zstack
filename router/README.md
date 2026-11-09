# Router

The router decides what an agent loads for the task in front of it. It holds no rules and no steps of its own: it points at a [rulebook](../rules/README.md) or a [skill](../skills/), and that file does the work.

Three pieces route:

- This table. [bootstrap.sh](bootstrap.sh) prints it into every session, so the agent reads the matching rulebook even for content written in the middle of another task, such as a code comment inside a code change.
- The `rules` skill, which carries the same pointer for a session that missed the bootstrap text.
- Each skill's own `description`, which the agent matches against the task. Skills need no row here.

| When | Read |
|---|---|
| Writing any prose: docs, PR text, issues | [writing.md](../rules/writing.md) |
| Opening or editing a PR | [prs.md](../rules/prs.md) |
| Writing or editing a code comment | [comments.md](../rules/comments.md) |
| Changing code in a way a later consumer depends on | [engineering.md](../rules/engineering.md) |
| Writing a `CLAUDE.md` or `AGENTS.md` | [claude-md.md](../rules/claude-md.md) |
| Writing or editing a skill | [skills.md](../rules/skills.md) |
| Filing a GitHub issue | [issues/README.md](../rules/issues/README.md), then the type's rulebook |
| Writing a new rulebook | [rulebooks.md](../rules/rulebooks.md) |

The repo's own `CLAUDE.md`, `AGENTS.md` and docs take precedence over zstack where they disagree. When the repo has its own rulebook for the same kind of content, read that one first, and use zstack only for what it leaves open.
