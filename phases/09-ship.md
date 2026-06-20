# Phase 9: Ship

## Purpose

Package and prepare the project for other people to use.

## Agent Responsibilities

- Confirm the shipping target.
- Make the project GitHub-ready by default.
- Distinguish source-code shipping, installer/package shipping, hosted deployment, and store/publication.
- Prepare README, setup instructions, dependency notes, known issues, and release notes.
- Confirm that documentation, verification, security review, and operational notes fit the chosen shipping target.
- Confirm that approved tools, local commands, validation checks, and required system prerequisites are documented for the shipping target.
- For Tauri desktop apps, confirm the dependency audit, permission/capability review, lockfile checks, and packaging exclusions required by `standards/tauri-dependency-audit.md`.
- If installer/package creation is not part of the chosen shipping target, document it as deferred instead of treating it as a blocker.
- Ask approval before publishing, pushing, deploying, or creating external resources.
- Give beginner-safe instructions for any human-run GitHub, deployment, packaging, or terminal steps.
- Confirm secrets, tokens, local env files, and generated artifacts are not being shipped accidentally.
- Update `PROJECT-CHECKLIST.md` and `project-checklist.json`.

## Human Responsibilities

- Choose shipping target.
- Approve external release actions.

## Required Output

- `SHIP-001-shipping-plan.json` / `SHIP-001-shipping-plan.md`
- Ship summary
- Release notes
- GitHub-ready workspace
- Human-action files when needed
- Phase gate
- Phase summary

## Questions To Ask During This Phase

- Who needs to use this after shipping?
- Is GitHub source upload enough, or do you also need an installer/package/deployment?
- Should this be public, private, local-only, or shared with specific people?
- Are there secrets, private notes, test data, or local files that must not be included?
- Do you want the agent to prepare commands for you to run, or should the agent do the approved action when possible?
- Are you satisfied with the shipped result and ready to move to Memory / Lessons Learned?

## Exit Criteria

The project is packaged, documented, and ready for the chosen shipping path.

GitHub-ready source shipping can be complete without an installer if the human approves that shipping target.

## Closeout Prompt

Summarize the chosen shipping path, what was prepared, what the human did or still needs to do, known shipping limitations, and where the shipped project lives. Then ask whether the human approves moving to Memory / Lessons Learned.
