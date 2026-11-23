---
name: check-promises
description: Find where code breaks what a component promises, mark each place, and get the person's verdict on each. Use when the user asks whether a component still keeps its promises or follows its target design, asks to check code against the promises in an AGENTS.md, or schedules such a check. Adds only marker comments until the person gives a verdict.
---

# Check a component against its promises

Goal end-state: every place where code breaks one of the component's promises carries a marker on the default branch, and the person has the count per promise and one question to answer.

- A **promise** is a numbered statement, in the component's `AGENTS.md`, of what the component offers or keeps.
- A **breach** is code that makes a promise false. It sits inside the component or in code that uses it.
- A **marker** is a one-line comment at the code. It records a breach, or a case the promise does not decide.
- A **verdict** is the decision on a breach. It is the person's, given now or written earlier into the promise.

The first run finds the breaches that exist today. A later run finds what was added since.

## Find

**Judge code against the words of the promise.** A breach names the lines and the words of the promise that those lines make false. Code that looks wrong and makes no promise false is not a breach.

**Read the code that uses the component too.** A caller breaks a promise when it uses something the component does not offer.

**Search first, then read.** A search decides a promise about imports or exports. For most other promises it only lists the places to read.

**A named check covers what it checks, and reading covers the rest.** Skip a promise only when its check enforces all of it.

**When the words of a promise do not decide a case, mark the case as unclear.** `unclear` is the run's doubt. The person then decides how the promise should read.

**A marked place is known.** Report no marked place again. Remove a marker when the code changed so that the case is gone.

**Say whether an unmarked breach is new.** Two runs of a judgment do not find the same places. The last run is the last markers pull request that merged. Lines older than that merge were missed before, and newer lines were added since.

## Record

```
// BREAKS <component>#<promise number> (<state>): <one sentence on what breaks>
```

**The component is the one that made the promise**, also when the code sits in another component. Use its folder name, or the shortest path that no other component shares.

**The state is `undecided`, `unclear`, or a verdict.**

**The sentence says which part of the promise the code makes false**, in the promising component's own words. It says nothing about what the calling code is for.

**One marker per breach, on the line above the code that makes the promise false.** That is the line that decides, the line that reads, or the code that works around something the component does not offer. A line that breaks two promises gets two markers. The marker stays on one line.

**The repo's comment rules must admit the marker.** Where those rules would have another agent delete it, ask the person to change them, and add no marker until they do.

**The markers go in a pull request that changes nothing else.** It needs no review from the person, so turn on auto-merge where the repo allows it. Its description says what the run read and what it did not read. Every run uses the same branch name, so that a run updates an open pull request and never opens a second one.

## Ask

**Open with one line: the markers per promise, the number of questions, and what the run did not read.** Give the places only when the person asks. A scheduled run that finds nothing new sends nothing.

**One question covers every marker that one decision settles.** Group by the decision, not by the file.

**Ask one question at a time.** Ask about unclear promises first, because the answers change the count. Then ask the question that settles the most markers.

**A question has four parts, in about 100 words.**

1. What the code does today and what the thing is, in words a person who has not read the code can follow. Leave out function and file names.
2. Who depends on it and why.
3. The verdict you propose, and the words of the promise it follows from.
4. What the most likely other verdict would cost.

**The person answers with one of four verdicts, or with an answer you did not offer.**

- **keep**: the promise stays as written, and the code changes to keep it.
- **grow**: the promise changes to allow what the code does.
- **move out**: the thing does not belong in this component and moves to another place.
- **not a breach**: the promise was unclear, and its words change to say so.

**Ask nothing the person already decided.** When the promise itself names the remedy for this kind of case, mark the place with that verdict and tell the person in one line. A promise that only forbids what the code does has not decided.

## Fix

**A verdict starts its fix at once**, in its own pull request, which removes the markers of that group and follows the repo's rules for merging.

**A verdict that would settle a later case goes into the words of the promise.** The next run reads the promise and knows nothing of this conversation. **grow** and **not a breach** always change those words.

**When a fix cannot finish now, the marker keeps the verdict and what the fix waits for.**

> Prefer: `(keep, waits for the billing service to report the plan tier)`
> Over: leaving `(undecided)` on a breach the person already decided.
