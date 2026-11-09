# Rulebooks

A **rulebook** says what good output looks like for one kind of content: a PR, a code comment, an issue, a doc. It holds judgments, not steps. The steps for a task belong in a [skill](../skills/). Prose in a rulebook follows [writing.md](writing.md), and this file follows its own rules.

## When to write one

Write a rulebook when agents keep getting one kind of content wrong in the same way, and one line in a `CLAUDE.md` does not fix it. The rulebook names that miss in its opening paragraph.

## What goes in

- Open with what the content is for and the miss the rulebook prevents.
- A rule stays only when it changes what an agent writes. Leave out what the agent does by default, what a source the agent already reads states, and an aspiration with no failure behind it.
- When a rule takes judgment and the line between pass and fail is not obvious, show one Prefer/Over pair. A plain rule needs no example.
- Choose headings that fit the content. A rulebook often covers the shape of one entry, what earns a place, and when content is removed, but it uses only the parts that apply.
- When a script can check a rule, put the rule in the script and link the script.

## Keeping it alive

A correction that recurs becomes a rule, or the maintainer rejects it and states the reason. A rule leaves when the mistake it guards against stops happening. When agents ignore a rule, the rulebook is too long. Cut other rules before adding emphasis.
