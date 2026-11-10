# Abstraction

An abstraction is a simplified view of one part: it hides a decision and shows only what callers need. These rules hold at every scale, from a function to a service API. They guard against interfaces that grow thin wrappers and flag variants, leak how the part works, and state their guarantees only in comments. How parts relate to each other is in [architecture.md](architecture.md).

## Ownership

**An abstraction owns one decision, and its API speaks that decision's vocabulary.** Name the decision before naming the functions. In code, the vocabulary is the types: each term in the abstraction's language is one type with that term's name.

## API

**An API reveals the decision's result, not how the abstraction reached it.** Every field and method in an API is a promise that callers build on. Expose what callers need to act on, and keep the rest inside, where it can change without them. Its types come from the domain, not from a database row or a wire format.

**An API offers a few atomic capabilities, and callers compose the rest.** Each method does one thing that no other method or combination of methods can do. Remove a method that only composes others, or that varies another by a flag or a default. A composition earns its own method only when callers cannot compose it safely, such as two writes that must succeed or fail together.

> Prefer: `get(id)` and `list(filter)`, and callers fetch what they need.
> Over: `get`, `getMany`, `getActive`, and `getOrDefault`, each a thin wrapper over the same read.

**A method's semantics are part of the API, not only its signature.** A caller relies on what the method guarantees: its effect, whether a retry is safe, and what is true when it fails. Name the method for that guarantee. A change to a guarantee breaks callers even when every type stays the same.

**A guarantee that a type can state goes in the type.** A type is checked on every call, and a comment or a runtime check is not. Shape the types so that a value the abstraction would reject cannot be built.

> Prefer: `type Order = { status: "draft" } | { status: "submitted"; submittedAt: Date }`.
> Over: `{ status: string; submittedAt?: Date }` with a comment that `submittedAt` is set once the order is submitted.
