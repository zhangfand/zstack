# Authoring Guidelines

An **authoring guideline** is the rulebook for one content type — a doc family, PR descriptions, GitHub issues. It fixes three things: the format of an entry, the bar content must clear to get in, and the conditions under which content leaves. Unlike [writing.md](writing.md), which shapes how prose reads, an authoring guideline governs what content may exist in the family at all. [docs/adrs.md](docs/adrs.md) is a worked example — the rulebook for architecture decision records.

This file is the rulebook for authoring guidelines themselves. Every rule here applies to this file too. The prose in an authoring guideline follows [writing.md](writing.md), like every other doc.

## Naming

Every authoring guideline is a kebab-case file named for the content type it governs (`prs.md`, `issues/task-spec.md`, `docs/adrs.md`). [writing.md](writing.md) is the cross-cutting prose rulebook, not a per-type guideline. `[mech]`

A **family umbrella** is the third kind: one rulebook holding what several per-type guidelines in one family share, named for the family rather than a content type ([issues/README.md](issues/README.md), shared by the three issue-type guidelines). An umbrella enters only when three or more per-type guidelines already defer to it, and each of them names it as winning where a rule conflicts. `[human]`

## When a content type earns an authoring guideline

Write an authoring guideline for a family only when both hold: `[human]`

1. The family has three or more files, or a concrete plan to reach that.
2. Inconsistency across the family has caused at least one real miss — a wrong edit, a failed lookup, a rule applied in one file but not another. The authoring guideline names that miss.

Until then, the family's rules stay as a section in the repo's `CLAUDE.md`. An authoring guideline written before the family needs one is speculation. Reject it.

## Required sections

Every per-type authoring guideline contains these four sections. It may add sections. It may not omit any of the four. A family umbrella carries **Intake** plus the sections its family shares, because the per-type guidelines below it hold the format, admission, and eviction for their own content. `[mech]`

- **Format** — the structure of one entry or file: required parts, naming, ordering.
- **Admission** — the bar content must clear to enter the family.
- **Eviction** — the condition under which existing content leaves. Default: content that stops clearing the admission bar leaves. Nothing stays for safety.
- **Intake** — the routing rule for recurring feedback: a correction that recurs either becomes an entry, or the maintainer rejects it in writing and states the reason. Silent recurrence means the doc is dead.

## Every rule is checkable

Each rule in an authoring guideline carries one of three tier tags. The tags are the contract with tooling: `[mech]` rules get lint scripts, `[llm]` rules get an automated audit pass, and both skip `[human]` rules. `[mech]`

- `[mech]` — a script can decide pass/fail. Examples: the file contains every required section, file names match a pattern, internal links resolve, the file uses no listed word.
- `[llm]` — deciding takes judgment, but the rule states a decision procedure and includes one passing and one failing example. The example pair is the auditor's test fixture. A judgment rule without the pair fails admission. The "Prefer / Over" blocks throughout these rules are the house format.
- `[human]` — only a person can decide (e.g. "this changed a real decision"). Auditors skip these. They never guess.

A rule that fits no tier is an opinion, not a rule. Reject it.

## Evolution

This doc and every authoring guideline evolve by their own intake rule. A recurring authoring mistake either becomes a rule with a tier tag, or the maintainer rejects it in writing. A rule leaves when the mistake it guards against stops happening — a rule everyone already follows pays audit cost for nothing. `[human]`
