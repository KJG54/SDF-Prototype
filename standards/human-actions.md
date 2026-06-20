# Human Actions Standard

Use human-action files when the human needs to do something outside normal conversation before the project or framework can proceed safely.

Human actions are not casual reminders. They are durable instructions for required, recommended, or optional work that depends on the human's environment, accounts, approvals, manual testing, credentials, installations, or external decisions.

## Default Rule

Create a human-action artifact when the human must:

- install or configure a tool;
- authenticate with a service;
- add or rotate a credential;
- run a command manually;
- test something in an app, browser, device, or account the agent cannot safely access;
- approve or reject an external decision;
- provide files, screenshots, account access, payment details, legal input, or private information;
- recover from an error that requires human control of the machine or account;
- choose whether to defer a blocker.

Do not bury required human work only in chat. If the action affects phase progress, safety, credentials, tools, deployment, publishing, or project-shaping decisions, create or update a human-action file.

## Locations

Project human actions belong in the active project:

```text
projects/<slug>/artifacts/human-actions/ACTION-001-short-name.md
projects/<slug>/artifacts/human-actions/ACTION-001-short-name.json
```

Framework-level human actions belong in:

```text
artifacts/human-actions/ACTION-001-short-name.md
artifacts/human-actions/ACTION-001-short-name.json
```

Use the template pair:

```text
templates/artifacts/ACTION-001-human-action.md
templates/artifacts/ACTION-001-human-action.json
```

## Status Values

Use these statuses:

- `pending`: the human still needs to do it.
- `complete`: the human confirmed it is done or the agent verified the result.
- `deferred`: the human explicitly chose to postpone it.

Use these action types:

- `required`: blocks current progress or a phase gate.
- `recommended`: not strictly blocking, but important for quality, safety, or reliability.
- `optional`: useful, but not needed for the approved path.

## Required Content

Every human-action file should explain:

- what the human needs to do;
- why it matters;
- who should do it;
- where to do it;
- what to check before starting;
- exact steps;
- exact commands, if any;
- how to verify success;
- what to do if something goes wrong;
- what to tell the agent afterward;
- whether the agent can do it later with approval;
- whether it blocks the current phase.

Commands must include the exact folder where they should be run and a beginner-safe explanation when the command may be unfamiliar.

## Blocking And Phase Gates

A required human action blocks phase advancement unless:

- the human completes it;
- the human explicitly defers it;
- the phase gate records why the next phase naturally resolves it;
- or the work is documented as out of scope.

When a human action is created, update the project checklist if one exists. When it is completed or deferred, update both the Markdown and JSON action files and any checklist or phase-gate references.

## Security And Privacy

Use human actions instead of asking the human to paste secrets into chat.

For credentials, tokens, private accounts, payment information, or sensitive files:

- explain what is needed and why;
- tell the human where to store or enter it safely;
- avoid copying secrets into Markdown, JSON, logs, terminal output, screenshots, or source code;
- create a rotation action if a secret may have been exposed.

## Relationship To Other Artifacts

Human actions do not replace approvals, task records, phase gates, or status files.

- Use approval artifacts for human decisions.
- Use task records for planned work.
- Use phase gates to decide whether a phase can close.
- Use status and checklist files to summarize current project state.
- Use human-action files for concrete human steps that must be tracked.

## Definition Of Done

A human action is done when:

- the required step has been completed or explicitly deferred;
- verification is recorded;
- any affected checklist, status, task, approval, or phase-gate artifact is updated;
- remaining risks are documented.
