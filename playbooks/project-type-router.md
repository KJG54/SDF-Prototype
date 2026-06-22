# Project Type Router

Use this before normal Phase 0 Startup when the human starts a new project with `start a new project`, `/start`, or similar wording.

The router chooses the first playbook to read. It does not replace the universal Software Factory phases, approval gates, startup artifacts, architecture phase, tool adoption checks, or human-action files.

## Route Choices

| User Choice | Project Type Value | Primary Playbook | Secondary Playbooks To Consider |
| --- | --- | --- | --- |
| App or web app | `app` | `playbooks/app.md` | `website`, `desktop`, `data-dashboard`, `ai-system` |
| Website, landing page, portfolio, docs site | `website` | `playbooks/website.md` | `app` |
| Game or interactive simulation | `game` | `playbooks/game.md` | `desktop`, `website`, `ai-system` |
| CLI, script, local tool, developer tool | `cli-tool` | `playbooks/cli-tool.md` | `automation`, `library` |
| Automation or workflow | `automation` | `playbooks/automation.md` | `cli-tool`, `ai-system` |
| AI product, agent, prompt workflow, retrieval system | `ai-system` | `playbooks/ai-system.md` | `app`, `automation`, `data-dashboard` |
| Data dashboard, report, scorecard, monitoring view | `data-dashboard` | `playbooks/data-dashboard.md` | `app`, `ai-system` |
| Browser extension | `browser-extension` | `playbooks/browser-extension.md` | `app`, `automation` |
| Library, package, SDK, reusable module | `library` | `playbooks/library.md` | `cli-tool` |
| New feature in an existing project | `existing-project-feature` | `playbooks/app.md` when user-facing, otherwise `playbooks/generic.md` | existing project stack and domain playbooks |
| Codex skill, slash command, framework workflow | `software-factory-workflow` | `playbooks/software-factory-workflow.md` | `generic`, `automation` |
| Unsure or mixed project | `generic` | `playbooks/generic.md` | route after interview |

## Routing Questions

Ask only enough to pick a safe first route:

- What kind of thing are you building?
- Where should the finished thing run?
- Is this a new standalone project, a feature in an existing project, or a Software Factory framework/skill/command change?
- Does it need a visual interface, gameplay, automation, AI, data analysis, reusable package behavior, browser integration, or device-specific runtime?

## Recording

Record the route in `STARTUP-001` as `project_type_routing`:

- `selected_project_type`
- `selected_playbook`
- `secondary_playbooks`
- `route_reason`
- `routing_confidence`
- `open_routing_questions`

Reflect the selected route in `OPERATING-001` so later agents know which playbook shaped Startup.
