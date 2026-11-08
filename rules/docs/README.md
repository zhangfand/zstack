# Docs

A repo's `docs/` holds the context code derives from: why the project exists, what the system promises, and what each term means. In AI-assisted work the bottleneck is the cost of communication, not the cost of producing code, so that context lives in the repo, where an agent reads it.

Docs state what is true now. ADRs record why each standing decision was made and what it rejected. Keeping the why separate keeps the load-bearing context free of stale designs.

Each doc family has a rulebook here:

- [concepts.md](concepts.md): terms and the contracts they carry.
- [principles.md](principles.md): disciplines for design and code that changed a real decision.
- [architecture.md](architecture.md): the components of one surface and the invariants between them.
- [adrs.md](adrs.md): standing decisions, the alternatives they rejected, and why.

## Traps

**A section that names a mechanism instead of an invariant reads as documentation and cannot be applied to a diff.** Each section in concepts and architecture docs names an invariant between components, a rule a contributor uses to decide whether a change is allowed, statable without reference to any file, type, or function.

> Prefer: "The routing layer cannot observe which external channel a message came from. The channel adapter absorbs every channel specific."
> Over: "We have a `ChannelAdapter` interface that each channel implements."

The first sentence is the contract. The second is the mechanism that enforces it, and it belongs in code review.

**Design context written into `docs/` outlives the change and rots there.** The design context of an in-flight change lives in its [PR description](../prs.md). A decision that keeps constraining diffs after the change ships gets an [ADR](adrs.md), and the rest stays in git history.
