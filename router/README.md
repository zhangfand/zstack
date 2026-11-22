# Router

The router decides what an agent loads for the task in front of it. It holds no rules and no steps of its own: it points at a [rulebook](../rules/README.md) or a [skill](../skills/), and that file does the work.

Three pieces route:

- This table. [bootstrap.sh](bootstrap.sh) prints it into every session, after [working-with-me.md](../working-with-me.md), so the agent reads the matching rulebook even for content written in the middle of another task, such as a code comment inside a code change.
- The `rules` skill, which carries the same pointer for a session that missed the bootstrap text.
- Each skill's own `description`, which the agent matches against the task. Skills need no row here.

| When | Read |
|---|---|
| Writing any prose: docs, reports and replies to the user, PR text, issues | [writing.md](../rules/writing.md) |
| Writing text a user reads in an app's UI: labels, buttons, descriptions, empty states, errors | [ui-copy.md](../rules/ui-copy.md) |
| Opening or editing a PR | [prs.md](../rules/prs.md) |
| Writing or editing a code comment | [comments.md](../rules/comments.md) |
| Designing an interface: a function, class, module, or service API | [abstraction.md](../rules/abstraction.md) |
| Drawing a component boundary, or choosing how components depend on and talk to each other | [architecture.md](../rules/architecture.md) |
| Changing code in a way a later consumer depends on, or reading data another process wrote | [engineering.md](../rules/engineering.md) |
| Writing or changing a test | [testing.md](../rules/testing.md) |
| Designing how software we ship gets a credential or secret | [security.md](../rules/security.md) |
| Writing a `CLAUDE.md` or `AGENTS.md` | [claude-md.md](../rules/claude-md.md) |
| Writing or editing a skill | [skills.md](../rules/skills.md) |
| Writing a new rulebook | [rulebooks.md](../rules/rulebooks.md) |

The repo's own `CLAUDE.md`, `AGENTS.md` and docs take precedence over zstack where they disagree. When the repo has its own rulebook for the same kind of content, read that one first, and use zstack only for what it leaves open.
