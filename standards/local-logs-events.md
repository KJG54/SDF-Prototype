# Local Logs And Events Standard

Use this standard for lightweight local logs and append-only event records.

Logs help humans and agents understand what happened. They are not a replacement for project status, phase artifacts, approvals, handoffs, or memory packets.

## Default Rule

Use local JSONL event files before adding queues, brokers, workflow engines, metrics systems, or dashboards.

Prefer:

- one event per line;
- append-only writes;
- local ignored files for routine activity;
- durable artifacts for project-shaping decisions;
- plain summaries that do not contain secrets.

## Storage Locations

Framework-level events:

```text
logs/events/YYYY-MM.jsonl
```

Project-level events:

```text
projects/<slug>/logs/events/YYYY-MM.jsonl
```

These logs are local operational history. They are ignored by Git by default.

## Event Shape

Each event should follow `contracts/schemas/local-event.schema.json`.

Required fields:

- `event_id`: unique local id.
- `timestamp_utc`: ISO-like UTC timestamp.
- `scope`: `framework` or `project`.
- `actor`: who or what wrote the event.
- `event_type`: short kebab-case type such as `doctor-run`, `validation-run`, `phase-started`, or `handoff-written`.
- `summary`: short human-readable description.
- `source`: tool, script, or agent source.

Optional fields:

- `project_slug`
- `details`
- `related_files`

## What To Log

Good local events:

- local runner checks;
- validation runs;
- secret scans;
- project status inspections;
- handoff creation;
- notable tool decisions after they are also recorded in artifacts;
- repeated failures worth troubleshooting later.

Do not log:

- secrets, tokens, passwords, API keys, or private contact details;
- full command outputs that may contain credentials;
- large generated source or binary content;
- project-shaping approvals unless the approval is also recorded in the proper artifact;
- sensitive personal data.

## Relationship To Artifacts

Artifacts remain the durable source of truth.

Use artifacts for:

- phase state;
- requirements;
- architecture;
- approvals;
- gates;
- human actions;
- verification and review;
- shipping decisions;
- memory packets.

Use logs for:

- troubleshooting context;
- chronological breadcrumbs;
- local command history;
- non-authoritative operational notes.

If a log event contradicts an artifact, trust the artifact and investigate the mismatch.

## Runner Support

The local runner can append and view events:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 event -EventType validation-run -Summary "Ran artifact validation"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 events
```

Project event example:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 event -Project portfolio -EventType follow-up-note -Summary "Discussed future publishing provider"
```

The runner must not treat logs as approval, phase advancement, or project status.

