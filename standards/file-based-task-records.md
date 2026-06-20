# File-Based Task Records Standard

Use this standard when work needs a task queue, backlog, claim, or coordination record without adding Jira, Trello, Redis, RabbitMQ, Temporal, or another service.

Task records help agents and humans coordinate work. They do not replace phase artifacts, approvals, status files, checklists, or human decisions.

## Default Rule

Use Markdown and JSON task records before external task managers or message brokers.

Prefer:

- one task per durable record;
- Markdown for the human-facing task;
- JSON for agent-readable task state;
- explicit acceptance criteria;
- explicit approval boundaries;
- clear handoff requirements;
- Git history for durable changes.

## Locations

Project task records:

```text
projects/<slug>/artifacts/tasks/TASK-001-short-name.md
projects/<slug>/artifacts/tasks/TASK-001-short-name.json
```

Framework task records:

```text
artifacts/tasks/TASK-001-short-name.md
artifacts/tasks/TASK-001-short-name.json
```

If a project has many temporary work claims, store claims separately:

```text
projects/<slug>/artifacts/claims/
```

Claims are coordination notes, not approval.

## Task Status Values

Use these task statuses:

- `proposed`: recorded idea or possible task, not approved scope.
- `approved`: approved for work.
- `in-progress`: someone is actively working it.
- `blocked`: cannot continue without a blocker being resolved.
- `ready-for-review`: work appears complete and needs review.
- `done`: accepted as complete.
- `deferred`: intentionally postponed.
- `cancelled`: no longer planned.

## Required Fields

Task JSON must follow `contracts/schemas/task-record.schema.json`.

Every task should include:

- `id`
- `type`
- `title`
- `status`
- `scope`
- `project_slug`
- `phase`
- `goal`
- `context`
- `acceptance_criteria`
- `constraints`
- `related_files`
- `approval_required`
- `approval_status`
- `assigned_to`
- `claim_status`
- `handoff_required`
- `notes`

## Approval Boundary

A task with `approval_status: approved` means the task record says approval was recorded somewhere. It does not create approval by itself.

Project-shaping approval must still be recorded in the relevant:

- approval artifact;
- phase gate;
- architecture artifact;
- requirements artifact;
- human-action artifact;
- or explicit conversation summary.

When in doubt, keep the task `proposed` or `blocked` and ask the human.

## Relationship To Delegation And Handoffs

Use task records for planned work.

Use delegation artifacts when assigning meaningful work to Claude or another collaborator.

Use handoff artifacts when work was performed and another agent or human needs to continue from a reliable summary.

Task records may reference delegation and handoff artifacts, but they should not duplicate them in full.

## Runner Support

The local runner can list task records:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 tasks
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 tasks -Project portfolio
```

The runner does not create or approve tasks. Codex should create task records only when useful for coordination and should ask approval when the task changes scope, architecture, dependencies, cost, privacy, security, deployment, or project direction.

