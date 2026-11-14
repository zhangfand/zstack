# Security

Rules for where secrets live. Each one guards against a design that works in every test and still hands a credential to a machine that should not hold it.

## Credentials

**A deployed instance holds no long-lived credential for a resource we own.** Every copy of an instance runs on a machine we do not control, so a key it holds can leak and outlive any revocation we plan. When an instance needs our account at a third-party provider, it asks our service for a short-lived credential scoped to that one use, each time it needs one. Our service keeps the long-lived key and decides who may use it. A credential the operator brings for their own account is theirs to hold and is outside this rule.

> Prefer: the instance asks the cloud service for a speech-to-text session, and gets back a key for that session that expires within minutes.
> Over: an environment variable that gives every instance our provider API key.
