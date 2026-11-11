# Skills

A **skill** is a runbook an agent loads on demand and executes itself. Unlike a CLAUDE.md, which loads on every turn, a skill loads only when its description matches the task or a person types its name. This file defines the format of a skill and the bar its prose clears to enter. Prose rules come from [writing.md](writing.md), and CLAUDE.md files follow [claude-md.md](claude-md.md).

The miss this family guards against is over-prescription. A skill that scripts every command and every question spends context on steps the agent takes anyway. A fixed step order also drops or reorders steps that the agent would otherwise get right. The agent follows the script past the point where a better path was available.

## Format

**A skill is a directory with a `SKILL.md`.** Its frontmatter carries `name`, equal to the directory name, and `description`.

**Every link resolves.** Every skill or rulebook a skill names exists.

**Open with the goal end-state.** The first line says what exists, or is true, when the skill is done.

> Prefer: "Goal end-state: one issue on the tracker whose sections follow the issue rulebook."
> Over: opening with "1. Run `gh repo view`."

**Move what only some runs need into a linked file.** `SKILL.md` keeps what every run needs.

> Prefer: the bug-report questions in `references/bug-questions.md`, linked from the step that classifies the issue.
> Over: the questions for every issue type written out in `SKILL.md`.

## Description

The description is the only part of a skill the agent reads before it decides to load the skill. It sits in context on every turn, next to every other skill's description. It says two things: when to use the skill, and what the skill does. The usual miss is a description that summarizes the skill and never says when to start it, so the skill does not fire.

**Write for whoever starts the skill.** A skill the agent starts on its own states the situations that start it. A skill that only a person starts sets `disable-model-invocation: true`, and its description is a one-line summary for the person.

> Prefer: on a skill the agent starts on its own, "Load before writing a PR description, a code comment, or a GitHub issue."
> Over: "Rulebooks for content types."

### When to use it

**Spend most of the words on when.** The agent picks a skill by its triggers, and the body is not read until the skill loads.

**Name the situation in the words a task arrives in.** A trigger is a phrase the user says, an artifact the agent is about to touch, or a moment in a task. Include the case where the user never names the skill's topic. A term that only the skill's body defines triggers nothing.

> Prefer: "Use when the user says debug this, or reports something broken, throwing, failing, or slow."
> Over: "Use when running the hypothesis-elimination loop."

**Trigger on what only this skill handles.** A generic trigger such as "writing code" or "reviewing a PR" fires on every task and crowds out the skills that own those tasks.

**One trigger per case.** Synonyms that rename one case count as one trigger. Every word costs context on every turn.

### What it does

**Name the outcome, not the steps.** Say what exists or is true when the skill is done. The body owns the steps.

> Prefer: "Turn a recurring task into a skill that fits the user, built on how others already solve it."
> Over: "Survey how others solved it, test the candidates, synthesize one, get sign-off, then write it as a skill."

**State a limit the agent would not assume.** A skill that reports and changes nothing, or that writes to a shared place, says so.

> Prefer: "Quality audit of the whole repo. One-shot report, changes nothing."
> Over: "Quality audit of the whole repo."

### Keeping it right

**Edit a description after a misfire.** A skill that stayed quiet when it would have helped, or fired on a neighbor's task, gets a sharper trigger. A description that fires correctly stays as it is.

## Admission

**A line stays only when it changes what the agent does.** When in doubt, delete it. The five tests below name the usual ways a line fails.

**Default: the agent does it anyway.** Delete a line the agent follows without being told.

> Prefer: "Pass the issue body through a file, so that backticks survive the shell."
> Over: "Read the issue back after you create it."

**How: state the outcome, not the method.** State the outcome and the check for done, and leave the method to the agent. A step earns a fixed order or an exact command only when a wrong path is costly or the right path is not obvious.

> Prefer: "Each deciding fact is settled by a run against the real tool, with a control run beside it."
> Over: "Plant a canary word in each input, and do at least three runs per arm."

**Lookup: point at the source, do not copy it.** A type, a config file, `--help`, or another source the agent reads on its own already holds the answer.

> Prefer: "The blocked-by API takes the blocking issue's REST id, not its number."
> Over: the `gh project create`, `link`, and `item-add` commands written out in full.

**Restatement: link the owner.** When another skill or rulebook owns the rule, name it by path, and do not repeat its content.

> Prefer: "The title and body follow [prs.md](prs.md)."
> Over: the PR title shape copied into the skill.

**Structure: ship the check, drop the prose.** A rule that a script, a lint, or a type could enforce belongs in that check.

> Prefer: a script that fails when a label the draft needs is missing.
> Over: "Remember to check that every label exists."

**Skip the reason.** A rule states no rationale, per [writing.md](writing.md#structure), unless the rule is confusing without one.

> Prefer: "Write nothing to GitHub before the person approves the draft."
> Over: the same rule with a sentence on why approval matters.

**Name no project.** A skill uses no project's paths, commands, or vocabulary. Examples use neutral names.

> Prefer: "the repo's issue rulebook."
> Over: a path or a label that only one project has.

## Eviction

**A line leaves when its failure stops happening.**

**A skill that makes the agent worse is too prescriptive.** When the agent follows a skill and takes a worse path than it takes without it, cut the steps that caused it.

## Intake

**A recurring correction gets an answer.** It becomes a line in the skill, or the maintainer rejects it in writing and states the reason.

**An edit must change what a future agent does.** An edit that adds text the agent reads and then ignores is rejected. A single bad session is not a reason for a new rule.

**A recurring workflow with no skill becomes a proposed skill.**
