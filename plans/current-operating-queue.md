# Software Factory Operating Queue

## Purpose

This is the current rolling queue for Software Factory framework work.

The queue exists to preserve momentum by reducing friction. It is not a calendar schedule, a commitment to do every listed item, or approval to expand scope.

## Operating Stance

Default tier for this framework cycle: Tier 3, Lean Build.

Use Tier 3 behavior by default:

- ask only the questions needed to avoid bad assumptions;
- keep artifacts compact;
- prefer existing framework patterns;
- keep explanations short unless the human asks for more;
- preserve approval gates for project-shaping or destructive decisions.

Escalate to Tier 2 or Tier 1 when work affects:

- phase gates;
- approval behavior;
- memory behavior;
- Codex / Claude delegation;
- security or privacy;
- project startup;
- meaningful file deletion, merge, archive, or restructure.

## Active Lanes

### Clear The Runway

Reduce friction in the framework itself.

Includes:

- cleanup workflow;
- stale files;
- confusing docs;
- encoding damage;
- redundant notes;
- safe delete, merge, or archive decisions.

### Control The Inflow

Make raw ideas easier to capture, classify, and route without turning them into approved scope.

Includes:

- idea intake;
- future commands;
- fixes;
- deferred work;
- roadmap routing;
- approval boundaries for turning ideas into work.

### Prove The Framework

Use Software Factory on real work, then tune the framework from observed friction.

Includes:

- Phase 0 dry runs;
- `STARTUP-001`;
- `OPERATING-001`;
- operating-tier calibration;
- real-project lessons.

## Queue Rules

- Prioritize friction-based evidence over roadmap inertia.
- Prefer work that makes the next session easier.
- Keep each queue item small enough to explain on one screen.
- Do not delete, merge, archive, or remove guidance without explicit human approval.
- Keep private vault memory, generated project work, logs, `.env`, and local-only state out of public framework scope unless explicitly approved.

Each queue item should include:

- outcome;
- why now;
- acceptance check;
- approval needed;
- operating tier.

## Completed This Cycle

### Clear The Runway: Define Cleanup Workflow

Outcome: create a lightweight cleanup workflow for redundant, stale, ignored, generated, or confusing files before removing anything.

Result: documented in `standards/cleanup-workflow.md`.

Acceptance check: Software Factory has a documented cleanup process that can classify files as keep, update, merge, archive, delete, or private; deletion, merge, and archive decisions require explicit approval.

Approval needed: complete for the standard itself; still required for any actual delete, merge, archive, or removal of guidance.

Operating tier: Tier 3 unless the cleanup affects approvals, phase gates, memory, delegation, security, project startup, or major structure.

### Clear The Runway: First Cleanup Review

Outcome: review likely cleanup candidates and produce recommended actions without deleting anything.

Result: documented in `plans/cleanup-review-2026-06-20.md`.

Acceptance check: candidates are listed with a recommended action and rationale; any destructive or structural action is separated for approval.

Approval needed: yes for delete, merge, archive, or guidance removal.

Operating tier: Tier 3, escalating if framework structure or user-facing workflow changes.

### Clear The Runway: Choose Cleanup Actions

Outcome: choose which recommendations from `plans/cleanup-review-2026-06-20.md` should be implemented, deferred, or rejected-for-now.

Result: selectively kept helpful ignored `Explanation.md` files and removed boilerplate ignored explanation notes. Other candidates were deferred or left private.

Acceptance check: approved actions are identified clearly before implementation; private/generated paths remain untouched unless the human asks for disk cleanup.

Approval needed: complete for the selected `Explanation.md` cleanup; still required for every future delete, merge, archive, guidance removal, `.gitignore` behavior change, or private/generated cleanup.

Operating tier: Tier 3 unless the chosen action affects framework structure, startup, approval behavior, memory, delegation, or security.

### Control The Inflow: Lightweight Idea Intake

Outcome: make `FRAMEWORK-IDEAS.md`, `PROJECT-IDEAS.md`, `FIXES.md`, `DEFERRED.md`, and future command notes easier to route and review.

Result: documented `standards/idea-intake.md`, added `triage ideas` and `route this idea` prompts, clarified safe note routing, cleaned private idea scratchpad formatting, and structured future command notes.

Acceptance check: Codex can classify new ideas as raw, proposed, approved, deferred, rejected-for-now, or needs-human-decision and route them to the right destination.

