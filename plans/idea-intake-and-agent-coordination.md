# Idea Intake And Agent Coordination Plan

## Purpose

Software Factory needs a clear workflow for turning the human's rough ideas into the right framework or project files without treating every idea as approved scope. It also needs a more concrete way for Codex and Claude Code to collaborate so work can be split intentionally, token usage can be managed, and the human remains in control of project-shaping decisions.

This plan keeps the solution local-first, file-first, and lightweight. It uses Markdown, JSON, task records, delegation packets, handoff records, and documented workflow prompts before considering heavier tooling.

## Problems To Solve

### Idea Intake

The human needs to be able to give Codex a messy list of ideas with mixed scope, such as:

- new project ideas;
- framework workflow improvements;
- bugs or fixes;
- possible future commands;
- tooling suggestions;
- architecture thoughts;
- project-specific feature requests;
- reusable memory or lesson ideas.

Codex should classify those ideas, preserve the original wording, route them to the correct files, and clearly mark whether they are raw notes, proposed work, approved scope, deferred work, or rejected-for-now.

### Agent Collaboration

The framework already says Codex leads and Claude Code collaborates. The next step is to make that collaboration repeatable:

- Codex should decide when Claude is useful and explain why.
- Claude should receive bounded delegation packets.
- Claude should not make project-shaping decisions.
- Claude should return structured handoffs.
- Codex should review Claude's output before turning it into decisions or user-facing claims.
- Work should be split in a way that reduces duplicate context loading and unnecessary token use.

### Scope Safety

The workflow must prevent ideas from silently becoming commitments. A note in an idea file should not automatically update requirements, architecture, roadmap, project scope, or implementation tasks.

## Guiding Principles

- Preserve raw ideas before interpreting them.
- Separate raw notes, proposed work, approved work, and deferred work.
- Route ideas to existing files when they fit.
- Create new files only when the idea category or volume justifies it.
- Keep Markdown human-readable and JSON agent-readable.
- Prefer local files over external task managers or databases.
- Require human approval before project-shaping changes.
- Use Claude Code as a collaborator, not a second project lead.
- Make token usage visible enough to guide routing decisions without adding accounting overhead.

## Proposed File And Folder Additions

### Framework-Level Idea Files

Create the currently referenced safe note files if they do not exist:

```text
FRAMEWORK-IDEAS.md
PROJECT-IDEAS.md
FIXES.md
```

Recommended responsibility:

- `FRAMEWORK-IDEAS.md`: raw or proposed improvements to Software Factory itself.
- `PROJECT-IDEAS.md`: possible future apps, tools, games, automations, or experiments.
- `FIXES.md`: known framework problems, confusing docs, broken commands, validation gaps, or rough edges.

### Intake Plans And Records

Use this folder for framework planning documents:

```text
plans/
```

Add an intake artifact template for durable triage sessions:

```text
templates/artifacts/IDEA-001-idea-intake.md
templates/artifacts/IDEA-001-idea-intake.json
contracts/schemas/idea-intake.schema.json
```

For active projects, place intake records under:

```text
projects/<slug>/artifacts/research/
projects/<slug>/artifacts/change-requests/
```

Use `change-requests/` when the idea may alter approved scope. Use `research/` when the idea needs investigation before it can become a task or decision.

## Idea Classification Model

Each triaged idea should receive these fields:

- `raw_text`: the human's original wording.
- `summary`: a short Codex interpretation.
- `category`: project idea, framework idea, fix, tooling, command, workflow, research, memory, risk, question, or other.
- `scope`: framework, active project, future project, global memory, or unknown.
- `destination`: the file or artifact where it should live.
- `status`: raw, clarified, proposed, approved, deferred, rejected-for-now, or needs-human-decision.
- `approval_required`: yes or no.
- `reason_approval_required`: short explanation when approval is needed.
- `claude_useful`: yes, no, or maybe.
- `why_claude_useful`: second opinion, implementation, review, debugging, parallel research, or not useful.
- `next_action`: route, ask question, create task, create change request, defer, reject, or discuss.

## Routing Rules

Use these default destinations:

