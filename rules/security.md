# Security

Rules for where secrets live. Each one guards against a design that works in every test and still hands a credential to a machine that should not hold it.

## Credentials

**Software we ship holds no long-lived credential for an account we own.** Software that runs on a machine we do not control, such as a self-hosted server, a desktop or mobile app, or a CLI, can leak any key it holds, and a leaked key keeps working until someone notices. When that software needs our account at a third-party service, it asks a service we operate for a short-lived credential scoped to that one use, each time it needs one. The service we operate keeps the long-lived key and decides who may use it. A key the user brings for their own account is theirs to hold.

> Prefer: the app asks our backend for a transcription session and gets back a key that expires within minutes.
> Over: a build or environment variable that puts our provider API key in every copy of the app.
