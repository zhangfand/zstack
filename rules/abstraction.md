# Abstraction

An abstraction is a simplified view of one part: it hides a decision and shows only what callers need. These rules hold at every scale, from a function to a service API. They guard against logic placed in the nearest file instead of with its owner, and against interfaces that grow thin wrappers and flag variants, leak how the part works, and state their guarantees only in comments. How parts relate to each other is in [architecture.md](architecture.md).

## Ownership

**An abstraction owns the decisions it hides, and the vocabulary those decisions are expressed in.** The decisions it owns change for the same reason. Split it when two of them change independently. In code, the vocabulary is the types: each term in the abstraction's language is one type with that term's name.

**Name the decision before choosing where its logic goes.** State the logic as one decision, such as "whether a subscription is active", and place it with the abstraction that owns that decision. Logic that takes two decisions to state is two pieces, and each goes to its own owner.

**Logic that decides from an abstraction's state belongs inside that abstraction.** When the logic needs data that the API does not expose, move the logic in instead of exposing the data.

> Prefer: `subscription.isActive()`.
> Over: a caller that reads `subscription.status` and `subscription.expiresAt` to decide the same thing.

**Logic that every caller must run belongs in the owner, and the rest stays in the caller.** If a new caller could skip the logic and nothing would break, the logic is that caller's composition. If skipping it would be a bug, the owner runs it, so that no caller can forget it.

**A decision with no owner gets a new abstraction, not the nearest file.** A `utils` file is not an owner. A request handler, a UI component, or a scheduled job translates its input and calls an owner, and decides nothing itself.

## API

**An API reveals the decision's result, not how the abstraction reached it.** Every field and method in an API is a promise that callers build on. Expose what callers need to act on, and keep the rest inside, where it can change without them. Its types come from the domain, not from a database row or a wire format.

**An API offers a few atomic capabilities, and callers compose the rest.** Each method does one thing that no other method or combination of methods can do. Remove a method that only composes others, or that varies another by a flag or a default. A composition earns its own method only when callers cannot compose it safely, such as two writes that must succeed or fail together.

> Prefer: `get(id)` and `list(filter)`, and callers fetch what they need.
> Over: `get`, `getMany`, `getActive`, and `getOrDefault`, each a thin wrapper over the same read.

**A method's semantics are part of the API, not only its signature.** A caller relies on what the method guarantees: its effect, whether a retry is safe, and what is true when it fails. Name the method for that guarantee. A change to a guarantee breaks callers even when every type stays the same.

**Make illegal states unrepresentable.** A type is checked on every call, and a comment or a runtime check is not. Shape the types so that a value the abstraction would reject cannot be built. Optional fields that only make sense together allow combinations nobody meant, so model each valid case as its own member of a union.

> Prefer: `type Order = { status: "draft" } | { status: "submitted"; submittedAt: Date }`.
> Over: `{ status: string; submittedAt?: Date }` with a comment that `submittedAt` is set once the order is submitted.

**Parse, don't validate.** Turn input, once and at the edge, into a type that cannot hold a bad value, and pass that type inward. Code past the edge never checks the raw input again. The parser rejects anything some consumer cannot handle faithfully, including field combinations that are each valid alone. Every entry point calls the same parser before it stores or acts on anything.

> Prefer: `parseSchedule(body): Schedule` at the route, and `runJob(schedule: Schedule)` below it.
> Over: `runJob(body)` that checks `if (body.cron && body.at)` in three places.

**Events are part of the API.** An event states a fact the abstraction decided, in its own vocabulary, and carries the same compatibility promise as a method: add fields, and never rename or remove them.
