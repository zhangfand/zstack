# Architecture

Architecture is the significant abstractions of a system, shaped by its quality needs, such as reliability and latency, and mapped onto infrastructure and teams. Each part follows [abstraction.md](abstraction.md). These rules cover how the parts relate. They guard against a design that works on the day it ships and drifts as its parts change apart.

## Ownership

**Each decision has exactly one owner in the system.** When two components each decide part of the same thing, the boundary is in the wrong place, so move it rather than add coordination between them.

**The component that owns the decision also owns the vocabulary the decision is expressed in.** Other components import its types instead of defining their own copy. A second definition of the same terms drifts, and every translation between the two is a place for the decision to change meaning.

> Prefer: the billing module defines `PlanTier` and decides what each tier allows, and the dashboard imports `PlanTier` to render it.
> Over: the dashboard keeps its own `"free" | "pro"` strings and maps them to billing's tiers.

## Communication

**Choose a call or an event by which way the dependency should point.** A call makes the caller depend on the component it calls. An event lets the owner announce a change without knowing who listens. Use a call when the caller needs an answer or asks for an action, and an event when the owner should not know its consumers.

> Prefer: billing emits `PlanChanged`, and the notifier subscribes to it.
> Over: billing calls `notifier.sendPlanEmail()` after every change, so billing now knows about email.

**Events are part of the API.** An event states a fact the owner decided, in the owner's vocabulary, and carries the same compatibility promise as a call: add fields, and never rename or remove them.

Changing an API that other components already use follows the migration rule in [engineering.md](engineering.md#traps).
