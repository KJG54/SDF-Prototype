# Coordination Rules

Codex leads. Claude collaborates when useful.

Use `standards/file-based-task-records.md` when work needs durable task records, claims, or coordination without adding an external task manager or broker.

Task records coordinate planned work. They do not replace phase artifacts, approvals, status files, checklists, delegation artifacts, or handoff artifacts.

## Delegation

Every delegated task needs:

- task goal
- relevant files and artifacts
- constraints
- acceptance criteria
- approval boundaries
- expected handoff format

If the work is substantial enough to track separately, create or reference a `TASK-*` record before delegation.

## When To Consider Claude

Codex should consider Claude during:

- large or repetitive implementation work;
- complex debugging;
- second opinions on architecture, security, privacy, or data modeling;
- review of code that Codex just wrote;
- parallel investigation when the task can be split cleanly;
- test planning or edge-case review.

Codex should explain why Claude is useful before meaningful handoff. Human approval is required when the delegation could change scope, architecture, dependencies, cost, privacy, security, deployment, or project direction.

Claude should not make project-shaping decisions. Claude can recommend, investigate, implement approved work, review, and report back.

## Handoff

Every handoff should include:

- what was done
- files changed
- verification performed
- issues found
- remaining risks or open questions
- recommended next step

The human should receive a plain-language summary of any important Claude handoff before decisions are made from it.
