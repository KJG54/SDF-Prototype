# Planned Commands

Commands are documented for v1 and may be automated later through the `factory` CLI or slash commands.

## Commands

- `/start`: create or continue the new-project startup checklist
- `/vision`: start or continue the Vision Interview
- `/requirements`: create or revise requirements
- `/architecture`: choose or revise stack and architecture
- `/plan`: create or revise the build plan
- `/scaffold`: create approved project structure
- `/build`: implement approved tasks
- `/test`: run testing and verification
- `/uat`: record user acceptance testing notes
- `/review`: compare result against intent
- `/ship`: package or publish the project
- `/memory`: record lessons learned, reusable patterns, known problems, and the final memory packet
- `/gate`: check whether the current phase is ready to close
- `/status`: summarize current project state
- `/audit framework`: inspect Software Factory health
- `/audit project`: inspect active project health and produce `AUDIT-001`
- `/wrap-up`: create a session summary

## Rule

Commands should never bypass approval gates.

Future command automation should fail closed when required artifacts, unresolved errors, human actions, or phase approval are missing.

## Project Checklist Behavior

Each project should have:

- `PROJECT-CHECKLIST.md` for the human.
- `project-checklist.json` for agents and future automation.

Every phase command should update the checklist when it starts, when it creates required artifacts, when it records a human action, when it discovers a blocker, and when the phase gate closes.

`/status` should read the checklist first, then verify important claims against the actual artifacts.

`/gate` should fail closed when the checklist says a phase is incomplete, a required artifact is missing, a blocker is unresolved, or human approval has not been recorded.
