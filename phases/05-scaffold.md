# Phase 5: Scaffold

## Purpose

Create the project skeleton and workspace.

## Agent Responsibilities

- Create only the approved structure.
- Keep generated source code in `projects/<slug>/workspace/`.
- Scaffold only approved tools and local files. Do not add deferred or rejected-for-now toolbox items during scaffold unless the human explicitly approved a new decision.
- Include local logs, validation files, task files, or command scripts when they were approved as part of the starter toolbox approach.
- Keep dependency manager caches out of the project wrapper artifact area; place them under `workspace/` or another ignored, validator-safe path.
- For larger or riskier projects, show the proposed structure before creating it.
- Update `PROJECT-CHECKLIST.md` and `project-checklist.json`.
- Summarize what was created.

## Human Responsibilities

- Approve scaffolding when needed.
- Provide missing files, accounts, credentials, or local setup only when required.

## Required Output

- `SCAFFOLD-001-scaffold-notes.json` / `SCAFFOLD-001-scaffold-notes.md`
- Workspace skeleton
- Project status update
- Phase gate
- Phase summary
- Human-action files when needed

## Exit Criteria

The workspace exists and is ready for implementation.

## Closeout Prompt

Summarize the created workspace structure, generated files, approved tools included, setup checks performed, dependency/cache placement, and any missing setup or human actions. Then ask whether the human approves moving to Implementation.
