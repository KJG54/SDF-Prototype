---
name: sf-start
description: Start a new Software Factory project by routing the user's idea to the right project-type playbook before normal Startup. Use when the user says "start a new project", "/start", "start new project", wants to begin any app, website, game, tool, automation, AI system, dashboard, browser extension, library, Codex skill, framework workflow, or is unsure what kind of project they are starting.
---

# SF Start

## Overview

Route a new project idea through Software Factory's project-type router, then continue the standard Phase 0 Startup workflow. Treat `/start` as a documented reserved command name, not proof of native project-local slash command support.

## Required Reading

Read these files from the active Software Factory repo before creating or updating project artifacts:

- `AGENTS.md`
- `START-HERE.md`
- `commands/contracts.md`
- `standards/new-project-startup.md`
- `standards/project-operating-tiers.md`
- `standards/project-rigor-levels.md`
- `playbooks/project-type-router.md`

After choosing a route, read the selected primary playbook and any secondary playbooks named by the router.

## Workflow

1. Confirm whether the user is starting a new project, starting a new feature in an existing project, or creating/updating Software Factory itself.
2. Ask for the project type if it is not already clear. Offer the first-pass route choices from `playbooks/project-type-router.md`.
3. Select one primary playbook and zero or more secondary playbooks. If confidence is low, use `generic` as the primary playbook and record the uncertainty.
4. Continue normal Phase 0 Startup using `phases/00-startup.md` and `standards/new-project-startup.md`.
5. Record routing state in `STARTUP-001` under `project_type_routing`.
6. Reflect the selected route and playbook in `OPERATING-001`.
7. Create human-action files when the human must install tools, authenticate, run commands, manually install this skill, or complete external setup.
8. End Startup by summarizing the route, startup context, operating tier, rigor level, open questions, and asking whether the human wants to continue to Phase 1.

## Routing Rules

- Do not skip normal Software Factory approval gates.
- Do not treat the route as a final tech-stack decision. Architecture still happens in Phase 3.
- Prefer the user's stated target platform over broad category guesses.
- Use secondary playbooks when a project spans categories, such as a game with AI features or a desktop app with local SQLite.
- Keep Phase 0 lean for Tier 3 or Tier 4 projects, but do not omit safety, privacy, tool-install, or approval questions when relevant.
- If the request is to build a Codex skill, command, or framework workflow, route it as `software-factory-workflow` and use the generic playbook plus skill-creation guidance when available.

## Startup Artifact Routing Fields

Populate these fields in `STARTUP-001`:

- `selected_project_type`
- `selected_playbook`
- `secondary_playbooks`
- `route_reason`
- `routing_confidence`
- `open_routing_questions`

If a field is unknown, record an empty string or empty array in JSON and explain the open question in Markdown.
