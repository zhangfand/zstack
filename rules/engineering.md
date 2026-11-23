# Engineering

Rules for changing code that hold in any repo. Each one guards against a change that passes typecheck, lint, and tests and is still wrong.

## Traps

**A migration that breaks an interface first breaks every consumer that has not migrated yet.** Keep existing interfaces, schemas, and contracts working while new behavior lands alongside them. Sequence the break last, or put it behind a switch.

**A new dev-only branch in a production path ships to production.** Prefer an existing config or env switch. Put seeding and fixtures in setup scripts, not in the code the server runs.

**Type checks and tests verify code correctness, not feature correctness.** For a change a user can see, also run the feature: open it in a browser, call the endpoint, or run the CLI, and confirm the behavior the change set out to produce.

**Data that crosses a process boundary is checked again where it is read.** A stored row, a message, a file or a request body was checked by whoever wrote it, but the reader cannot see that check. A later writer, an older version, or a bug can skip it. Parse the data at the reader with the same validator the writer used, shared from one place, and treat a value that fails as absent.

**A comment, doc, or rule that a change falsifies leaves in that change.** A follow-up never comes. See [comments.md](comments.md#when-to-cut).

**Existing code shows what is, not what should be.** Before a change decides what a part is responsible for, look for the written promise or rule that covers the decision, and reason from the goal where none does.
