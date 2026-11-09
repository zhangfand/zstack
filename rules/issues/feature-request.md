# Feature Requests

A **feature request** is a GitHub issue for a pain, gap, or missing capability where the change is undecided. It exists to start a design conversation, not to queue implementation. [README.md](README.md) holds the rules every issue shares — the title shape, the Situation section, the type labels — and wins where a rule here conflicts with it.

**A pain with no feature attached is still a feature request.** The Pain section is the request. When the change is already decided and scoped, file a [task spec](task-spec.md) instead.

## Title

**The title states the pain, not the wished-for feature.** Write it in present tense.

> Prefer: "connector: adding an OAuth provider takes a day of hand-written boilerplate".
> Over: "connector: build a provider scaffolding CLI".

## Body

**Required sections: Situation, Pain.** A **Possible directions** section may follow.

- **Pain** — what the gap costs and who pays it: the workaround in use, the time lost, the thing a user cannot do. It links the PRs, incidents, or threads where the gap bit.
- **Possible directions** — sketches of the design space, and picks nothing. Each direction carries its main tension in a line.

**Pain carries evidence.** A pain nobody can point to is a preference.

> Prefer: "two contributors asked in the dev channel how to start a connector and were pointed at a diff of two PRs (#1225, #1480)."
> Over: "the connector authoring experience could be better."

**A proposed solution is one direction, not the request.** When the filer arrives with a solution in mind, the underlying gap goes in Situation and Pain, and the solution enters Possible directions as one candidate.

## Closing

**A feature request closes with a stated decision.** The decision goes in a closing comment. The comment names the task specs it spun out by number, the PR that resolved it, or the reason the pain stays unaddressed. A decision that keeps constraining diffs after the work ships earns an ADR.

**A small change can close the request straight from a PR.** A PR closes a feature request directly when the change is small enough that a task spec would restate the PR description. The PR's [Why](../prs.md#why) section then carries the decision. A larger change flows through the task specs the request spins out.

> Prefer: a one-file change that closes the request with `Closes #<number>` in the PR.
> Over: a task spec whose Scope and Acceptance repeat the PR description.

## Labels

**A feature request carries `feature-request`, never `ready-for-agent`.**
