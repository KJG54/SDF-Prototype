# Codex Workflow Prompts

Commands are documented for v1 as Codex-facing workflow prompts. They are not registered Codex slash commands yet and will not appear in the Codex command picker. Use the plain-language phrases below in conversation.

These prompts may be automated later through native Codex-style commands if Codex exposes project-local command registration. A separate `factory` CLI can stay a later option if it proves useful.

See [contracts.md](contracts.md) for the command behavior, checklist state transitions, and fail-closed rules future automation should follow.

Use [../standards/artifact-validation.md](../standards/artifact-validation.md) for manual Markdown/JSON pair checks until validation is automated.

## Prompts

| Say this in Codex | Reserved command name | Purpose |
| --- | --- | --- |
| `start a new project` | `/start` | create or continue the new-project startup checklist |
| `run vision` | `/vision` | start or continue the Vision Interview |
| `run requirements` | `/requirements` | create or revise requirements |
| `run architecture` | `/architecture` | choose or revise stack and architecture |
| `run plan` | `/plan` | create or revise the build plan |
| `run scaffold` | `/scaffold` | create approved project structure |
| `run build` | `/build` | implement approved tasks |
| `run test` | `/test` | run testing and verification |
| `run uat` | `/uat` | record user acceptance testing notes |
| `run review` | `/review` | compare result against intent |
| `run ship` | `/ship` | package or publish the project |
| `run memory` | `/memory` | record lessons learned, reusable patterns, known problems, and the final memory packet |
| `run gate` | `/gate` | check whether the current phase is ready to close |
| `run project status` | `/project-status` | summarize current project state |
| `audit framework` | `/audit framework` | inspect Software Factory health |
| `audit project` | `/audit project` | inspect active project health and produce `AUDIT-001` |
| `wrap up` | `/wrap-up` | create a session summary |

## Rule

Workflow prompts should never bypass approval gates.

Future command automation should fail closed when required artifacts, unresolved errors, human actions, or phase approval are missing.

## Project Checklist Behavior

Each project should have:

- `PROJECT-CHECKLIST.md` for the human.
- `project-checklist.json` for agents and future automation.

Every phase command should update the checklist when it starts, when it creates required artifacts, when it records a human action, when it discovers a blocker, and when the phase gate closes.

`run project status` should read the checklist first, then verify important claims against the actual artifacts.

`run gate` should fail closed when the checklist says a phase is incomplete, a required artifact is missing, a blocker is unresolved, or human approval has not been recorded.
