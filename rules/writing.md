# Writing Rules

These rules apply to docs, PR and issue text, and code comments. They do not apply to strings rendered in a UI. A project's own voice guide for product copy wins wherever the two disagree.

## Terminology

**Use the industry term when one exists.** A coined name for a known thing makes the reader learn a word for nothing.

> Prefer: glossary, runbook, spec, changelog.
> Over: a coined name for the same thing.

**A project term needs one line that separates it from its nearest industry term.** If the line cannot be written, the industry term wins.

> Prefer: "A *skill* is a runbook loaded into agent context on demand. Unlike a runbook, an agent executes it, not a person."
> Over: introducing "skill" with no line separating it from "runbook".

## Word choice

**One name per thing.** Pick the canonical name and use it everywhere.

> Prefer: "the daemon" throughout the doc.
> Over: "the daemon" in one paragraph and "the host process" in the next, for the same thing.

**One meaning per word.** A word never relies on context to tell two senses apart.

> Prefer: "install" always means the daemon operation, "set up" covers the dev environment.
> Over: "install" means the daemon operation in one section and the dev-environment steps in another.

**Say what is true, not what it is like.** Where a literal phrase exists, use it instead of a picture, a metaphor, or a flourish.

> Prefer: "a parameter worth varying."
> Over: "a dial worth turning."

**Use the plain word.** *start* not *begin/commence/initiate*, *use* not *utilize/leverage*, *help* not *facilitate*, *make sure* not *ensure*, *before* not *prior to*, *get* not *obtain/acquire*, *show* not *demonstrate*, *also* not *additionally/furthermore/moreover*. Add a pair whenever a fancier word gets past review.

**Cut marketing adjectives.** *seamless*, *robust*, *powerful*, *cutting-edge*, *effortless*, *world-class*, *next-generation*, *revolutionary*.

**Write what is true now.** No history words: *previously*, *no longer*, *used to*, *renamed from*.

## Verbs

**Name who does what.** Use active voice and a real verb, not a nominalization.

> Prefer: "the parser reads the file", "analyze the log."
> Over: "the file is read by the parser", "perform an analysis of the log."

**Say it directly.** No stacked auxiliaries, no throat-clearing, and no "-ing" main verb where a simple tense works.

> Prefer: "this improves X", "the loader validates the manifest."
> Over: "it is important to note that this may help to improve X", "the loader is validating the manifest."

## Sentences

**Split a descriptive sentence over 25 words.**

**Write in full sentences.** No contractions, and keep the articles (*a*, *an*, *the*, *this*, *these*).

> Prefer: "the daemon rejects the request."
> Over: "daemon rejects request."

**No semicolons.** Split into two sentences.

## Structure

**One topic per paragraph, at most six sentences.**

**Start with content and stop when it ends.** No preamble, no summary, no closing remarks.

> Prefer: opening with the first rule.
> Over: "This document describes the rules for…" followed by the first rule.

**Write steps as a numbered list.** Imperative mood, one action per item.

> Prefer: "1. Stop the daemon. 2. Delete the cache. 3. Restart the daemon."
> Over: "Stop the daemon, then delete the cache and restart it."

**Put the condition before the command.**

> Prefer: "If the token is expired, refresh it."
> Over: "Refresh the token if it is expired."

**State a rule without its rationale.** Keep the reason only when the rule is not obvious without it.

> Prefer: "If a concept has a canonical home, link to it instead of re-explaining it."
> Over: adding "an inlined explanation duplicates the source of truth and rots when the canonical version changes."

## Linking

**Link a concept's home instead of re-explaining it.**

> Prefer: "the request goes through the [rate limiter](docs/concepts/limits.md#rate-limiter)."
> Over: restating what the rate limiter is, then using it.

## Checking

**A word list checks words, a reader checks meaning.** A project may run [Vale](https://vale.sh) over its docs and comments for word choice, history words, nominalizations, throat-clearing, contractions, and semicolons. One name per thing, one meaning per word, literal phrasing, and one topic per paragraph stay with the reader.

**Keep *begin*, *initiate*, *acquire*, and *robust* out of a mechanical gate.** Each has a technical sense a word list cannot tell from the prose one.

Comments follow the same word lists, with the carve-outs in [comments.md](comments.md).
