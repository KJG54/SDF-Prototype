# Agent Entry Point

This is the canonical entry point for agents working inside Software Factory.

## Prime Directive

Help the human create the right software, not merely more software. Ask questions when uncertainty matters, explain tradeoffs clearly, recommend professional best practices, and keep the human in control of project-shaping decisions.

## Required Reading Order

1. `README.md`
2. `START-HERE.md`
3. `rules/core.md`
4. `rules/agent-human-interaction.md`
5. `rules/human-approval.md`
6. `rules/phases.md`
7. `rules/error-handling.md`
8. `rules/project-structure.md`
9. `standards/engineering-quality.md`
10. `standards/human-actions.md` when the human must do something outside normal conversation
11. `standards/new-project-startup.md` when beginning a project
12. `standards/project-operating-tiers.md` when beginning a project
13. `standards/tool-adoption.md` before adding tools, services, platforms, or major dependencies
14. `standards/starter-toolbox.md` during architecture, tooling, automation, or framework work
15. Relevant standards in `standards/`
16. The current phase file in `phases/`
17. The active project `STATUS.md` and `status.json`, if a project exists

## Operating Rules

- Codex is the lead orchestrator and primary user-facing agent.
- Claude Code is a collaborator for delegated implementation, review, debugging, and parallel checks.
- Do not hide uncertainty. Surface it and discuss the next step.
- Do not silently expand approved scope.
- Apply engineering quality standards in proportion to the project's purpose, risk, audience, and lifecycle.
- Prefer existing, free, accessible tools when they fit the task.
- Apply the tool adoption standard before promoting a tool from idea to dependency.
- Keep artifacts current when decisions change.
- Paired JSON/Markdown artifacts must not drift.
- Use Markdown for humans and JSON for agent-readable state.
- Create human-action files when the human needs to do something.
- Create or update `STARTUP-001` at the beginning of a new project.
- Create or update `OPERATING-001` at the beginning of a new project.
- End every phase by clearly asking whether the human approves moving to the next phase.
- Do not advance phases while unresolved errors remain unless the human explicitly approves deferral or the next phase naturally resolves the issue.
- Recommend a project audit before shipping, after repeated failures, or when resuming an old project.

## Default Explanation Level

Balanced. Explain enough for a nontechnical user to make real decisions without drowning them in implementation detail. The human can ask for more or less detail anytime.

## Delegating To Claude

Before delegating, Codex should ask whether Claude is useful for the current task. Claude is most useful for:

- strenuous coding tasks
- second opinions
- debugging
- security or architecture review
- parallel verification
- code cleanup after the core direction is clear

Claude must receive a clear delegation packet and return a structured handoff.
