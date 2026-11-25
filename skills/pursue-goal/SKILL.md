---
name: pursue-goal
description: Use when the user gives a goal that does not translate into a specific task, where what counts as reached is a judgment to agree on with them. Agrees on pass or fail rules with the user, then builds and evaluates until every rule passes, with a record of each evaluation. Long-running. It runs builders as subagents and writes to the user's tracker.
---

# Pursue a goal until its rules pass

Goal end-state: every rule in the rule set the person approved passes on a committed version of the product, and the trajectory shows each evaluation that led there.

- The **product** is what the goal asks for.
- The **verifier** is a program that scores the product pass or fail on every rule a program can decide.
- The **environment** is everything the product and the verifier need to run without the person.
- A **builder** is a subagent that builds one of those three.
- The **design** is what the person decided about how the product is built, such as which part owns what.
- The **trajectory** is the record of how the results change, one entry per iteration of the loop.
- The **planner** is the agent that runs this skill.

The planner owns the rules, the plan, and the trajectory, and directs the builders. The planner builds none of the three itself.

The person agrees to the rules before the phases, and to the phases before any builder starts.

**Bring the person the rules, the phases and the lines of the design, and nothing else.** Everything else the planner finds or plans goes in its notes. The one exception is the ask for what only the person can supply.

## Rules

**Each rule is pass or fail and names its check.** Where judgment would decide the result, the rule carries a number, such as "reports 8 of 10 seeded issues within 24 hours".

**Each rule names who scores it: the verifier, an agent, or the person.** Prefer the verifier over an agent, and an agent over the person.

**A check finishes in minutes.** When a rule names a span of time, such as a timeout, a retry window, or an hour offline, the check advances a clock the product lets it set, per [testing.md](../../rules/testing.md), instead of waiting the span out. A part that only real time can prove becomes a scheduled check, and the rule names that part.

> Prefer: "Messages sent while the service is down for an hour are each answered once after restart. Check: stop it for a minute and advance the queue's clock by an hour. Scheduled check: once a day, a real one-hour stop."
> Over: the same rule checked by a real one-hour stop on every run.

**The rule set follows [rulebooks.md](../../rules/rulebooks.md).** Group the rules by the outcomes the goal names, and aim for about ten.

**Read what exists before writing a rule.** Note which rules cannot pass today and what is missing.

**Write a decision that belongs to the person into the rule or the phase it changes, as the recommended choice.**

**A rule changes only by the person's decision, and each change makes a new version of the rule set.**

## Phases

If the scope is too large to meet every rule in one pass, split the work into phases.

**A phase is named by the capability the person has once it is done.** One phase enables one capability, and the person can use that capability without the later phases.

> Prefer: "Phase 2: it answers from everything said in the chat."
> Over: "Phase 2: store every message."

**Each phase lists the rules it meets, and every rule belongs to one phase.**

## Design

**The design the person agreed to lives in one GitHub issue.** The planner writes it there before a builder starts, in three parts: Why, Design, Not in this change. The design is numbered lines, and it holds only lines the person accepted.

**A change of course goes into the issue first.** The planner shows the person the changed line, and changes the issue when they confirm.

**A line's number is never used again.** A removed line's number stays unused, and a new line takes the next one. Write the number as text, such as `D3`, because a Markdown list renumbers itself.

## Environment

**List what the planner needs to build and evaluate without the person.** For each requirement, say whether it exists, partly exists, or is missing, and who supplies it.

**Ask the person once for everything only they can supply.** Builders start before it arrives.

**Name each difference between the environment and production.**

**Name each rule the environment cannot check, and say how it is checked instead.**

## Builders

**The goal runs in one session, the planner's.** Builders, research, verifier runs, and replays run as subagents that return a summary to the planner. A part gets its own session only when it opens its own pull request or needs a decision from the person apart from the goal's.

**The environment, the verifier, and the product each get their own builder.** Each builder owns one folder and changes nothing outside it.

**The product's builder never reads the verifier's scenarios or expected answers.**

**The verifier proves itself against a stand-in product.** It does not wait for the product or the environment.

**A brief is one file a builder can act on with nothing else open but the design's issue.** It holds the goal, the owned folder, what the builder must not touch, and each rule it serves with the exact pass bar and check as plain text.

**A builder takes the design only from the issue.** The brief links the issue and does not retell the design.

**Each pull request names the lines it delivers.** It says "Part of #123, D1 and D2", and the last one says "Closes #123".

**No builder merges without the person.**

If the person has not said which model the builders run on, ask.

## State

Keep the plan, the phases, the decisions made, the planner's notes, and what waits on the person outside the conversation, in the tracker the person uses or in files.

**The rule set has one home, and it stays the only source of the rules.** When the person's instructions say where they keep their goals and in what form, the rule set is written there in that form. Otherwise it is a file.

**A result goes in the trajectory, never into the rule set.**

## Loop

1. A builder commits a version.
2. The verifier scores it in the environment, and an agent scores each rule that names one.
3. The planner adds the entry to the trajectory and tags each failure with where the fault lies: the product, the verifier, the environment, or the rule.
4. The planner sends each fix to the builder that owns the fault. A fault in a rule goes to the person.

**A scheduled check runs on its own timer, never in the loop.** It scores the newest committed version, and the trajectory carries its latest result and the commit it ran on.

**When every rule that the verifier or an agent scores has passed, the planner tells the person once what is left for them to score.**

A phase is done when all of its rules pass, and each of its scheduled checks has passed on that commit or a later one. Every later run still checks the rules of the finished phases.

## Trajectory

**The trajectory opens with a table, one row per iteration, newest first.** A row gives the product's commit, the rule set version, the rules passed per phase, the rules that failed, and what changed since the previous iteration.

**Each iteration has an entry that lets a reader repeat the run.** The entry gives:

- the commits of the product, the verifier, and the environment
- the model the run used
- the rule set version
- the result for each rule: pass, fail, or not checked with the reason
- the fault tag for each failure
- the feedback from the person and the builders
- what changes next

**The verifier writes the commits into its own report, and refuses to run on uncommitted code.** The environment reports its own commit and model. The planner copies these into the entry.
