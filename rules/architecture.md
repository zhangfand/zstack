# Architecture

Architecture is the significant abstractions of a system, shaped by its quality needs, such as reliability and latency, and mapped onto infrastructure and teams. Each part follows [abstraction.md](abstraction.md). These rules cover how the parts relate. They guard against a design that works on the day it ships and drifts as its parts change apart.

## Ownership

**Each decision has exactly one owner in the system.** When two components each decide part of the same thing, the boundary is in the wrong place, so move it rather than add coordination between them. Other components import the owner's types instead of defining their own copy, because a second copy drifts.

> Prefer: the billing module defines `PlanTier` and decides what each tier allows, and the dashboard imports `PlanTier` to render it.
> Over: the dashboard keeps its own `"free" | "pro"` strings and maps them to billing's tiers.

**A client draws what the server sends and reports what the person did; the server decides what it means.** With more than one client, such as a web app and a phone app, a decision written in a client is written once per client, and the copies drift. When two clients would write the same branch, move it to the server and have both send the raw action.

> Prefer: both apps send `POST /widgets/:id/events { name: "dismiss" }`, and the server decides that a dismissal answers the waiting agent with `{ dismissed: true }`.
> Over: each app checks `if (name === "dismiss")` and builds `{ dismissed: true }` itself before posting it.

## Communication

**Choose a call or an event by which way the dependency should point.** A call makes the caller depend on the component it calls. An event lets the owner announce a change without knowing who listens. Use a call when the caller needs an answer or asks for an action, and an event when the owner should not know its consumers.

> Prefer: billing emits `PlanChanged`, and the notifier subscribes to it.
> Over: billing calls `notifier.sendPlanEmail()` after every change, so billing now knows about email.

Changing an API that other components already use follows the migration rule in [engineering.md](engineering.md#traps).
