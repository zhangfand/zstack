# Architecture Decision Records

An **architecture decision record (ADR)** records one standing decision: the choice, the alternatives rejected, and the forces that decided between them. ADRs live in `docs/adrs/`, one file per decision. The near miss is the change-scoped design write-up, which belongs in a [PR description](../prs.md): that captures the ephemeral context of one change at a point in time, while an ADR carries a decision that keeps constraining diffs. Prose rules come from [writing.md](../writing.md). The bar this rulebook clears comes from [rulebooks.md](../rulebooks.md).

The family exists to end re-litigation. The miss that earned this rulebook: the brand color fails WCAG AA against white, and the obvious fix — darken the brand values — kept getting re-proposed. The decision to hold the color and meet contrast through brand-pinned alternatives lived nowhere, so it was re-argued each time.

## Format

**One file per decision, and the filename never changes.** The path is `docs/adrs/kebab-title.md`. The filename is the record's key.

**A header carries Status and Date.** The file leads with a header carrying **Status** (`Accepted` / `Superseded`) and **Date**. A `Superseded` record links its successor.

**Required sections, in order: Context, Decision, Alternatives, Consequences.** A record may add sections. It may not omit one.

- **Context** — the forces on the decision: the constraints and goals a reader needs to weigh the alternatives.
- **Decision** — the choice, stated in one or two sentences.
- **Alternatives** — every rejected option, one entry each.
- **Consequences** — what the decision makes easier, what it makes harder, and what future diffs must respect.

**Each alternative names the force that killed it.** A verdict alone is not enough.

> Prefer: "Fall back to an available model and re-pin — rejected because a silent substitution changes what model a thread runs on without the user knowing."
> Over: "Fall back to an available model and re-pin — rejected."

## Admission

**Record a decision that is standing and goes against common practice.** A decision earns a record when both hold:

1. It is standing — it constrains diffs beyond the change that introduced it.

   > Prefer: recording "a session always runs the model that produced it" — every future resolution path must respect the pin.
   > Over: recording "the session table backfill runs before the cutover" — the constraint dies when the migration lands.

2. It deviates from common practice — a competent contributor applying the industry default would decide differently, so without the record the default gets re-proposed. A real re-proposal is the strongest evidence, and the record names one when it exists.

   > Prefer: recording "a pinned model that cannot run fails the turn" — the industry default is silent fallback to an available model.
   > Over: recording "the API adds a rate limiter" — common practice needs no defense.

**The invariant lives elsewhere, the ADR records why it won.** An invariant a diff must not break belongs in [concepts](concepts.md) or [architecture docs](architecture.md). The ADR records why the invariant won over its alternatives, and links to the invariant's home.

## Eviction

**A replaced decision is marked Superseded, not deleted.** A replaced decision flips its record to `Superseded` with a link to the successor record. The record stays as history.

**Delete the record when the decision can no longer arise.** That is when the surface it constrained is gone.

## Intake

**A re-argued decision gets an answer.** The re-proposal exits through one of two doors: the decision becomes a record here, or the maintainer rejects the record in writing and states the reason. Silent recurrence means the family is dead.

**Route other misses to their family.** a miss about what a term means goes to [concepts](concepts.md), and a miss about judgment goes to [principles](principles.md). A miss about one specific choice with rejected alternatives lands here.
