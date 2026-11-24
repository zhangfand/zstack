---
name: write-promises
description: Agree with the person on what one component promises, and write the list into the component's AGENTS.md. Use when the user wants to write down what a component promises or is responsible for, wants agents to stop guessing what belongs in a component, or asks to check a component that has no promises yet. Changes no code, and writes nothing before the person agrees to the list.
---

# Write what a component promises

Goal end-state: the component's `AGENTS.md` holds a short numbered list of promises that the person agreed to. Each promise says how far it can be trusted. Below the list, one block tells an agent what to do when a change needs something no promise names.

A promise means what [check-promises](../check-promises/SKILL.md) says it means. That skill reads the code against the list this skill writes.

## Learn the component

**First ask the person what the component is for, in one sentence.** That sentence decides most of the later cases.

> Prefer: "It carries messages between the platform and the product, and holds no product logic."
> Over: starting from a list of what the code exports today.

**Collect what code outside the component uses of it today**, grouped by the thing used. A caller is evidence for a promise. It is never part of one.

**Today's code is not the target**, per [engineering.md](../../rules/engineering.md). A lint list of allowed imports records what exists. It does not say what should exist.

## Agree

**Propose one promise at a time**, with the uses that led to it. The person decides each one.

**A group of uses that fits no promise is a question for the person.** The answer is one of three: a promise grows to cover it, the use is removed, or the thing moves out of the component. The question has the four parts that [check-promises](../check-promises/SKILL.md#ask) gives.

**What the person has not decided stays in the file, named as undecided.**

> Prefer: "Undecided: the dependency on the scheduler. It stays as it is today."
> Over: a promise the agent chose because the list looked incomplete.

## A promise

**It says what the component offers or keeps, in the component's own words.** It names no caller, and nothing that a caller does with it.

> Prefer: "A delivery may repeat, and each repeat carries the same id."
> Over: "The inbox drops repeated deliveries."

**It covers only what a caller uses now, at the weakest strength that serves that caller.**

**It may name what the component itself depends on.**

> Prefer: "To offer tools, it implements the contract the scheduler publishes, and uses nothing else of the scheduler."

**Its words decide real cases.** Before the list is final, hold each promise against a few places in the code where the right answer is not obvious. Where the words do not decide, ask the person, and put the answer into the words.

> Prefer: "It reports every message the platform delivered and leaves none out."
> Over: "It reports messages faithfully."

**It describes the target.** A promise that today's code breaks stays in the list, marked as not yet true.

**The list fits on one screen.**

**A number is never reused.** Markers at the code refer to a promise by its number.

## Write

**The list goes in `AGENTS.md` in the component's own folder**, per [agents-md.md](../../rules/agents-md.md). The component's entry file gets one line that points to it.

**Each promise says how far it can be trusted:** the check that enforces it, "no check yet", or "not yet true". The file claims no more than was verified.

**Each promise without a check names the strongest check it allows:** an import rule, a type, a test at the entry, or a reading by [check-promises](../check-promises/SKILL.md). Building that check is separate work.

**Below the list, tell an agent what to do when the promises do not cover its change.** State the reasoning, so that it also holds for a case that arrives by another route.

```
When a change needs something from <component> that these promises do not name, stop before writing it and ask the person. The answer is one of three: the promise grows, the use is removed, or the thing moves out of <component>.

When existing code breaks a promise, leave it and do not copy it.
```

> Over: "Ask before adding an export to the entry file."

**The pull request holds the `AGENTS.md` and the pointer line, and nothing else.**

## After

**The first run of [check-promises](../check-promises/SKILL.md) lists what breaks the new promises today.**

**To learn whether the promises change what agents do, give one real task to two fresh agents, one with the file and one without it, and compare what each does.**
