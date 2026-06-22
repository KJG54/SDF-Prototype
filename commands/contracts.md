# Codex Workflow Prompt Contracts

These contracts define how Codex-facing workflow prompts should behave. They are documentation for v1, not implemented automation.

The primary interface is conversation with Codex. Plain-language phrases such as "run project status" are the working interface today. Slash-style names are reserved command names for future native command support, but they are not currently registered with Codex and will not appear in the Codex command picker.

`tools/factory.ps1` is an optional local runner for safe checks and read-only views. It is not a phase automation engine and must not bypass these contracts.

Workflow prompts must help the human move through the Software Factory process without bypassing approval gates. When a prompt cannot prove that required state is safe, it should fail closed and explain what is missing.

## Shared Contract

Every workflow prompt should:

- Read `factory.config.json` first.
- Read `standards/tool-adoption.md` and `standards/starter-toolbox.md` when a workflow may add, remove, promote, defer, or evaluate tools.
- For project commands, read the active project's `STATUS.md`, `status.json`, `PROJECT-CHECKLIST.md`, and `project-checklist.json`.
- Treat `project-checklist.json` as the agent-readable state record.
- Treat `PROJECT-CHECKLIST.md` as the human-facing progress record.
- Keep paired Markdown and JSON artifacts aligned.
- Use `tools/artifact-validate.ps1` and `standards/artifact-validation.md` for paired-artifact checks.
- Use `contracts/schemas/` through `tools/artifact-validate.ps1` for core JSON shape checks.
- Record human actions when the human must install, authenticate, run commands, provide credentials, test manually, or make an external decision.
- Refuse to advance phases while blocking issues, unresolved errors, required human actions, or required approvals are missing.
- Ask before changing scope, architecture, dependencies, paid services, cloud resources, deployment, publication, secrets handling, or phase.
- Apply `standards/tool-adoption.md` before changing tool dependencies, automation platforms, data stores, message brokers, observability systems, or cloud integrations.

Workflow prompts must not:

- Create generated source code outside `projects/<slug>/workspace/`.
- Treat documentation-only notes as approved scope.
- Skip required artifacts because the conversation appears clear.
- Use GitHub, deployment, cloud, or paid-service actions without explicit human approval.
- Promote deferred or rejected-for-now starter toolbox items without explicit human approval and a recorded decision.
- Mark a phase complete only because implementation work is done.

## Local Runner Contract

The repo-local runner may:

- show help;
- run framework doctor checks;
- read project status;
- run artifact validation;
- run secret scanning;
- display the tool registry;
- append and view local ignored JSONL events;
- display file-based task records.

The repo-local runner must not:

- create projects;
- update status, checklists, or artifacts;
- advance phases;
- approve gates;
- install tools or dependencies;
- run GitHub, publishing, deployment, release, or destructive filesystem actions.

Local runner events must follow `standards/local-logs-events.md` and must not be treated as approval or project state.

Task records must follow `standards/file-based-task-records.md` and must not be treated as approval or phase state.

## Checklist State

Supported phase status values:

- `pending`: the phase has not started.
- `in-progress`: the phase has started and required work is underway.
- `blocked`: the phase cannot continue until a blocker, human action, or unresolved error is handled.
- `ready-for-gate`: required work appears complete and the agent should run the gate workflow.
- `approved`: the human approved the phase gate.
- `deferred`: the human explicitly approved postponing this phase or its remaining work.

Minimum checklist fields to update:

- `current_phase`
- phase `status`
- phase `required_artifacts`
- phase `blocking_issues`
- phase `next_action`
- `open_questions`
- `human_actions`
- `deferred_items`
- `last_updated`

## State Transitions

When a phase workflow starts:

- Set `current_phase` to that phase id.
- Set the phase status to `in-progress`.
- Set earlier approved phases to `approved`.
- Leave later phases as `pending` unless the human explicitly approved deferral.
- Add or update the phase `next_action`.

When a required artifact is created:

- Add the artifact id to the phase record if it is missing.
- Make sure the Markdown and JSON versions describe the same decision, status, and open issues.
- Validate the pair using `tools/artifact-validate.ps1` and `standards/artifact-validation.md` when the artifact affects phase gates, status, or handoff.
- Update `last_updated`.

