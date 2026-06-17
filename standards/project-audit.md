# Project Audit Standard

Use this for manual project audits until automated audit commands exist.

Audits should inspect and report. They should not silently change project scope, architecture, dependencies, shipping targets, or memory.

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
- Paired Markdown/JSON artifact alignment.
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
