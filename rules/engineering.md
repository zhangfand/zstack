# Engineering

Rules for changing code that hold in any repo. Each one guards against a change that passes typecheck, lint, and tests and is still wrong.

## Traps

**A migration that breaks an interface first breaks every consumer that has not migrated yet.** Keep existing interfaces, schemas, and contracts working while new behavior lands alongside them. Sequence the break last, or put it behind a switch.

**A new dev-only branch in a production path ships to production.** Prefer an existing config or env switch. Put seeding and fixtures in setup scripts, not in the code the server runs.

**Type checks and tests verify code correctness, not feature correctness.** For a change a user can see, also run the feature: open it in a browser, call the endpoint, or run the CLI, and confirm the behavior the change set out to produce.

**A comment, doc, or rule that a change falsifies leaves in that change.** A follow-up never comes. See [comments.md](comments.md#when-to-cut).
