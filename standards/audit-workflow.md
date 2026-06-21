# Audit Workflow

Use this standard when the human asks whether Software Factory or an active project is healthy, on track, ready for a phase gate, ready for shipping, or safe to resume.

Audits inspect and report. They do not silently change scope, architecture, dependencies, approvals, phase state, shipping targets, memory, or files.

## Audit Types

### Framework Audit

Use `audit framework` when reviewing Software Factory itself.

Check:

- entry docs and required reading path;
- rules, phase docs, standards, commands, and templates;
- roadmap, deferred work, fixes, changelog, and operating queue alignment;
- stale or contradictory guidance;
- missing paired templates or schema coverage;
- validation and secret-scan results;
- Git status when relevant.

Framework audits may produce a conversational report by default. Create a durable plan or report file only when the human asks for one or the findings need to survive beyond the session.

### Project Audit

Use `audit project` when reviewing an active or named project.

Project audits should use `templates/artifacts/AUDIT-001-project-audit.md` and `templates/artifacts/AUDIT-001-project-audit.json` when a durable artifact is useful.

Check:

- project status and checklist alignment;
- current phase and phase gate status;
- required artifacts for the current phase;
- paired Markdown/JSON alignment;
- open questions, human actions, blockers, and unresolved errors;
- deferred items and whether deferral was approved;
- runtime and environment strategy;
- dependency locality and tool-adoption decisions;
- task records, claims, delegations, and handoffs when relevant;
- local event summaries as breadcrumbs, not authority;
- testing, review, shipping, and memory readiness when relevant.

## Local Runner Checks

Use the repo-local runner as evidence, not as the audit authority.

Recommended framework checks:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 doctor
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 secret-scan
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 tasks
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 events
```

Recommended project checks:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 status -Project <slug>
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 secret-scan
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 tasks -Project <slug>
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 events -Project <slug>
```

Do not add an `audit` runner command until the manual workflow shows repeated value and the human approves automation. A future audit command should remain read-only unless a separate decision explicitly changes that boundary.

## Findings

Order findings by severity:

- `high`: blocks phase movement, shipping, security, privacy, data integrity, or human approval.
- `medium`: likely to create confusion, rework, drift, or verification gaps.
- `low`: cleanup, wording, consistency, or future-quality issue.

Every finding should include:

- what was observed;
- why it matters;
- file or artifact evidence;
- recommended next action;
- whether human approval is needed.

## Status Values

Use these audit statuses:

- `healthy`: no important issues found.
- `needs-attention`: issues exist, but work can continue with clear next actions.
- `blocked`: a required decision, error fix, human action, or missing artifact prevents safe progress.
- `risky`: work can technically continue, but risk is high enough that Codex should recommend fixing or explicitly deferring it first.

## Boundaries

Codex may fix obvious clerical drift during an audit when the existing decision is clear.

Codex must ask before:

- changing project-shaping facts;
- changing approval or phase-gate state;
- deleting, merging, archiving, or removing guidance;
- adding dependencies or tools;
- changing deployment, shipping, privacy, security, or memory behavior;
- turning an audit finding into approved scope.

When multiple findings matter, Codex should recommend the smallest useful fix first and ask the human what to handle.
