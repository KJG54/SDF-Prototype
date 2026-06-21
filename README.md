# Software Factory

Software Factory is a human-led, multi-agent framework for creating apps, games, tools, automations, and software projects from idea to shipped result.

The framework is designed around a simple belief: agents should make technical work easier without taking important decisions away from the human. Codex leads the process, asks questions, explains tradeoffs, coordinates tools and collaborators, and keeps the project moving through clear phases.

## What You Get

- A phase-by-phase process for turning an idea into a working project.
- Human-facing Markdown files that explain decisions in plain language.
- Machine-readable JSON files that agents can use for accurate handoffs.
- Approval gates so agents do not silently change the direction of a project.
- Local project folders that stay separate from the framework itself.
- A memory vault for session summaries, lessons learned, reusable patterns, and known problems.
- Planned Codex workflow prompts that can later become native commands when Codex supports project-local command registration.

## Start Here

Read [START-HERE.md](START-HERE.md) first. It explains how a human and agent should use the framework together.

Agents should read [AGENTS.md](AGENTS.md) before doing framework work. Claude Code should also read [CLAUDE.md](CLAUDE.md).

## Download From GitHub

When this framework is published to GitHub, a new user should be able to start like this:

```powershell
git clone <software-factory-repo-url>
cd "Software Factory"
```

If the user downloads a ZIP instead, they should extract it, open the `Software Factory` folder in VS Code, and start with [START-HERE.md](START-HERE.md).

## Local Setup

Software Factory v1 is mostly documentation, templates, and project structure. It does not require a global install to use manually.

Recommended local setup:

- VS Code as the primary editor.
- Git for source control.
- A terminal the user is comfortable with.
- Provider-specific API keys only when a project or future automation actually needs them.
- GitHub authentication through `gh auth login` or Git Credential Manager, not long-lived tokens in `.env`.
- Optional pre-commit secret scanning with `tools/secret-scan.ps1`.
- Optional artifact validation with `tools/artifact-validate.ps1`.
- Optional local command runner with `tools/factory.ps1` for safe checks and read-only status views.
- Optional local JSONL events under ignored `logs/` paths for troubleshooting breadcrumbs.
- File-based task records for coordination without external task managers or brokers.

Copy [.env.example](.env.example) to `.env` for local non-secret settings. Never commit `.env`, and do not store long-lived GitHub tokens there.

Agents must create a human-action file when the user needs to install a tool, add a key, run a terminal command, or do anything technical outside normal conversation.

## Core Flow

0. Startup
1. Vision Interview
2. Requirements
3. Tech Stack / Architecture
4. Build Plan
5. Scaffold
6. Implementation
7. Testing / Verification
8. Review
9. Ship
10. Memory / Lessons Learned

Every phase should update the project checklist, create or revise the required artifacts, explain what changed, and ask for approval before moving on.

## Design Principles

- Humans own project-shaping decisions.
- Agents lead the workflow; humans verify and approve progress.
- Every phase ends with a clear summary, next recommendation, and approval question.
- Unresolved errors block phase advancement unless explicitly deferred.
- Agents ask questions when uncertainty matters.
- Professional best practices are the default recommendation.
- Engineering quality should scale with the project's purpose, risk, audience, and lifecycle.
- Existing tools should be considered before building from scratch.
- Free and accessible tools are preferred when they fit the job.
- New tools should pass the tool adoption standard before becoming dependencies.
- JSON is the machine-readable source for agent state.
- Markdown is mandatory for human-facing context.
- Memory is a reference layer, not the core runtime.
- The framework should stay useful before it becomes automated.
- Project dependencies should be local to the project by default; system installs require a clear reason.

## Repository Boundary

The framework repository should contain reusable framework files:

- Rules, phases, standards, playbooks, roles, agent docs, commands, and templates.
- Public setup docs, including this README and `.env.example`.
- Scratchpad files when the user wants them included.

The framework repository should not contain local project work or private memory by default:

- `projects/` is ignored because generated apps should be separate, GitHub-ready projects.
- `memory/vault/` is ignored because it can contain private session history, lessons, and user preferences.
- `.env`, real tokens, local databases, dependency folders, and build outputs are ignored.

If a user wants to publish an example project or sanitized memory note, copy it into a dedicated public examples or docs folder instead of committing the live local folder.

## Codex Workflow Prompts

The workflow prompt system is documented now for use directly in Codex conversation and can be automated later. These do not currently appear as built-in Codex slash commands. See [commands/README.md](commands/README.md).

Use these phrases in Codex:

- `start a new project`: create or continue startup.
- `run vision`: interview the user about what they want to build.
- `run architecture`: choose stack, runtime, dependency, and environment strategy.
- `run gate`: confirm the current phase is complete before moving on.
- `run project status`: summarize project state from the checklist and artifacts.
- `create Claude delegation`: create a bounded delegation packet for Claude Code.
- `review Claude handoff`: inspect Claude's result before decisions or integration.
- `split work between Codex and Claude`: recommend a token-conscious collaboration plan.
- `run memory`: record lessons learned and reusable patterns after the project is done.
- `wrap up`: create a session summary.

For local checks without asking Codex to run each underlying script, the optional runner supports commands such as:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 doctor
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 toolbox
```

## Local Validation

Before committing framework changes, agents should run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools/secret-scan.ps1 -All
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools/artifact-validate.ps1 -All
```

To enable the tracked pre-commit hook for this repo:

```powershell
git config core.hooksPath .githooks
```

## Useful Standards

- [Engineering Quality](standards/engineering-quality.md)
- [Project Rigor Levels](standards/project-rigor-levels.md)
- [Project Operating Tiers](standards/project-operating-tiers.md)
- [Stack Profiles](standards/stack-profiles.md)
- [Human Actions](standards/human-actions.md)
- [Tool Adoption](standards/tool-adoption.md)
- [Starter Toolbox](standards/starter-toolbox.md)
- [Cleanup Workflow](standards/cleanup-workflow.md)
- [Idea Intake](standards/idea-intake.md)
- [Audit Workflow](standards/audit-workflow.md)
- [Local Logs And Events](standards/local-logs-events.md)
- [File-Based Task Records](standards/file-based-task-records.md)
- [Tauri Dependency Audit](standards/tauri-dependency-audit.md)
- [Environment / Runtime](standards/environment-runtime.md)
- [Windows Local Development](standards/windows-local-development.md)
- [Git / GitHub](standards/git-github.md)
- [Project Audit](standards/project-audit.md)
- [Artifact Validation](standards/artifact-validation.md)
- [User Acceptance Testing](standards/user-acceptance-testing.md)
- [Framework Git / Backup](standards/framework-git-backup.md)

## Current Status

This is v1 planning infrastructure with a confirmed script-assisted, local-first MVP direction. It remains intentionally lightweight: docs, rules, templates, paired Markdown/JSON artifacts, and safe local checks first; heavyweight automation later only after it proves necessary.
