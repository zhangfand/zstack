---
name: domain-diagram
description: Draw a domain or API design as one interactive picture for a person to review. Use when presenting a design for sign-off, when the person asks to illustrate, draw, visualize or picture a design or a dependency graph, or says a design document hides the bigger picture.
---

# Draw a domain design

Goal end-state: one page the person can open, with the whole design in one picture that follows [design-diagrams.md](../../rules/design-diagrams.md), a few sentences under it, the decisions they owe, and an appendix. The person signs off on the design or names what to change.

## Steps

1. **Pick the question and the form.** Name the one question the page answers, and choose the form from the rulebook. If the person asked for an earlier picture's style, open that picture first and match it.

2. **List the owners and the edges from the source.** For an owner map, write a table of every edge: from, to, the full API name, and whether it reads or writes. Fill it from the proposed API and the code, not from memory. For a dependency graph, take the edges from the repo's import rules or an import scan.

3. **Check every name against the domain language.** Look up each box and edge label in the repo's glossary or domain docs. Name each box's building block. A name that is not in the language goes to the person as a question, and stays off the picture until it is settled.

4. **Pick the journeys.** Choose the few that cover each shape of flow. Walk each one through the code or the API, and fix the edge table where the walk finds a call it missed.

5. **Build the page.** Draw the picture as inline SVG with click-to-toggle journeys, in a page the person can open. Put the sentences and the decisions under the picture, and fold the API, the words, the moves, the preserved behaviour, and the PRs into the appendix.

6. **Look at it before you send it.** Render the page in a browser and take a screenshot. Fix labels that overlap, edges that cross a box they do not join, and journeys that do not light up. If no browser is available, say so when you send it.

7. **Send the link with the decisions.** Lead with what the person has to decide, then link the page. Keep the message short.

8. **Keep it current.** When the person changes the design, update the picture, the edge table, the journeys, and the appendix together. After sign-off, change the picture only where the build diverges from it.
