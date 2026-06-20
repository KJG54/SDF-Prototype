# Project Structure Rules

Framework files, project artifacts, and generated project source code must stay clearly separated.

## Project Layout

```text
projects/<slug>/
  STATUS.md
  status.json
  PROJECT-CHECKLIST.md
  project-checklist.json
  artifacts/
    startup/
    vision/
    requirements/
    architecture/
    environment/
    plans/
    approvals/
    human-actions/
    phase-gates/
    phase-summaries/
    tasks/
    testing/
    review/
    shipping/
    memory/
    reports/
    research/
    change-requests/
    claims/
    delegations/
    handoffs/
    release/
  memory/
  workspace/
```

Generated project workspaces should be GitHub-ready and independent whenever practical.

Human-action artifacts use paired Markdown and JSON files in `artifacts/human-actions/`, for example:

```text
projects/<slug>/artifacts/human-actions/ACTION-001-install-node.md
projects/<slug>/artifacts/human-actions/ACTION-001-install-node.json
```

Framework-level human actions may use the same pattern under `artifacts/human-actions/`.

## Checklist Rule

Every project must maintain both:

- `PROJECT-CHECKLIST.md` for human-readable progress.
- `project-checklist.json` for agent-readable state and future command automation.

The checklist must be updated when a phase starts, when a blocking issue appears, when a human action is created, when a phase gate passes, and when work is deferred with approval.

Codex workflow prompts and future commands must treat the checklist as project state, not as a substitute for the actual phase artifacts.
