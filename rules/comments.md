# Code Comments

A **code comment** is prose inside a source file. The code states what happens. A comment carries only what the code cannot state: the contract a caller relies on, the why behind a non-obvious choice, or the argument that a hard algorithm is correct. The bar this rulebook clears comes from [rulebooks.md](rulebooks.md).

A comment is technical writing, so it follows [writing.md](writing.md) — the same word choice, the same verbs, the same sentence rules — with two carve-outs this file owns. The ban on semicolons and contractions covers docs and not comments. The rule on history words yields to the admission rule below.

The miss that earned this rulebook: agent-written diffs kept arriving with comments that restate the line below them or narrate the change that produced them. Review caught each one by hand because the bar lived nowhere.

## Format

**A comment is one of three kinds, set by where it sits.** Each kind has its own content rule.

### Module comment

**A module comment links its doc and adds only what is local.** It sits at the top of the file, detached from any declaration — a comment attached to one is a boundary or body comment. When a [concept](docs/concepts.md) or [architecture](docs/architecture.md) doc covers the module's behavior, the comment links to that doc and adds only what is local to the file. It never restates the doc.

> Prefer: `// Stripe webhook adapter. Payment contract: docs/architecture/payments.md.`
> Over: a file header that re-explains payment routing, which payments.md already owns.

### Boundary comment

**A boundary comment states what the caller may rely on.** It sits on an exported symbol or a public member of one — a function, type, action, or class field another module relies on. It states the semantics: what the caller may rely on that the signature cannot carry. Units, null and error behavior, side effects, ordering, invariants. It never describes the implementation.

> Prefer: `/** Returns the session for the id, or null when none exists. Never creates one. */`
> Over: `/** Looks up the id in the session map and returns the result. */`

**When the name and types carry the contract, write no comment.**

> Prefer: `function isExpired(session: Session): boolean` with no comment.
> Over: `/** Checks whether the session is expired. */` above it.

**State every directive the signature cannot carry, and only those.** A **directive** is a condition the caller meets or accounts for to call correctly. These include preconditions and postconditions, thread safety, required call order, idempotency, blocking and cancellation, which failures are retryable, ownership and lifetime of a returned value. A directive that holds by default stays unstated.

> Prefer: `/** Call after connect(). Safe to retry — a duplicate send is dropped by message id. The returned buffer belongs to the pool, so copy it to keep it past the next call. */`
> Over: the same function with a comment stating only what it returns.

**State a relation between two types once.** When a type reifies the relation, that type's boundary comment carries the relation and its invariants. When the relation is inlined as a field on one side, the module comment carries it.

> Prefer: `/** Links one Account to one Workspace. An Account holds at most one Membership per Workspace. */` on the `Membership` type.
> Over: the same invariant stated on `Account.workspaceIds` and again on `Workspace.accountIds`.

**Add an example when a caller would otherwise guess a shape.** An example enters a boundary comment when a caller would otherwise guess the shape of an argument or a return value. Write it with the contract, before the implementation. No tooling runs it.

> Prefer: `/** Parses a cron expression. parse("0 9 * * 1") returns the Monday 09:00 schedule. */`
> Over: a prose paragraph describing the accepted field order and wildcard syntax.

### Body comment

**A body comment is the exception, and says what the code cannot.** It sits anywhere the other two kinds do not: inside a function, or on a declaration no other module imports. Body comments are exceptions — most code carries none. A body comment states one of three things the code cannot: the why behind a non-obvious choice, the argument that a hard algorithm is correct, or a cost the surrounding lines do not show.

> Prefer: `// Baileys delivers history newest-first, so index 0 is the latest message.`
> Over: `// iterate over the messages in reverse`.

**Argue correctness where reading the code cannot check it.** A **correctness argument** covers code a reader cannot check by reading it — concurrency, numeric work, a hand-rolled data structure. State the algorithm in enough detail that a reader can check the algorithm is sound, then check whether the code still matches it.

> Prefer: `// Head advances only after the slot write commits, so a concurrent reader sees either the old slot or the complete new one, never a torn write.`
> Over: `// advance head after writing`.

**Note a cost the surrounding lines do not show.** A **cost note** covers a performance property the surrounding lines do not show: complexity that depends on how a caller uses the function, an allocation that matters at scale, an I/O or cache effect. A cost visible in the code beside it stays unstated.

> Prefer: `// The reconciler calls this once per open session, so work added here scales with the session count.`
> Over: `// this loop is O(n)` above a visible loop over n.

### Vocabulary

**Use the identifier, not a synonym.** A comment names a thing by its identifier in the code. A synonym for a named type, function, or field fails, however well it reads. One term per concept across a module. Word choice follows [writing.md](writing.md).

> Prefer: `// The sentinel drops the event when no ChannelAdapter claims it.`
> Over: `// The triage layer drops the event when no connector claims it.`

## Admission

**A comment enters only when the code alone would hide something that matters.** It enters when a competent reader of the code alone would miss something true and load-bearing. A comment that restates the code fails.

> Prefer: `// The webhook can arrive before the DB row commits — retry, do not 404.`
> Over: `// increment the retry counter`.

**Non-trivial concurrency always gets a comment.** Concurrency is non-trivial when correctness depends on an ordering between tasks, a lock discipline, shared mutable state, or cancellation that no type or API enforces. A missing comment there is a defect. State the lock order, what a lock guards, why an unsynchronized access is safe, or the ordering two tasks depend on.

> Prefer: `// Only the session loop writes activeSessions, so this read needs no lock.`
> Over: the same unsynchronized read with nothing stating why it is safe.

**Describe the code as it is, not how it changed.** A comment is for a reader who never saw a previous version. Narrating the change — what the code did before, or how this version differs — fails, whatever the wording. Present-tense prose passes even when it contains a phrase like *no longer* or *used to*.

> Prefer: `// After unref, the timer no longer keeps the process alive.`
> Over: `// This handler no longer retries — retry moved into the queue worker.`

**Git history owns provenance.** A comment never cites the change, ticket, or PR that produced the code. An external reference enters only when it is a live constraint on the code beside it.

> Prefer: `// Workaround: grammy drops the reply markup on editMessageText — re-send the keyboard instead.`
> Over: `// added in PR #1234 to fix the retry bug.`

## Eviction

**A comment a change falsifies leaves in that change.** Not in a follow-up.

> Prefer: the diff that makes retries configurable also deletes `// retries three times`.
> Over: the same diff shipping with the comment still claiming three.

**A comment that fails the bar leaves on sight.** Deleting one needs no issue and no discussion.

## Intake

**A recurring review correction gets an answer.** It either becomes a rule in this file, or the maintainer rejects it in writing and states the reason. Silent recurrence means this file is dead.

**A why repeated at three sites needs one home.** It stops being a comment. Give it one home the sites can point to — the module that owns the behavior, or an [architecture](docs/architecture.md) doc. A [concept](docs/concepts.md) entry or an [ADR](docs/adrs.md) takes it only when it clears that family's admission bar.
