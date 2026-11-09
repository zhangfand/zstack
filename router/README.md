# Router

The router decides what an agent loads for the task in front of it. It holds no rules and no steps of its own: it points at a [principle](../principles/README.md) or a [skill](../skills/), and that file does the work.

Three pieces route:

- This table. [bootstrap.sh](bootstrap.sh) prints it into every session, so the agent reads the matching principle even for content written in the middle of another task, such as a code comment inside a code change.
- The `principles` skill, which carries the same pointer for a session that missed the bootstrap text.
- Each skill's own `description`, which the agent matches against the task. Skills need no row here.

| When | Read |
|---|---|
| Writing any prose: docs, PR text, issues | [writing.md](../principles/writing.md) |
| Opening or editing a PR | [prs.md](../principles/prs.md) |
| Writing or editing a code comment | [comments.md](../principles/comments.md) |
| Changing code in a way a later consumer depends on | [engineering.md](../principles/engineering.md) |
| Writing a `CLAUDE.md` or `AGENTS.md` | [claude-md.md](../principles/claude-md.md) |
| Filing a GitHub issue | [issues/README.md](../principles/issues/README.md), then the type's rulebook |
| Writing a concept, principle, architecture doc, or ADR | [docs/README.md](../principles/docs/README.md), then the family's rulebook |
| Writing a new rulebook | [rulebooks.md](../principles/rulebooks.md) |

The repo's own `CLAUDE.md`, `AGENTS.md` and docs take precedence over zstack where they disagree. When the repo has its own rulebook for the same kind of content, read that one first, and use zstack only for what it leaves open.