| Idea Type | Default Destination |
| --- | --- |
| Framework improvement | `FRAMEWORK-IDEAS.md` |
| Possible future project | `PROJECT-IDEAS.md` |
| Bug or broken workflow | `FIXES.md` |
| Approved framework direction | `ROADMAP.md` |
| Useful but not now | `DEFERRED.md` |
| Future workflow prompt | `commands/potential-future-commands.md` |
| Tool or platform suggestion | `tools/registry.md` only after tool-adoption review |
| Active project feature idea | `projects/<slug>/artifacts/change-requests/` |
| Active project implementation task | `projects/<slug>/artifacts/tasks/` |
| Reusable lesson or preference | memory proposal, only after approval when durable |
| Unclear idea | keep in intake record and ask focused questions |

## Workflow Prompt Additions

Document these as plain-language Codex prompts:

| Say This In Codex | Reserved Command Name | Purpose |
| --- | --- | --- |
| `triage ideas` | `/triage-ideas` | classify a batch of raw ideas and route them to the right files |
| `route this idea` | `/route-idea` | classify one idea and recommend the right destination |
| `create Claude delegation` | `/delegate` | create a bounded delegation packet for Claude Code |
| `review Claude handoff` | `/review-handoff` | inspect Claude's result before decisions or integration |
| `split work between Codex and Claude` | `/split-work` | recommend a collaboration plan and token-conscious division of labor |
| `run backlog review` | `/backlog-review` | review proposed, deferred, and open task records |

These prompts should not bypass approval gates. They should produce recommendations, files, task records, delegation packets, or handoff reviews as appropriate.

## Codex And Claude Collaboration Model

### Codex Responsibilities

Codex remains responsible for:

- primary conversation with the human;
- reading project status and phase artifacts;
- asking approval questions;
- phase transitions and phase gates;
- scope, architecture, dependency, privacy, cost, deployment, and shipping decisions;
- deciding whether Claude is useful for a specific task;
- preparing delegation packets;
- reviewing Claude handoffs;
- integrating final changes;
- updating human-facing summaries and agent-readable state.

### Claude Code Responsibilities

Claude Code may help with:

- strenuous implementation;
- repetitive code edits;
- second opinions;
- debugging;
- security or architecture review;
- test planning;
- edge-case review;
- cleanup after the core direction is clear;
- parallel investigation with a clear boundary.

Claude Code should not:

- approve scope changes;
- advance phases;
- add major dependencies without approval;
- make architecture decisions;
- change deployment or publishing direction;
- handle secrets or credentials unless explicitly approved and safely bounded;
- expand the task beyond the delegation packet.

## Delegation Packet Improvements

Strengthen `DELEGATION-001` so each delegation includes:

- task id or related task record;
- goal;
- why Claude is useful;
- context budget guidance;
- files Claude should read;
- files Claude may edit;
- files Claude must not edit;
- approval boundaries;
- acceptance criteria;
- verification expectations;
- expected handoff format;
- whether Codex must review before integration;
- whether the human must approve before delegation.

## Handoff Improvements

Strengthen `HANDOFF-001` so Claude's return packet includes:

- task id;
- summary of work;
- files read;
- files changed;
- tests or checks run;
- checks not run and why;
- issues found;
- risks or open questions;
- assumptions made;
- recommended next step;
- whether Codex review is required before the work is treated as complete.

## Token Usage Strategy

The goal is not exact token accounting. The goal is to avoid waste and route work sensibly.

Use Codex for:

- orchestration;
- phase artifacts;
- final file routing;
- approval-sensitive decisions;
- small precise edits;
- status summaries;
- roadmap and standards alignment.

Use Claude Code for:

- larger implementation batches;
- broad review;
- repetitive transformations;
- debugging with a clear reproduction;
- independent second opinions;
- test expansion;
- large-file cleanup after Codex defines the target.

Avoid:

- asking both agents to perform the same broad repo scan;
- delegating without a concise packet;
- letting Claude explore scope freely;
- having Codex rewrite a full Claude result when a review-and-patch pass is enough.

## Implementation Phases

### Phase 1: Lightweight Intake Surface

