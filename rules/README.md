# Rules

Rulebooks an agent reads before producing a kind of content. Each one fixes the format, the bar content clears to get in, and when content leaves. [rulebooks.md](rulebooks.md) is the rulebook for writing a rulebook.

| When | Read |
|---|---|
| Writing any prose: docs, PR text, issues | [writing.md](writing.md) |
| Opening or editing a PR | [prs.md](prs.md) |
| Writing or editing a code comment | [comments.md](comments.md) |
| Changing code in a way a later consumer depends on | [engineering.md](engineering.md) |
| Writing a `CLAUDE.md` or `AGENTS.md` | [claude-md.md](claude-md.md) |
| Writing or editing a skill | [skills.md](skills.md) |
| Filing a GitHub issue | [issues/README.md](issues/README.md) |
| Writing a concept, principle, architecture doc, or ADR | [docs/README.md](docs/README.md) |
| Writing a new rulebook | [rulebooks.md](rulebooks.md) |

Rules carry a tier tag: `[mech]` a script can check, `[llm]` takes judgment and ships with a Prefer/Over example pair, `[human]` only a person can decide.
