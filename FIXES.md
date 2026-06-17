# Fixes

Use this file to track things that should be fixed in Software Factory or in projects created with it.

## Human Notes

-

## AI Findings

- Consider adding automated checks later to enforce phase gates, paired JSON/Markdown artifact alignment, and unresolved-error blocking.

## Resolved

- Added dedicated Phase 1 vision artifact templates.
- Added Windows command guidance for `npm.cmd` when PowerShell blocks `npm.ps1`.
- Added Git safe-directory guidance for sandbox-created repositories pushed by the human.
- Added desktop shipping guidance that separates GitHub source shipping from installer/package creation.
- Added a new-project startup checklist and `STARTUP-001` templates.
- Added phase-specific question prompts for implementation, testing, review, and shipping.
- Added beginner-safe human instruction fields to phase summaries.
- Added a manual project audit standard and `AUDIT-001` templates.
- Added clearer Claude delegation guidance for later phases.
- Added structured user acceptance testing standard and `UAT-001` templates.
- Added a command-folder rule before terminal commands.
- Added a framework Git / backup plan.
- Aligned phase docs so checklist updates and phase gates are explicit for every phase.
- Ignored local scratchpad idea files so early personal notes stay out of the framework repo.
- Anchored `projects/` ignore rules so `templates/projects/` is not accidentally excluded.

## Findings From Recipe Keeper Dry Run

- Phase 1 needed a reusable vision template. Status: resolved.
- The agent did not ask enough questions in later phases. Status: resolved with phase-specific question prompts for implementation, testing, review, and shipping.
- Phase endings needed a stronger next-step question. Status: resolved in phase summary and phase-gate templates.
- The framework needed a harder rule that agents lead, explain, and humans verify. Status: resolved in `rules/agent-human-interaction.md`.
- Runtime and environment planning needed more structure. Status: resolved in architecture, environment, and runtime standards.
- Dependency locality needed to be explicit. Status: resolved as a default rule; future projects should validate it in practice.
- Human technical instructions needed to be clearer for beginners. Status: resolved in human-action and phase-summary templates.
- Errors should block phase advancement unless explicitly deferred. Status: resolved in phase and error-handling rules.
- GitHub source shipping and installer packaging were blurred together. Status: resolved in ship phase, Git/GitHub standard, and desktop playbook.
- Windows-specific problems needed reusable guidance. Status: resolved in Windows local development standard.
- Workspace folder vs project wrapper folder needed stronger guidance. Status: resolved in Git/GitHub standard and Windows local development standard.
- The first dry run exposed that automated artifact validation will eventually be valuable. Status: deferred.
