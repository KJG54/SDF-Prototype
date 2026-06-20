# Roadmap

## V1

- Human-readable framework walkthrough
- Agent rules and coordination model
- Phase lifecycle
- Planning templates
- Project workspace structure
- Memory vault structure
- Manual session summaries
- Manual Codex workflow prompt documentation
- Project checklist templates for future command automation
- Script-assisted local checks through `tools/factory.ps1`
- Lightweight artifact validation and secret scanning
- Core JSON Schema contracts for paired Markdown/JSON artifacts
- Framework GitHub publishing with local projects and private memory excluded

## MVP Direction

The confirmed MVP direction is script-assisted and local-first.

Software Factory should remain usable as plain Markdown, JSON, templates, and conversation with Codex, while keeping the lightweight runner, artifact validator, secret scanner, and schemas in scope because they directly protect the phase workflow from drift. The MVP should not require cloud services, databases, external task managers, vector search, release automation, or long-running infrastructure.

## Next Recommended Work

1. Define a cleanup workflow for redundant, stale, ignored, or generated files before deleting anything.
2. Use the new operating-tier model in the next real project and tighten it based on what feels useful or too heavy.
3. Implement the [Idea Intake And Agent Coordination Plan](plans/idea-intake-and-agent-coordination.md) so raw ideas can be routed safely and Codex / Claude Code collaboration has a concrete workflow.
4. Add a project audit command that runs validation, secret scan, task/event summaries, and status/checklist drift checks.
5. Go through every phase, one by one and make sure they are efficient and optimized.

## Recently Completed

- Designed Codex workflow prompt contracts for startup, project status, gate, audit, wrap-up, and one workflow per phase.
- Defined minimum checklist state transitions for future command automation.
- Added manual Markdown/JSON artifact validation guidance.
- Chose plain-language Codex workflow prompts as the primary command direction.
- Confirmed current Codex does not expose these as actual project-local slash commands.
- Tightened credential guidance and Review/Gate security checks after external review.
- Added lightweight artifact validation and wired it into the tracked pre-commit hook.
- Verified Recipe Keeper dependency reproducibility with a project-local npm cache, clean npm install, locked Cargo metadata, locked Cargo check, and debug desktop build.
- Added lightweight project rigor levels and known-good stack profiles so architecture choices can become faster and more consistent without adding heavy automation.
- Added a tool adoption standard and starter toolbox decision to prevent tool sprawl before adding new dependencies.
- Added core JSON Schema contracts and wired them into artifact validation for project status, project checklists, phase gates, phase summaries, and base artifact shape.
- Connected the starter toolbox policy to agent entry instructions, tool-use rules, phase workflows, command contracts, validation docs, and the machine-readable tool registry.
- Added the first repo-local command runner at `tools/factory.ps1` for safe checks and read-only framework/project views.
- Added a local logs/events standard, JSON Schema contract, ignored log paths, and runner support for appending/viewing JSONL events.
- Added file-based task record conventions, schema, template, validation wiring, and runner support for listing tasks.
- Expanded JSON Schema coverage to human actions, approvals, requirements, architecture, environment setup, build plans, scaffold notes, implementation notes, verification reports, review reports, shipping plans, and memory packets.
- Added Rust/Tauri dependency audit guidance and connected it to the Tauri stack profile, architecture, review, ship, and security docs.
- Tested stack profiles, rigor levels, starter toolbox policy, local runner commands, local events, task records, expanded schemas, and Tauri audit guidance with the local-only `toolbox-smoke-test` project.
- Cleaned up legacy Recipe Keeper wrapper artifact-validation warnings while keeping the project marked as a historical legacy reference.
- Added lightweight semantic artifact checks for project state references, status/checklist identity drift, active phase alignment, and phase gate approval consistency.
- Confirmed the MVP direction as script-assisted, local-first, and intentionally free of heavyweight infrastructure.
- Added project operating tiers and `OPERATING-001` so Phase 0 can scale agent effort before each project.

## Later

- Native Codex command registration when supported
- `factory` CLI if a terminal workflow becomes useful later
- Automatic checklist updates after each phase command
- Optional Docker Compose templates for projects that need local services
- Optional Chroma indexing after targeted retrieval pain is proven
- Full phase-gate enforcement
- Tool registry expansion and lifecycle checks
- Project audit command
- Framework audit command
- Cleanup workflow prompt or runner view for identifying redundant files
- Automated model routing
- GUI for nontechnical users
- GitHub creation and release automation
- Reusable code templates discovered through real projects
