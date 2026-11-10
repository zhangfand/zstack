# Architecture

Rules for drawing a component's responsibility boundary and the API that expresses it. Both live in one rulebook because the API is the boundary made concrete: a boundary with no API is an intention, and an API with no boundary is a pile of functions. Each rule guards against a design that works on the day it ships and drifts as its components change apart.

## Boundaries

**A component owns a decision, and no other component makes it again.** Name the decision a component is responsible for before naming its functions. When two components each decide part of the same thing, the boundary is in the wrong place, so move it rather than add coordination between them.

**The component that owns the decision also owns the vocabulary the decision is expressed in.** Other components import its terms and types instead of defining their own copy. A second definition of the same terms drifts, and every translation between the two is a place for the decision to change meaning.

> Prefer: the billing module defines `PlanTier` and decides what each tier allows, and the dashboard imports `PlanTier` to render it.
> Over: the dashboard keeps its own `"free" | "pro"` strings and maps them to billing's tiers.

## API

**An API reveals the decision's result, not how the component reached it.** Every field and method in an API is a promise that callers build on. Expose what callers need to act on, and keep the rest inside, where it can change without them.

**An API offers a few atomic capabilities, and callers compose the rest.** Each method does one thing that no other method or combination of methods can do. Remove a method that only composes others, or that varies another by a flag or a default. A composition earns its own method only when callers cannot compose it safely, such as two writes that must succeed or fail together.

> Prefer: `get(id)` and `list(filter)`, and callers fetch what they need.
> Over: `get`, `getMany`, `getActive`, and `getOrDefault`, each a thin wrapper over the same read.

**A method's semantics are part of the API, not only its signature.** A caller relies on what the method guarantees: its effect, whether a retry is safe, and what is true when it fails. Name the method for that guarantee. A change to a guarantee breaks callers even when every type stays the same.

**Events are part of the API.** An event states a fact the owner decided, in the owner's vocabulary, and carries the same compatibility promise as a call: add fields, and never rename or remove them.

**Choose a call or an event by which way the dependency should point.** A call makes the caller depend on the component it calls. An event lets the owner announce a change without knowing who listens. Use a call when the caller needs an answer or asks for an action, and an event when the owner should not know its consumers.

> Prefer: billing emits `PlanChanged`, and the notifier subscribes to it.
> Over: billing calls `notifier.sendPlanEmail()` after every change, so billing now knows about email.

Changing an API that consumers already use follows the migration rule in [engineering.md](engineering.md#traps).
