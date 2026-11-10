# Architecture

Rules for deciding which component owns what. Each one guards against a design that works on the day it ships and drifts as its components change apart.

## Ownership

**The component that owns the decision also owns the vocabulary the decision is expressed in.** Other components import its terms and types instead of defining their own copy. A second definition of the same terms drifts, and every translation between the two is a place for the decision to change meaning.

> Prefer: the billing module defines `PlanTier` and decides what each tier allows, and the dashboard imports `PlanTier` to render it.
> Over: the dashboard keeps its own `"free" | "pro"` strings and maps them to billing's tiers.
