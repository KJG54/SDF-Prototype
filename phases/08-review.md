# Phase 8: Review

## Purpose

Confirm the project is what the human meant to build and is ready to ship.

## Agent Responsibilities

- Compare result against requirements.
- Check UX, docs, known issues, and deferred ideas.
- Check whether tool choices still match `standards/tool-adoption.md` and `standards/starter-toolbox.md`.
- Check whether engineering quality matches the approved project purpose, risk, audience, and lifecycle.
- Check security, privacy, credential handling, dependency risk, and deployment surfaces when relevant.
- For Tauri desktop apps, check Rust/Cargo dependencies, frontend dependencies, Tauri permissions/capabilities, webview surfaces, and local-data handling according to `standards/tauri-dependency-audit.md`.
- Recommend ship, revise, or pause.
- Ask whether the project feels like what the human meant to build.
- Surface honest concerns about scope gaps, quality, risk, or shipping readiness.
- Flag unapproved or unnecessary tools as review findings.
- Update `PROJECT-CHECKLIST.md` and `project-checklist.json`.

## Human Responsibilities

- Decide whether the project is satisfactory.
- Choose ship, revise, or pause.

## Required Output

- `REVIEW-001-review-report.json` / `REVIEW-001-review-report.md`
- Acceptance decision
- Known issues / deferred ideas update
- Phase gate
- Phase summary

## Questions To Ask During This Phase

- Does this match the project you wanted to make?
- Is anything important missing from V1?
- Is anything included that should be removed or simplified?
- Are the known issues acceptable for this version?
- Are there security, privacy, credential, dependency, or deployment risks that must be fixed before shipping?
- Should we ship, revise, pause, or continue polishing?
- What shipping path do you prefer next?

## Exit Criteria

The human chooses the next path.

The phase closes only after the human chooses ship, revise, or pause.

## Closeout Prompt

Summarize the review result, requirement match, known issues, deferred ideas, and recommended next path. Then ask whether the human approves moving to Ship, returning to Implementation, or pausing.
