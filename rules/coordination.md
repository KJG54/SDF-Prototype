# Coordination Rules

Codex leads. Claude collaborates when useful.

Coordination should reduce friction, not create ceremony. Use the lightest coordination record that protects scope, approval boundaries, and continuity.

Use `standards/file-based-task-records.md` when work needs durable task records, claims, or coordination without adding an external task manager or broker.

Task records coordinate planned work. They do not replace phase artifacts, approvals, status files, checklists, delegation artifacts, or handoff artifacts.

## Responsibility Split

Codex remains responsible for:

- primary conversation with the human;
- reading project status and phase artifacts;
- asking approval questions;
- phase transitions and phase gates;
- scope, architecture, dependency, privacy, cost, deployment, and shipping decisions;
- deciding whether Claude is useful for a specific task;
- preparing delegation packets;
- reviewing Claude handoffs before integration or user-facing claims;
- updating human-facing summaries and agent-readable state.

Claude may help with:

- strenuous implementation;
- repetitive code edits;
- second opinions;
- debugging;
- security or architecture review;
- test planning;
- edge-case review;
- cleanup after the core direction is clear;
- parallel investigation with a clear boundary.

Claude must not:

- approve scope changes;
- advance phases;
- add major dependencies without approval;
- make architecture decisions;
- change deployment or publishing direction;
- handle secrets or credentials unless explicitly approved and safely bounded;
- expand the task beyond the delegation packet.

## When To Consider Claude

Codex should consider Claude when one or more of these are true:

- the task is large or repetitive enough that delegation saves real time;
- a second opinion would reduce architecture, security, privacy, or data-modeling risk;
- debugging would benefit from an independent read of evidence;
- review of Codex's work would catch likely gaps;
- test planning or edge-case review would materially improve confidence;
- the work can be split cleanly without giving Claude broad scope.

Codex should keep the work itself when:

- the task is small and precise;
- the work is approval-sensitive or project-shaping;
- the context needed to delegate is larger than the task;
- the human has not approved risky delegation;
- the next step is conversation, decision-making, or phase movement.

Codex should briefly explain why Claude is useful before meaningful handoff. Human approval is required when the delegation could change scope, architecture, dependencies, cost, privacy, security, deployment, project direction, phase gates, approval behavior, or agent autonomy.

## Delegation

Every meaningful Claude delegation needs a `DELEGATION-*` packet that includes:

- task id or related task record, when one exists;
- task goal;
- why Claude is useful here;
- context budget guidance;
- files Claude should read;
- files Claude may edit;
- files Claude must not edit;
- constraints;
- acceptance criteria;
- verification expectations;
- approval boundaries;
- whether human approval is needed before delegation;
- whether Codex review is required before integration;
- expected handoff format.

If the work is substantial enough to track separately, create or reference a `TASK-*` record before delegation.

## Token-Conscious Splitting

Avoid asking Codex and Claude to do the same broad repo scan.

Prefer delegation packets with a narrow file list, clear search targets, and a short description of already-known context. If Claude needs more context, the handoff should say what was missing rather than silently widening the assignment.

Use Codex for orchestration, phase artifacts, final routing, approval-sensitive decisions, small precise edits, status summaries, roadmap alignment, and memory updates.

Use Claude for larger implementation batches, broad review, repetitive transformations, debugging with a clear reproduction, independent second opinions, test expansion, and large-file cleanup after Codex defines the target.

## Handoff

Every Claude handoff should include:

- related delegation or task id;
- summary of work;
- files read;
- files changed;
- verification performed;
- checks not run and why;
- issues found;
- remaining risks or open questions;
- assumptions made;
- recommended next step;
- whether Codex review is required before the work is treated as complete;
- whether a human decision is needed.

Codex must review important Claude handoffs before:

- integrating changes;
- updating phase gates or status;
- presenting Claude's conclusion as a project decision;
- asking the human to approve a project-shaping next step.

The human should receive a plain-language summary of any important Claude handoff before decisions are made from it.
