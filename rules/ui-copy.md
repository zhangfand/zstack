# UI Copy

**UI copy** is the text a user reads inside an application: labels, buttons, headings, the text under a label, empty states, dialogs, and error messages. The field calls this UX writing, or content design. This rulebook decides what text the screen carries. A product's own voice guide decides how that text sounds.

The miss that earned this rulebook: agent-built screens arrive with a sentence under every label. The sentence restates the label, says what any user already knows, or explains how the code works.

## What the screen says

**Text under a label is absent by default.** Keep a line only when the user needs a fact before acting that the screen does not already show: what the action costs or cannot undo, a limit on what it accepts, why something is in a state the user did not choose, or how it differs from the option beside it. When an action has several effects, keep the one that matters most. A line that restates the label is deleted, not reworded. When nothing is left, the slot stays empty.

> Prefer: a "Notifications" toggle with nothing under it.
> Over: "Notifications" with "Manage how you receive notifications." under it.

**Write for the user, not for the developer.** Describe what the user sees happen. Storage, sync, caches, endpoints, libraries, internal names, and raw exception text stay out of the UI. Name an internal thing only when the user has to act on it, such as an error code to give support.

> Prefer: "Changes apply after you reload the page."
> Over: "Settings are cached in localStorage and read on mount."

**A label names the action and its object.** Generic verbs such as *New*, *Submit*, *Manage*, *Configure*, and *OK* leave the user to guess what happens.

> Prefer: "Connect repository"
> Over: "New"

**Show the next step as a control, not a sentence.** When the user can fix a state or unlock a feature, put the button that does it on the screen.

> Prefer: an "Upgrade to Pro" button.
> Over: "Sign up for the Pro plan to use this option."

**Call one thing by one name, the user's name for it.** The same thing keeps the same name across labels, messages, and confirmations. The name comes from the user's words, not from the code.

## Out of scope

Tone, person, capitalization, punctuation, and contractions belong to the product's voice guide. The references disagree on them: Shopify Polaris uses contractions, and other products spell out every negation.
