# Changelog

## 2026-06-17

- Added repository-boundary guidance for publishing Software Factory without local projects or private memory.
- Added `.env.example` and expanded `.gitignore` to protect local projects, vault data, secrets, dependencies, build outputs, and local databases.
- Added project checklist templates for human progress tracking and future slash-command automation.
- Updated command and project-structure rules so every phase can update checklist state.
- Aligned phase docs so every phase explicitly updates checklist files and produces a phase gate.
- Ignored local scratchpad idea files before the first framework commit.
- Anchored local project ignore rules so framework templates under `templates/projects/` remain tracked.
- Added new-project startup checklist and `STARTUP-001` templates.
- Added phase-specific question prompts for implementation, testing, review, and shipping.
- Added beginner-safe human instruction fields to phase summaries.
- Added manual project audit standard and `AUDIT-001` templates.
- Added structured user acceptance testing standard and `UAT-001` templates.
- Added stronger Claude delegation guidance.
- Added framework Git / backup planning guidance.
- Updated project artifact folder layout based on the Recipe Keeper dry run.
- Added Phase 1 vision artifact templates.
- Added stronger environment/runtime planning standards.
- Added Windows local development guidance.
- Tightened GitHub workspace and safe-directory guidance.
- Clarified that desktop source shipping and installer packaging are separate shipping targets.

## 2026-06-16

- Created v1 Software Factory skeleton.
- Added core human and agent entry docs.
- Added phase, rule, template, memory, command, standard, and tool folders.
