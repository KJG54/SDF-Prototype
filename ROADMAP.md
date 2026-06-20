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

1. Add Rust/Tauri dependency audit guidance for desktop apps.
2. Test stack profiles and rigor levels with another small project.
3. Decide whether to run `cargo audit` locally for Recipe Keeper or record it as a human action.
4. Clean up legacy Recipe Keeper wrapper artifact-validation warnings.

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

## Later

- Native Codex command registration when supported
- `factory` CLI if a terminal workflow becomes useful later
- Automatic checklist updates after each phase command
- Deeper semantic artifact validation
- Full phase-gate enforcement
- Chroma or equivalent memory indexing
- Tool registry expansion and lifecycle checks
- Project audit command
- Framework audit command
- Automated model routing
- GUI for nontechnical users
- GitHub creation and release automation
- Reusable code templates discovered through real projects
