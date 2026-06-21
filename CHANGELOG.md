# Changelog

## 2026-06-21

- Completed the Phase Efficiency Review and recorded findings in `plans/phase-efficiency-review-2026-06-21.md`.
- Tightened Phase 1 so Vision confirms or updates Startup environment context instead of re-asking it from scratch.
- Added tier-aware right-sizing language to Architecture and Build Plan so lean projects can stay compact without skipping safety checks.
- Added a Scaffold closeout prompt before moving to Implementation.
- Clarified that Codex asks whether Claude is useful before delegating implementation, debugging, review, or parallel checks.
- Clarified that Review depth follows the approved project rigor level and operating tier.
- Strengthened Memory / Lessons Learned closeout expectations with the named memory packet artifact, final status/checklist update, and project closure prompt.
- Advanced the operating queue to validating the updated phases on the next real project or focused proof run.
- Validated the updated Architecture and Build Plan phase wording against `toolbox-smoke-test`, including artifact validation, task listing, local events, and pending gate behavior.
- Advanced the operating queue to validate Scaffold and Memory closeout behavior when a future project reaches those phases.
- Approved using `memory/vault/` as an Obsidian-friendly working knowledge base and added private vault conventions, frontmatter guidance, note templates, and a framework decision memory note.
- Created the local ignored `scaffold-memory-proof` project to validate Scaffold through Memory closeout behavior with a tiny no-dependency static workspace.
- Recorded Scaffold to Memory proof findings and advanced the operating queue to choosing the next framework focus.
- Tightened the phase gate schema so security/privacy checks are required and gate/approval status values are schema-constrained.
- Created the local ignored `dependency-scaffold-proof` project to validate npm/Vite dependency scaffolding, install, build, and validation behavior; human approved closing the proof gate.
- Added framework guidance from the dependency scaffold proof for Windows npm use and package-manager cache placement.

## 2026-06-20

- Closed the Portfolio workflow state and normalized gate/status wording for the completed project wrapper.
- Reviewed the added SDF toolbox discussion and chose a conservative starter-toolbox path instead of adding heavier infrastructure by default.
- Confirmed the Software Factory MVP direction as script-assisted and local-first, with lightweight runner, validation, schema, and secret-scan support in scope.
- Updated roadmap, deferred work, and fixes notes so implemented validation/Tauri guidance are no longer listed as wholly deferred.
- Added project operating tiers and `OPERATING-001` startup templates so each project can choose a full, standard, lean, or fast-MVP operating model before deeper phases begin.
- Added a rolling operating queue for the next Software Factory work cycle, replacing the unapproved day/week/month draft.
- Added a cleanup workflow standard for classifying keep, update, merge, archive, delete, and private cleanup candidates before any destructive action.
- Added the first cleanup review and advanced the operating queue to human-approved cleanup action selection.
- Selectively kept helpful ignored `Explanation.md` notes and removed boilerplate ignored explanation notes.
- Added lightweight idea intake guidance, documented `triage ideas` and `route this idea`, and cleaned private idea scratchpad formatting without approving new scope.
- Proved Phase 0 with a local grocery-list dry run and recorded findings without scaffolding source code.
- Stopped the Phase 0 proof after Startup by human approval and marked the local proof wrapper completed.
- Strengthened Codex / Claude coordination rules, delegation and handoff templates, Claude entry guidance, and workflow prompts for bounded collaboration.
- Added a manual audit workflow, expanded project audit templates, and clarified that audits use runner output as evidence without approving phase gates or changing scope.
- Added tool adoption and starter toolbox standards, then connected them through the README, roadmap, phase docs, command docs, tool-use rules, and tool registry.
- Added core JSON Schema contracts and expanded schema coverage across project state, checklists, phase artifacts, approvals, human actions, requirements, architecture, environment setup, build plans, scaffold notes, implementation notes, verification, review, shipping, task records, local events, and memory packets.
- Wired expanded schema validation into `tools/artifact-validate.ps1`.
- Added the repo-local runner `tools/factory.ps1` for safe checks and read-only framework/project views.
- Documented the local runner in `commands/local-runner.md`.
- Added local JSONL event log guidance, ignored log paths, event schema, and runner support for appending/viewing events.
- Added file-based task record guidance, schema, templates, and runner support for listing tasks.
- Added Rust/Tauri dependency audit guidance and linked it from stack profiles, architecture, review, ship, security, README, roadmap, and registry docs.
- Created a local ignored `toolbox-smoke-test` project to validate stack profiles, rigor levels, starter toolbox policy, local runner commands, local events, task records, schemas, and Tauri audit guidance.
- Cleaned legacy Recipe Keeper wrapper validation warnings while preserving it as a historical legacy reference.
- Added semantic artifact checks for project state references, status/checklist identity drift, active phase alignment, phase-gate approval consistency, and blocking gate conditions.
- Updated artifact validation guidance and roadmap status to reflect the new semantic checks.
- Added a session summary for the toolbox/framework hardening work after the initial wrap-up missed the memory/changelog step.

## 2026-06-18

- Added command contracts for future Codex-style workflow automation.
- Defined minimum checklist state transitions for phase commands and gates.
- Linked command contracts from the command README.
- Added a non-secret `GITHUB_TOKEN` placeholder to `.env.example`.
- Added manual artifact validation guidance for paired Markdown/JSON records.
- Renamed the project state command from `/status` to `/project-status` to avoid Codex command ambiguity.
- Clarified that Software Factory workflows are plain-language Codex prompts today, not registered slash commands.
- Tightened credential guidance away from long-lived GitHub tokens in `.env`.
- Added security/privacy checks to Review and Gate templates.
- Added a lightweight PowerShell secret scanner and tracked pre-commit hook template.
- Added a lightweight PowerShell artifact validator and wired it into the tracked pre-commit hook.

## 2026-06-17

- Cleared stale active-project state from `factory.config.json`.
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
