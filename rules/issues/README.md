# GitHub Issues

A **GitHub issue** is one tracked unit of work on the repo's issue tracker. This file holds the rules every issue shares. Each issue type has its own rulebook, and this file wins where a rule there conflicts with it. Prose rules come from [writing.md](../writing.md).

A report an automation files on the tracker, such as a reconciliation loop report, is not a unit of work. It follows its skill's rules and carries its skill's labels, and no rule below applies to it.

## Issue types

**The type names the next action, not the kind of change.** Every issue is one of three types. The type names the next action the issue asks for.

- **[bug report](bug-report.md)** — a defect in behavior the system already ships. The next action is an investigation. An incident write-up files as a bug report.
- **[feature request](feature-request.md)** — a pain, gap, or missing capability where the change is undecided. The next action is a design conversation.
- **[task spec](task-spec.md)** — a scoped change for a person or agent to implement. The next action is implementation.

**Two questions decide the type.** Does the system break its own intended behavior? File a bug report. Is the change already decided and scoped? File a task spec. Otherwise file a feature request — a feature idea and a pain point file the same way.

## Title

**A title reads `<area>: <statement>`.** The area is a lower-case component or surface name, such as `relay`, `connector`, `docs`, `web`. An issue in a planned set reads the same way — a step code such as `[D1]` never leads a title, because the ordering lives in the blocked-by edges.

Each type's rulebook fixes the mood of the statement.

## Situation

**Every body opens with a Situation in plain words.** The **Situation** section says what is going on, in plain words, before any section that names code.

**Situation uses the project's agreed words.** It uses the nouns and verbs the project already agreed on. When the repo has concepts docs, a term links to its entry on first use.

> Prefer: "The app answers one question in two places: which addresses belong to the same person?"
> Over: "The people directory and the timeline each run their own account fold."

**A new term gets one line in a Terminology section.** When the situation needs a term concepts does not carry, pick one and define it in a **Terminology** section directly after Situation. One line per term, and that term everywhere below. A term used on more than one surface and carrying a contract belongs in the repo's concepts docs instead, when it has them.

**Situation names no file, symbol, or line number.**

> Prefer: "the message history page gathers a person's addresses on its own, and gathers them less thoroughly than the contacts list does."
> Over: "`timeline-sources.ts:88-140` duplicates `foldAccounts` and drops the `book.resolve` branch."

## Labels

**Every issue carries its type's label:** `bug`, `feature-request`, or `task`. The other labels an issue carries are fixed by its type's rulebook.