When a blocker is found:

- Add it to the phase `blocking_issues`.
- Set the phase status to `blocked`.
- Add a human action if the human must do something.
- Do not move to the next phase unless the human explicitly approves deferral or the next phase naturally resolves it and that reasoning is documented.

When work is ready for a gate:

- Set the phase status to `ready-for-gate`.
- Make `next_action` point to `/gate`.
- Confirm required artifacts exist.
- Confirm open project-shaping questions are resolved or documented.

When `/gate` passes:

- Record the human approval decision.
- Set the phase status to `approved`.
- Clear resolved blockers from the active blocking list.
- Set `current_phase` to the next phase only after the human approves moving forward.
- Update both checklist files.

## Command Details

### Start

Invocation: `start a new project`

Reserved command name: `/start`

Purpose: route the project type to the right playbook, then create or continue startup for a new project.

Reads:

- `START-HERE.md`
- `playbooks/project-type-router.md`
- Selected primary playbook from `playbooks/`
- `standards/new-project-startup.md`
- `standards/project-operating-tiers.md`
- `standards/project-rigor-levels.md`
- `templates/projects/STATUS.md`
- `templates/projects/status.json`
- `templates/projects/PROJECT-CHECKLIST.md`
- `templates/projects/project-checklist.json`
- `templates/artifacts/STARTUP-001-new-project-startup.md`
- `templates/artifacts/STARTUP-001-new-project-startup.json`
- `templates/artifacts/OPERATING-001-project-operating-model.md`
- `templates/artifacts/OPERATING-001-project-operating-model.json`

Writes:

- `projects/<slug>/STATUS.md`
- `projects/<slug>/status.json`
- `projects/<slug>/PROJECT-CHECKLIST.md`
- `projects/<slug>/project-checklist.json`
- `projects/<slug>/artifacts/startup/STARTUP-001-new-project-startup.md`
- `projects/<slug>/artifacts/startup/STARTUP-001-new-project-startup.json`
- `projects/<slug>/artifacts/startup/OPERATING-001-project-operating-model.md`
- `projects/<slug>/artifacts/startup/OPERATING-001-project-operating-model.json`
- Human-action files when needed

Gate behavior:

- Startup does not require the same project-shaping approval as later phases.
- Startup begins by choosing a project type route when the route is not already clear.
- Supported first-pass route choices are app/web app, website, game, CLI/tool, automation, AI system, data dashboard/report, browser extension, library/package, existing-project feature, Codex skill/command/framework workflow, and generic/unsure.
- The selected route and playbook must be recorded in `STARTUP-001` and reflected in `OPERATING-001`.
- Startup should recommend a project operating tier and a starting rigor level before the Vision Interview deepens.
- The workflow should still ask whether the human wants to continue to Phase 1.

Slash-command note:

- `/start` is reserved for future native command support. It is not currently a project-local Codex slash command picker entry.
- The usable v1 path is the plain-language prompt `start a new project`, optionally backed by the `sf-start` skill when installed.

### Phase Workflows

Applies to:

- `run vision`
- `run requirements`
- `run architecture`
- `run plan`
- `run scaffold`
- `run build`
- `run test`
- `run uat`
- `run review`
- `run ship`
- `run memory`

Reads:

- Active project status and checklist files
- The matching `phases/<phase>.md`
- Required artifact templates for that phase
- Relevant standards named by the phase file
- `standards/tool-adoption.md`, `standards/starter-toolbox.md`, and `tools/registry.md` during architecture, scaffold, review, ship, or tooling decisions
- Existing phase artifacts

Writes:

- Required phase artifacts
- Phase summary
- Phase gate
- Status and checklist updates
- Human-action files when needed

Gate behavior:

- A phase workflow may prepare a phase for the gate workflow.
- A phase workflow must not approve itself.
- A phase workflow must ask the human for approval before moving forward.

### Project Status

Invocation: `run project status`

Reserved command name: `/project-status`

Purpose: summarize current project state.

Reads:

