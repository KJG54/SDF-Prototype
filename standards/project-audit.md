# Project Audit Standard

Use this for project-specific audits. See `standards/audit-workflow.md` for the shared framework and project audit workflow.

Audits should inspect and report. They should not silently change project scope, architecture, dependencies, approvals, phase state, shipping targets, or memory.

## When To Audit

Run or recommend a project audit:

- before major implementation;
- before shipping;
- after repeated errors;
- after confusing handoffs;
- after many framework or project artifact changes;
- when resuming an old or paused project;
- when the human asks whether the project is still on track.

## What To Check

- Current phase and phase gate status.
- Required artifacts for the current phase.
- Paired Markdown/JSON artifact alignment using `standards/artifact-validation.md`.
- Open questions.
- Required human actions.
- Blocking issues and unresolved errors.
- Deferred issues and whether they were approved.
- Runtime/environment strategy.
- Dependency locality and system-wide tool justifications.
- Current command folder expectations.
- Git/GitHub readiness when relevant.
- Testing and verification status.
- Shipping readiness when relevant.
- Memory/lessons status when closing a project.
- Task records, claims, delegations, and handoffs when relevant.
- Local event summaries, treated as breadcrumbs rather than authority.
- Stale artifacts or contradictory phase records.

## Suggested Local Checks

Use these as audit evidence:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 status -Project <slug>
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 secret-scan
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 tasks -Project <slug>
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 events -Project <slug>
```

The runner output is evidence, not approval. If a runner result disagrees with an artifact, trust the artifact enough to investigate the mismatch.

## Audit Output

Audits should produce:

- summary;
- status: healthy, needs attention, blocked, or risky;
- findings ordered by severity;
- recommended next actions;
- human decisions needed;
- files inspected;
- limitations of the audit.

## Human Interaction

The agent should explain audit findings plainly and ask what to fix first if multiple issues matter.
