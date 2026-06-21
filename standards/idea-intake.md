# Idea Intake

Use this standard when the human gives Codex rough ideas, mixed notes, possible projects, future commands, fixes, or workflow suggestions.

Idea intake preserves ideas without turning them into approved scope by accident.

## Core Rule

Raw ideas are context, not commitments.

Before an idea becomes approved project scope, roadmap work, a dependency, automation, or a task, Codex must explain the implication and get human approval.

## Safe Note Files

Use these files for lightweight intake:

| File | Use |
| --- | --- |
| `FRAMEWORK-IDEAS.md` | Raw or proposed improvements to Software Factory itself. |
| `PROJECT-IDEAS.md` | Possible future apps, games, tools, automations, or experiments. |
| `FIXES.md` | Known framework problems, confusing docs, broken commands, validation gaps, or rough edges. |
| `DEFERRED.md` | Useful work that is explicitly not approved for the current cycle. |
| `commands/potential-future-commands.md` | Workflow prompt or future slash-command ideas that are not implemented yet. |

These files may contain rough notes. Codex may organize and clarify them, but should preserve the original intent.

## Status Labels

Use these statuses when triaging:

| Status | Meaning |
| --- | --- |
| raw | Captured but not interpreted deeply. |
| clarified | Meaning is understood, but not approved work. |
| proposed | Recommended for discussion or possible future work. |
| approved | Human approved it as current scope or roadmap direction. |
| deferred | Useful, but intentionally not now. |
| rejected-for-now | Not useful or not appropriate right now. |
| needs-human-decision | Cannot be routed safely without a decision. |

## Default Routing

| Idea Type | Destination |
| --- | --- |
| Framework improvement | `FRAMEWORK-IDEAS.md` |
| Possible future project | `PROJECT-IDEAS.md` |
| Bug or broken workflow | `FIXES.md` |
| Approved framework direction | `ROADMAP.md` |
| Useful but not now | `DEFERRED.md` |
| Future workflow prompt | `commands/potential-future-commands.md` |
| Tool or platform suggestion | `tools/registry.md` only after tool-adoption review |
| Active project feature idea | `projects/<slug>/artifacts/change-requests/` |
| Active project implementation task | `projects/<slug>/artifacts/tasks/` |
| Reusable lesson or preference | private memory proposal after approval |
| Unclear idea | keep in the intake file and ask focused questions |

## Lightweight Triage

When the human says `triage ideas`, Codex should:

1. preserve the raw idea text;
2. group related ideas;
3. assign a status;
4. recommend a destination;
5. identify approval needs;
6. avoid changing roadmap, requirements, architecture, dependencies, or project scope without approval.

When the human says `route this idea`, Codex should classify one idea and recommend where it belongs.

## Approval Boundaries

Human approval is required before:

- moving raw ideas into approved roadmap work;
- adding a project feature to approved scope;
- adopting a tool, dependency, platform, service, or automation;
- changing phase gates, approval behavior, memory behavior, or delegation rules;
- publishing ignored scratchpads or private memory.

Codex may do without special approval:

- clean formatting in safe note files;
- fix encoding damage;
- group loose bullets under clearer headings;
- mark an idea as raw, proposed, deferred, or needs-human-decision;
- recommend next actions for discussion.
