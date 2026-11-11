# Rulebooks

A **rulebook** says what good output looks like for one kind of content: a PR, a code comment, an issue, a doc. It holds judgments, not steps. The steps for a task belong in a [skill](../skills/). Prose in a rulebook follows [writing.md](writing.md), and this file follows its own rules.

## When to write one

**Write a rulebook for a repeated miss.** Agents keep getting one kind of content wrong in the same way, and one line in a `CLAUDE.md` does not fix it. The opening paragraph names that miss.

## Writing a rule

- **Open each rule with one short bold sentence that states it.** A reader who reads only the bold sentences gets the whole rulebook. The sentences after it add only what the lead cannot carry: a scope, a condition, an exception.
- **Distill the rule until it is simple, intuitive, and powerful.** Simple means one idea in plain words. Intuitive means a reader agrees on first read and remembers it. Powerful means it decides cases the rulebook never lists. When a rule needs a list of cases to work, look for the one idea behind them, and write that.
- **Keep a rule only when it changes what an agent writes.** Leave out what the agent does by default, what a source the agent already reads states, and an aspiration with no failure behind it.
- **Leave out what the reader already knows.** A term the agent and the reader share, such as skill, PR, or CLAUDE.md, needs no definition. Define only a term the rulebook coins or uses in its own sense.
- **Show an example only where judgment is needed.** When the line between pass and fail is not obvious, add one Prefer/Over pair. A plain rule needs no example.
- **Let a script check what a script can check.** Put the rule in the script, and link the script.
- **Choose headings that fit the content.** A rulebook often covers the shape of one entry, what earns a place, and when content is removed, but it uses only the parts that apply.

> Prefer: "**Every comment earns its place.** A comment carries only what the code cannot state."
> Over: a paragraph listing six kinds of comment to delete, with no sentence that names what they share.

## Keeping it alive

- **A recurring correction gets an answer.** It becomes a rule, or the maintainer rejects it and states the reason.
- **A rule leaves when its mistake stops happening.**
- **When agents ignore a rule, cut before you emphasize.** The rulebook is too long, so cut other rules first.