- `factory.config.json`
- Active project `STATUS.md` and `status.json`
- Active project checklist files
- Current phase artifacts
- Human-action files
- Known blocker, testing, review, shipping, and memory artifacts when relevant

Writes:

- Nothing by default.
- May update stale status only after explaining the mismatch and receiving approval when the correction is project-shaping.

Required checks:

- Active project is known or clearly absent.
- Markdown and JSON status agree.
- Checklist phase matches status phase.
- Current phase artifacts exist or are reported missing.
- Paired artifacts are checked with `tools/artifact-validate.ps1` and `standards/artifact-validation.md` when status depends on them.
- Blocking issues, open questions, human actions, and deferred items are surfaced.

### Gate

Invocation: `run gate`

Reserved command name: `/gate`

Purpose: determine whether the current phase can close.

Reads:

- Active project status and checklist files
- Current phase file
- Required current phase artifacts
- Phase summary
- Human-action files
- Approval artifacts when relevant

Writes:

- Phase gate artifact
- Checklist updates
- Status updates after human approval

Pass conditions:

- Required artifacts exist.
- Paired Markdown and JSON artifacts align.
- Current-phase pairs pass the manual checks in `standards/artifact-validation.md`.
- Required human actions are complete or explicitly deferred.
- Blocking issues are resolved or explicitly deferred.
- Open project-shaping questions are resolved.
- The human has approved the phase result and the proposed next phase.

Failure behavior:

- Explain each missing or unsafe condition.
- Set or keep the phase status as `blocked` when the issue prevents progress.
- Recommend the next smallest corrective action.

### Audit Framework

Invocation: `audit framework`

Reserved command name: `/audit framework`

Purpose: inspect Software Factory itself.

Reads:

- Core entry docs
- Rules
- Phase files
- Standards
- Templates
- Commands
- Roadmap, deferred work, fixes, and changelog
- Operating queue
- Local runner output from `doctor`, `validate`, `secret-scan`, `tasks`, and `events` when useful
- Git status when available

Writes:

- Audit report only when the human asks for a durable artifact.

Must not:

- Rewrite framework policy automatically.
- Implement deferred automation without approval.
- Treat runner output as approval or project state.

Required checks:

- Core docs and standards do not contradict each other.
- Current operating queue matches roadmap/changelog direction.
- Validation and secret scan results are reported.
- Stale, missing, or contradictory templates are surfaced.
- Deferred automation stays deferred unless explicitly approved.

### Audit Project

Invocation: `audit project`

Reserved command name: `/audit project`

Purpose: inspect an active project against the framework.

Reads:

- Active project status and checklist files
- Required artifacts for the current phase
- Paired Markdown and JSON artifacts
- Human actions, blockers, deferred items, testing, review, and shipping artifacts
- Task records, claims, delegations, and handoffs when relevant
- Local events as breadcrumbs, not authority
- Local runner output from `status`, `validate`, `secret-scan`, `tasks`, and `events` when useful
- `standards/project-audit.md`
- `standards/audit-workflow.md`

Writes:

- `AUDIT-001-project-audit.md`
- `AUDIT-001-project-audit.json`
- Checklist updates only if the audit creates a blocker or human action

Must not:

- Approve phase gates.
- Create approved scope from findings.
- Change architecture, dependencies, deployment, privacy, security, memory, or shipping direction without human approval.

Required checks:

- Status and checklist agree on current project-shaping facts.
- Required current-phase artifacts exist or are listed as missing.
- Markdown/JSON artifact validation result is recorded.
- Secret scan result is recorded when tracked files may be pushed or published.
- Open questions, human actions, blockers, errors, and deferred items are surfaced.
- Task records, handoffs, and local events are summarized when present.
- Stale or contradictory artifacts are called out.

### Wrap Up

Invocation: `wrap up`

Reserved command name: `/wrap-up`

Purpose: capture the session state for a future human or agent.

Reads:

- Active project status and checklist files
- Recent phase artifacts
- Known blockers and human actions
- Git status when relevant

Writes:

- Session summary in the appropriate memory or artifact location
- Human-action files when follow-up is required

Must include:

- What changed
- What was verified
- What is blocked
- What the next agent should read first
- What the human still needs to decide or do
