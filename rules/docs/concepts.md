# Concepts Entries

**Concepts** — a unified set of terms with their contracts — live in the repo's `docs/concepts/`. The family is load-bearing for agentic development. This doc defines the entry format, the bar for entry, and when an entry leaves. The sibling family, principles, has its own rulebook in [principles.md](principles.md).

## Format

**One entry per term, in a fixed shape.** Each entry is a section in the relevant `concepts/` file. Harvesting fills this shape, and no entry invents its own:

- **Term** — the section heading. One concept, one name: this is the canonical name. Words other surfaces use for the same concept are listed here as deprecated aliases, and new code and docs use the canonical name. Other docs link here instead of re-defining ([Linking](../writing.md#linking)).
- **Definition** — one or two sentences, statable without reference to any file, type, or function.
- **Contracts** — the invariants the concept carries: what a contributor can rely on, and what a diff must not break. Entries are deliberately concepts *plus their contracts*, not a pure glossary.
- **Not to be confused with** — near-miss terms, each with the one line that separates them.

## Admission

**A term earns an entry when it is shared, load-bearing, and distinct.** All three hold:

1. It is used on more than one surface (code, docs, UI copy, agent prompts, conversation).
2. It carries a contract a diff could silently violate, **or** two people/agents have plausibly meant different things by it.
3. It is separable from every existing entry in one line — the near-miss line is the test. If that line cannot be written, it is the same concept: merge into the existing entry and record the loser as an alias, not an entry.

## Exclusions

**An entry carries no implementation, cache, history, or steps.** This content is banned regardless of the bar ([principles entries](principles.md#exclusions) ban the same list):

- **Implementation pointers** — file paths, function/type names, code mechanisms. Contracts name behavior. The mechanism enforcing it [belongs in code review](README.md#traps), not here.
- **Environment caches** — restatements of what a lookup already answers: `package.json` scripts, config files, `--help` output, directory layout. The lookup cannot go stale. The restatement can. Link or omit.
- **History** — prior states and change narration ("previously", "no longer", "renamed from"). Entries state what is true now. Git history owns the past.
- **Process steps** — how-to sequences and runbooks. Those are skills, loaded when they fire. These docs carry only what must hold on every diff.

## Eviction

**An entry that stops clearing the bar leaves.** Nothing stays for safety. An entry dies when no surface still uses the term, or when nothing enforces its contract and its ambiguity is gone. A concept that stops being separable from a neighbor merges into it and survives only as an alias line.

**Every pass checks for removal.** any change that adds or edits entries also states what it checked for removal. "Nothing qualifies" is a valid finding. Not checking is not.

## Intake

**A recurring correction gets an answer.** It exits through one of two doors: it becomes an entry (here if the miss was about what a term means, in [principles](principles.md) if it was about judgment), or it is consciously rejected with a stated reason — it fails an admission bar, or it is implementation detail that belongs in code review. Silent recurrence is the failure mode this rule prevents. A correction made three times with no entry and no rejection means these docs are dead.