Approval needed: complete for lightweight routing docs and scratchpad formatting; still required before moving a raw idea into approved roadmap, project scope, dependency adoption, or automation.

Operating tier: Tier 3 for documentation; Tier 2 if schemas, templates, or runner behavior are added.

### Prove The Framework: Phase 0 Dry Run

Outcome: test `STARTUP-001`, `OPERATING-001`, operating tiers, and project rigor selection on a small real or toy project.

Result: created local ignored wrapper `projects/phase0-proof-grocery-list/` with status, checklist, `STARTUP-001`, and `OPERATING-001` artifacts. Findings are recorded in `plans/phase0-proof-grocery-list-findings-2026-06-20.md`.

Acceptance check: Phase 0 produces concise startup and operating artifacts, and friction is recorded in `FIXES.md` or private vault memory.

Approval needed: complete for the dry-run wrapper; still required before continuing to Vision Interview, choosing a runtime, scaffolding source code, or treating the proof project as a real build.

Operating tier: chosen during startup; default Tier 3 for a small proof run.

### Prove The Framework: Startup Decision

Outcome: decide whether the Phase 0 proof stops here or continues into the Vision Interview.

Result: human approved stopping the proof after Phase 0. The proof wrapper is marked `completed-proof`, Startup is approved, and Vision Interview is deferred.

Acceptance check: the human chooses stop, continue to Vision Interview, or archive/ignore the proof wrapper.

Approval needed: complete for stopping the proof; still required before reopening, moving to Phase 1 Vision Interview, or scaffolding any code.

Operating tier: Tier 3 if continuing as a small project; revisit if scope grows.

### Codex And Claude Coordination

Outcome: strengthen delegation and handoff guidance after cleanup, intake, and Phase 0 proof have shown the local-first framework path.

Result: updated `rules/coordination.md`, `CLAUDE.md`, agent role notes, `DELEGATION-001`, `HANDOFF-001`, and command prompt docs so Claude collaboration is bounded and Codex-reviewed.

Acceptance check: Codex can explain when Claude is useful, create bounded delegation packets, and review handoffs without letting Claude make project-shaping decisions.

Approval needed: complete for documentation and template strengthening; still required before changing agent autonomy, phase gates, approval behavior, or delegating risky work.

Operating tier: Tier 2 for coordination template changes; Tier 1 if agent responsibility boundaries change.

### Audit Workflow

Outcome: decide whether project and framework audits should remain documented prompts, become runner commands, or use both.

Result: added `standards/audit-workflow.md`, expanded `standards/project-audit.md`, updated `AUDIT-001`, and clarified command contracts so audits compose runner checks as evidence without adding an audit runner command yet.

Why now: audit support is valuable, but cleanup and intake should lead so the audit has clear targets.

Acceptance check: audit behavior is defined around validation, secret scan, status drift, task summaries, event summaries, and stale artifact checks.

Approval needed: complete for the documented workflow; still required before adding automation that writes files or enforces phase behavior.

Operating tier: Tier 2 if runner changes are added.

### Phase Efficiency Review

Outcome: review each phase for unnecessary ceremony, missing gates, unclear artifacts, and token-heavy behavior.

Result: documented in `plans/phase-efficiency-review-2026-06-21.md` and applied a small consistency pass across Vision, Architecture, Build Plan, Scaffold, Implementation, Review, and Memory.

Acceptance check: phase changes are based on observed friction, paired Markdown/JSON expectations remain clear, lean projects can use right-sized architecture and build-plan detail, and Scaffold/Memory have clearer closeout prompts.

Approval needed: complete for the applied phase-doc updates; still required before changing phase-gate semantics, approval requirements, or adding automation.

Operating tier: Tier 2 for workflow wording changes.

### Validate Updated Phases On Toolbox Smoke Test

Outcome: use the updated phase docs against an existing focused proof project without scaffolding new source code.

Result: documented in `plans/phase-validation-toolbox-smoke-test-2026-06-21.md`. Architecture right-sizing, Build Plan compactness, runner status, artifact validation, task listing, event breadcrumbs, and pending gate behavior all validated successfully.

Acceptance check: the smoke project could use compact Architecture and Build Plan artifacts without validation warnings, and the gate remained pending rather than advancing without human approval.

Approval needed: complete for this validation pass; still required before starting or reopening a real project, scaffolding source code, changing phase gates, or adding automation.

Operating tier: Tier 3 for this focused validation pass.

