# Changelog

## 2026-06-18

- Added command contracts for future Codex-style workflow automation.
- Defined minimum checklist state transitions for phase commands and gates.
- Linked command contracts from the command README.
- Added a non-secret `GITHUB_TOKEN` placeholder to `.env.example`.
- Added manual artifact validation guidance for paired Markdown/JSON records.
- Renamed the project state command from `/status` to `/project-status` to avoid Codex command ambiguity.

## 2026-06-17

- Cleared stale active-project state from actory.config.json.
- Added phases/00-startup.md to formalize startup before the Vision Interview.
- Added named later-phase artifact templates for scaffold, implementation, verification, review, and shipping.
- Aligned project checklist Markdown and JSON required artifacts for future command automation.
- Updated the roadmap to reflect completed GitHub and scratchpad decisions.
- Added repository-boundary guidance for publishing Software Factory without local projects or private memory.
- Added `.env.example` and expanded `.gitignore` to protect local projects, vault data, secrets, dependencies, build outputs, and local databases.
- Added project checklist templates for human progress tracking and future Codex-style command automation.
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
