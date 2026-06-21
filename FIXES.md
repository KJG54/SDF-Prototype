# Fixes

Use this file to track things that should be fixed in Software Factory or in projects created with it.

## Human Notes

-

## AI Findings

- Add deeper semantic checks later to enforce phase gates and unresolved-error blocking.
- Document the generated-project nested repository pattern more explicitly, or decide whether generated workspaces should live outside the framework folder.
- Expand the tool registry over time as more stacks are proven through real projects.
- Decide whether `roles/README.md` should remain separate or be merged into the agent role docs.
- Decide whether `commands/potential-future-commands.md` should remain separate or be folded into roadmap/idea intake.
- Consider adding a dedicated `STARTUP-001` JSON Schema if startup artifact drift appears in future dry runs.

## Resolved

- Cleared stale active-project state from `factory.config.json`.
- Added a formal Startup phase doc.
- Added named later-phase artifact templates for scaffold, implementation, verification, review, and ship.
- Aligned project checklist Markdown and JSON required artifacts.
- Updated the roadmap after GitHub publication and scratchpad decisions.
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
- Defined a safe cleanup workflow before deleting ignored local files, private memory, generated project output, or placeholder folder notes.
- Proved Phase 0 with a local grocery-list dry run that created startup and operating artifacts without scaffolding source code.

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
- External review found that documented safety gates are still advisory until enforcement tooling exists. Status: deferred for automation, partially mitigated by clearer docs and stronger templates.
- External review found that the Recipe Keeper example skipped security review details. Status: resolved with review template updates and Recipe Keeper review artifact notes.
- External review found that paired artifact validation was manual only. Status: partially resolved with `tools/artifact-validate.ps1`; deeper semantic checks remain deferred.
- Verified dependency reproducibility for the Recipe Keeper generated project with `npm.cmd ci`, `npm.cmd run build`, `cargo metadata --locked --format-version 1`, `cargo check --locked`, and `npm.cmd run build:desktop:debug`. Broader generated-project guidance can still be expanded as new stacks appear.
- Added project rigor levels and stack profiles so future projects can start from known-good defaults without committing to heavy templates or automation.
- Added Rust/Tauri audit guidance and connected it to desktop architecture, review, ship, security, stack-profile, and registry docs.
- Cleaned up legacy Recipe Keeper wrapper artifact-validation warnings so the dry-run project matches the newer artifact rules.
- Confirmed the framework MVP direction as script-assisted and local-first.