### Obsidian Working Knowledge Base Setup

Outcome: decide how long-term memory should work before starting the next test project.

Result: human approved using `memory/vault/` as an Obsidian-friendly working knowledge base. Added private vault conventions, frontmatter guidance, note templates, an attachments folder note, a stronger vault index, and a framework decision memory note.

Acceptance check: memory remains local-first and private, Obsidian is an interface over Markdown rather than a new source of truth, frontmatter supports future Chroma indexing, and broad vector indexing remains deferred.

Approval needed: complete for the private vault setup; still required before adding Obsidian plugins, Chroma/vector indexing, publishing memory, or changing memory promotion rules.

Operating tier: Tier 2 because memory behavior affects future agent continuity.

### Scaffold To Memory Proof

Outcome: validate updated Scaffold and Memory closeout behavior with a tiny local proof project.

Result: created ignored local project `projects/scaffold-memory-proof/` and documented findings in `plans/scaffold-memory-proof-findings-2026-06-21.md`.

Acceptance check: the proof reached `completed-proof`, current phase `memory-lessons`, gate `passed`; workspace files exist; expected content is present; artifact validation passes with 280 files checked and 0 warnings.

Approval needed: complete for this local proof; still required before dependency-based scaffolding, public publishing, or changing gate semantics.

Operating tier: Tier 4 for the proof execution.

### Schema Refinement

Outcome: tighten the phase gate schema based on the Scaffold To Memory proof finding.

Result: documented in `plans/schema-refinement-2026-06-21.md`. `contracts/schemas/phase-gate.schema.json` now requires `security_privacy_check`, constrains `type` to `phase_gate`, and constrains gate and human approval status values.

Acceptance check: `tools\factory.ps1 validate` passes with 280 files checked and 0 warnings; `tools\factory.ps1 doctor` passes.

Approval needed: complete for this schema-hardening pass; still required before changing approval requirements, adding full gate enforcement automation, or changing phase transition behavior.

Operating tier: Tier 2 because schema behavior touches phase gate artifacts.

### Close Dependency-Based Scaffold Proof

Outcome: review the dependency scaffold proof and decide whether to approve the pending Testing / Verification gate.

Result: human approved closing the proof gate. The proof project is marked `completed-proof`, current phase `Testing / Verification`, and gate `passed`.

Acceptance check: the proof scaffolded, installed, and built a Vite TypeScript workspace; artifact validation passes with 304 files checked and 0 warnings; findings are documented in `plans/dependency-scaffold-proof-findings-2026-06-21.md`.

Approval needed: complete for closing the proof gate; still required before changing framework guidance, validator skip rules, or dependency scaffold defaults.

Operating tier: Tier 2 because dependency guidance and validation behavior affect future project scaffolds.

### Apply Dependency Scaffold Guidance

Outcome: fold the dependency scaffold proof lessons into framework guidance.

Result: documented Windows/npm fallback expectations and package-manager cache placement in the environment/runtime and scaffold guidance.

Acceptance check: future dependency-based scaffolds know to use `npm.cmd` when PowerShell blocks `npm.ps1`, and to keep package-manager caches under `workspace/` or another ignored, validator-safe path.

Approval needed: complete for this small guidance update; still required before changing validator skip rules, dependency scaffold defaults, or adopting a specific package manager as a framework default.

Operating tier: Tier 2 because dependency guidance affects future project scaffolds.

## Now

### Start End-Of-Day Test Project

Outcome: begin a fresh small test project using the proven local-first Software Factory workflow.

Why now: phase, schema, scaffold, memory, and dependency behavior have all been validated enough to learn from a real small project instead of another proof.

Acceptance check: the test project reaches at least Startup and Vision with compact artifacts, clear operating tier, and no unresolved setup blockers; continue farther only with human approval at gates.

Approval needed: yes before selecting the project idea, choosing a stack, scaffolding dependencies, or advancing phase gates.

Operating tier: Tier 3 by default, unless the selected project raises privacy, security, cost, deployment, or architecture risk.

## Deferred This Cycle

Do not prioritize these unless the human explicitly changes direction:

- GUI work;
- vector memory or Chroma indexing;
- external task managers;
- native Codex command registration;
- full phase-gate enforcement automation;
- GitHub repo creation automation;
- release automation;
- broad reusable code-template libraries.

These remain possible later, but they should not distract from proving the local-first MVP.
