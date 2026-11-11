# Design diagrams

A **design diagram** is the picture a reviewer reads to judge a domain or API design: who owns what, which way the dependencies point, and which calls cross each boundary. These rules guard against a design presented as a long document, where every detail is present and the reviewer still cannot see the whole design. The steps to build one are in the [domain-diagram](../skills/domain-diagram/SKILL.md) skill. Labels follow [writing.md](writing.md), and boundaries follow [architecture.md](architecture.md).

## The page

**The picture comes first, and the reviewer reads nothing else to see the boundaries.** Below it come a few sentences on the whole design, then only the decisions the reviewer has to make. Signatures, file moves, preserved behaviour, and the PR plan go in a folded appendix that the implementer reads and the reviewer can skip.

**In the appendix, each type or interface sits whole in its own code block.** A comment on it names its building block and says what it means. The reviewer can then comment on one declaration at a time.

**One page answers one question.** If a page grows past what the reviewer reads in one sitting, split it into linked pages, one per question.

**Pick the form by the question.**

- Who owns what, and what calls cross each boundary: an owner map.
- Which component may depend on which: a layered dependency graph.
- What happens over time across several components: a sequence diagram with one lifeline per component.

**An unfamiliar mechanism gets one concrete scenario.** Name a real case and walk it through each option. A table of "the person does X, the system does Y" over time works well for this.

## Owner map

**Each box is an owner, and each edge is one API, named in full.** Label an edge with the type and the member it calls, such as `Invoices.issue(order)`, not "issues an invoice" or a bare `issue()`. A full name shows when many edges go through one interface, which is a sign that the interface is too wide.

**Every call that crosses a boundary has an edge, and every edge is a real call.** Walk the code or the proposed API for each edge. A call that the picture misses is a defect in the picture. Draw each edge between the two boxes it joins, and route it around every other box.

**Inside a context, draw its layers as bands.** Put callers from outside the context at the top, then the application, the domain, and the infrastructure layers. An edge that crosses a band then shows which layer calls which.

**Label each box with its DDD building block.** Use aggregate, entity, value object, domain service, port, application service, or adapter. A box called "domain files", "helpers", or "rules" names a folder, not a concept.

**Every name on the picture is a domain word or a real identifier.** A label you invented for the picture is a question the reviewer has to ask. If no word fits, the design has a missing concept, so raise it as a decision.

> Prefer: a box `RefundPolicy`, domain service, with an edge `RefundPolicy.allows(order, reason)`.
> Over: a box "Rules" holding three unnamed functions, with an edge labelled "checks".

## Journeys

**A few journeys light up the edges they use.** Pick the most common and representative ones, one for each shape of flow, such as setup, the everyday case, a failure, and a call out to another context. Skip variants that take the same path.

**A journey is toggled by a click, not a hover.** A click selects it and a second click clears it. Several journeys can be on at once, so the reviewer can compare them. A selected journey dims every other edge and shows its numbered steps beside the picture.

## Dependency graph

**Draw dependencies in layers, not as a list.** Each node sits above the nodes it depends on, and nodes with no order between them share a row. Draw an edge that points back up, which closes a cycle, in a different line style, and name each cycle in the text.

**Every mark that differs from the rest is explained on the page.** A dotted edge, a colour, or a faded box gets a line in the legend. If the reviewer asks what a mark means, the legend missed it.

## After sign-off

**A signed-off picture changes only where the build diverges from it.** Record each divergence on the picture or in the appendix. Do not track PRs or progress on it.
