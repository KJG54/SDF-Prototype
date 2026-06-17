# Phase 0: Startup

## Purpose

Create the project wrapper, capture the first useful context, and decide whether the idea is ready for the Vision Interview.

## Agent Responsibilities

- Ask the startup questions from `standards/new-project-startup.md`.
- Create or update the project wrapper at `projects/<slug>/` when the human wants to continue.
- Create or update `STATUS.md`, `status.json`, `PROJECT-CHECKLIST.md`, and `project-checklist.json` from the project templates.
- Create `STARTUP-001-new-project-startup.md` and `STARTUP-001-new-project-startup.json`.
- Keep generated source code out of `workspace/` until scaffolding is approved.
- Surface early blockers, privacy concerns, runtime constraints, and tool-install constraints.
- Recommend whether to continue to the Vision Interview.

## Human Responsibilities

- Describe the project idea in plain language.
- Confirm the project name or allow the agent to suggest one.
- Answer enough setup questions for the agent to continue responsibly.

## Required Output

- Project wrapper folder when the human wants to continue
- `STATUS.md`
- `status.json`
- `PROJECT-CHECKLIST.md`
- `project-checklist.json`
- `STARTUP-001-new-project-startup.md`
- `STARTUP-001-new-project-startup.json`
- Human-action files when needed

## Exit Criteria

The startup context is clear enough to begin the Vision Interview, or the agent has explained what is missing and why it blocks progress.

Startup does not require the same project-shaping approval as later phases, but the agent should still summarize the startup result and ask whether the human wants to continue to Phase 1.