Deliverables:

- create `FRAMEWORK-IDEAS.md` if missing;
- create `PROJECT-IDEAS.md` if missing;
- confirm `FIXES.md` responsibility;
- add a short idea intake section to `START-HERE.md`;
- document `triage ideas` and `route this idea` in `commands/README.md`.

Acceptance criteria:

- the human has a clear place to put raw ideas;
- Codex has explicit routing rules;
- raw notes are not treated as approved scope.

### Phase 2: Durable Idea Intake Artifacts

Deliverables:

- add `IDEA-001-idea-intake.md`;
- add `IDEA-001-idea-intake.json`;
- add `idea-intake.schema.json`;
- wire schema validation into `tools/artifact-validate.ps1`;
- add examples for mixed-scope idea batches.

Acceptance criteria:

- a batch of mixed ideas can be captured, classified, and validated;
- Markdown and JSON preserve the same classification decisions;
- approval-required ideas are visibly marked.

### Phase 3: Codex / Claude Collaboration Workflow

Deliverables:

- update `rules/coordination.md`;
- update `CLAUDE.md`;
- strengthen delegation and handoff templates;
- document `create Claude delegation`, `review Claude handoff`, and `split work between Codex and Claude`;
- add guidance for token-conscious work splitting.

Acceptance criteria:

- delegation packets are specific enough for Claude to act without guessing scope;
- handoffs are specific enough for Codex to review and continue;
- project-shaping decisions remain with the human and Codex.

### Phase 4: Backlog And Review Loop

Deliverables:

- add `run backlog review` prompt documentation;
- connect idea intake to task records;
- define when a triaged idea becomes a task, change request, roadmap item, or deferred item;
- optionally extend `tools/factory.ps1` with read-only idea/backlog listing.

Acceptance criteria:

- proposed ideas can be reviewed without becoming scope;
- approved work can become task records;
- deferred work stays visible but non-blocking.

## Approval Boundaries

Human approval is required before:

- turning an idea into approved project scope;
- changing framework coordination rules in a way that affects agent autonomy;
- adding new tools, services, platforms, or dependencies;
- adding automation that writes files without Codex review;
- changing phase gates or approval behavior;
- delegating risky work to Claude;
- adopting a token-routing rule that changes project-shaping responsibilities.

Codex may do without special approval:

- classify raw ideas;
- recommend destinations;
- create proposed task records;
- update safe note files;
- create draft delegation packets;
- summarize Claude handoffs;
- point out uncertainty or approval needs.

## Risks And Mitigations

| Risk | Mitigation |
| --- | --- |
| Too much process for simple notes | Keep raw idea files simple and make durable intake artifacts optional until useful. |
| Ideas silently become scope | Require status labels and approval-required fields. |
| Claude changes too much | Use explicit edit boundaries and Codex review. |
| Token usage increases because both agents read everything | Use concise packets and file lists. |
| JSON/Markdown drift | Add schema validation and manual artifact checks. |
| Roadmap becomes cluttered | Only approved directions move to `ROADMAP.md`; raw ideas stay elsewhere. |
| Deferred work becomes forgotten | Include deferred ideas in backlog review. |

## Recommended First Change Set

The first implementation should be small:

1. Create missing safe-note files: `FRAMEWORK-IDEAS.md` and `PROJECT-IDEAS.md`.
2. Add idea routing guidance to `START-HERE.md`.
3. Add the new workflow prompts to `commands/README.md`.
4. Update `rules/coordination.md` with the Codex/Claude responsibility split.
5. Strengthen `DELEGATION-001` and `HANDOFF-001` templates.
6. Defer schema and runner automation until the manual workflow has been used at least once.

## Definition Of Done

This plan is complete when:

- a human can give Codex a mixed list of ideas and Codex can route each item clearly;
- raw ideas, proposed work, approved work, and deferred work are visibly distinct;
- Codex can create a clear Claude delegation packet when Claude is useful;
- Claude can return a structured handoff that Codex can review;
- roadmap items only reflect approved or recommended work, not every raw idea;
- the workflow works with local Markdown and JSON before any heavier tooling is considered.
