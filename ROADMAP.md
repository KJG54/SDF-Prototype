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
- Framework GitHub publishing with local projects and private memory excluded

## Next Recommended Work

1. Enable the tracked pre-commit hook locally with `git config core.hooksPath .githooks`.
2. Verify dependency reproducibility for generated projects.
3. Add Rust/Tauri dependency audit guidance for desktop apps.
4. Test the tightened process with another small project.

## Recently Completed

- Designed Codex workflow prompt contracts for startup, project status, gate, audit, wrap-up, and one workflow per phase.
- Defined minimum checklist state transitions for future command automation.
- Added manual Markdown/JSON artifact validation guidance.
- Chose plain-language Codex workflow prompts as the primary command direction.
- Confirmed current Codex does not expose these as actual project-local slash commands.
- Tightened credential guidance and Review/Gate security checks after external review.
- Added lightweight artifact validation and wired it into the tracked pre-commit hook.

## Later

- Native Codex command registration when supported
- `factory` CLI if a terminal workflow becomes useful later
- Automatic checklist updates after each phase command
- Deeper semantic artifact validation
- Full phase-gate enforcement
- Chroma or equivalent memory indexing
- Tool registry checks
- Project audit command
- Framework audit command
- Automated model routing
- GUI for nontechnical users
- GitHub creation and release automation
- Reusable code templates discovered through real projects
