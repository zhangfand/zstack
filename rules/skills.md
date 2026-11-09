# Skills

A **skill** is a runbook an agent loads on demand and executes itself. Unlike a CLAUDE.md, which loads on every turn, a skill loads only when its description matches the task or a person types its name. This file defines the format of a skill and the bar its prose clears to enter. Prose rules come from [writing.md](writing.md), and CLAUDE.md files follow [claude-md.md](claude-md.md).

The miss this family guards against is over-prescription. A skill that scripts every command and every question spends context on steps the agent takes anyway. A fixed step order also drops or reorders steps that the agent would otherwise get right. The agent follows the script past the point where a better path was available.

## Format

A skill is a directory named for the skill, holding a `SKILL.md`. Its frontmatter carries `name`, equal to the directory name, and `description`.

Every link in a skill resolves, and every skill or rulebook it names exists.

A skill that only a person starts sets `disable-model-invocation: true`. Its description is a one-line summary for the person. A skill the agent starts on its own states its triggers in the description.

> Prefer: on a skill the agent starts on its own, "Load before writing a PR description, a code comment, or a GitHub issue."
> Over: "Rulebooks for content types."

The body opens with the goal end-state: what exists, or is true, when the skill is done.

> Prefer: "Goal end-state: one issue on the tracker whose sections follow the issue rulebook."
> Over: opening with "1. Run `gh repo view`."

Reference that only some runs need sits in a sibling file the skill links, not in `SKILL.md`.

> Prefer: the bug-report questions in `references/bug-questions.md`, linked from the step that classifies the issue.
> Over: the questions for every issue type written out in `SKILL.md`.

## Admission

A line enters a skill only when an agent does something different because of it. When in doubt, delete it.

A line fails on **default** when the agent already does it without being told.

> Prefer: "Pass the issue body through a file, so that backticks survive the shell."
> Over: "Read the issue back after you create it."

A line fails on **how** when it fixes a method where only the outcome matters. State the outcome and the check for done, and leave the method to the agent. A step earns a fixed order or an exact command only when a wrong path is costly or the right path is not obvious.

> Prefer: "Each deciding fact is settled by a run against the real tool, with a control run beside it."
> Over: "Plant a canary word in each input, and do at least three runs per arm."

A line fails on **lookup** when a type, a config file, `--help`, or another source the agent reads on its own already holds the answer. Point at that source instead of copying it.

> Prefer: "The blocked-by API takes the blocking issue's REST id, not its number."
> Over: the `gh project create`, `link`, and `item-add` commands written out in full.

A line fails on **restatement** when another skill or rulebook owns the rule. Name that skill or rulebook by path, and do not repeat its content.

> Prefer: "The title and body follow [issues/README.md](issues/README.md)."
> Over: the issue title shape copied into the skill.

A line fails on **structure** when a script, a lint, or a type could enforce it. Ship the check, and drop the prose.

> Prefer: a script that fails when a label the draft needs is missing.
> Over: "Remember to check that every label exists."

A rule states no rationale, per [writing.md](writing.md#structure). It keeps a reason only when the rule is confusing without one.

> Prefer: "Write nothing to GitHub before the person approves the draft."
> Over: the same rule with a sentence on why approval matters.

A skill names no project's paths, commands, or vocabulary. Examples use neutral names.

> Prefer: "the repo's issue rulebook."
> Over: a path or a label that only one project has.

## Eviction

A line whose named failure no longer happens leaves.

When the agent follows a skill and still takes a worse path than it takes without the skill, the skill is too prescriptive. Cut the steps that caused it.

## Intake

A correction that recurs across sessions becomes a line in the skill, or the maintainer rejects it in writing and states the reason.

A proposed edit enters only when it changes what a future agent does. An edit that adds text the agent reads and then ignores is rejected. A single bad session is not a reason for a new rule.

A workflow that recurs across sessions with no skill for it becomes a proposed skill.
