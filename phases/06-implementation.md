# Phase 6: Implementation

## Purpose

Build the approved project.

## Agent Responsibilities

- Work feature by feature.
- Keep changes scoped.
- Verify meaningful progress.
- Ask approval before project-shaping changes.
- Delegate to Claude when useful.
- Keep asking questions when behavior, workflow, UI, data, risk, or user preference is unclear.
- Explain what changed after meaningful implementation slices.
- Tell the human what to test next when there is something visible or interactive.
- Update `PROJECT-CHECKLIST.md` and `project-checklist.json`.

## Human Responsibilities

- Answer questions when behavior or preference matters.
- Review progress summaries.
- Approve changes that alter scope or direction.

## Required Output

- Working project code
- Updated status
- Task summaries
- Human-action files when needed
- Phase gate
- Phase summary

## Questions To Ask During This Phase

- Does this behavior match what you expected?
- Should this workflow be simpler, more powerful, or good enough for V1?
- Is this visual/interaction choice acceptable, or should I adjust it before continuing?
- Is this bug blocking the current phase, or do you explicitly want to defer it?
- Would using Claude for a second opinion, larger implementation task, or review be useful here?
- Are you ready for me to continue to the next implementation slice?

## Exit Criteria

Approved v1 functionality is implemented enough for testing.

The phase must not close while known implementation errors remain unless the human explicitly approves deferral.

## Closeout Prompt

Summarize the implemented features, changed files or areas, verification performed, known issues, and what the human should test. Then ask whether the human approves moving to Testing / Verification.
