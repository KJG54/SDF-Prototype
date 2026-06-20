# Artifact Validation Standard

Use this for artifact checks. `tools/artifact-validate.ps1` automates lightweight structural checks and JSON Schema checks for core artifact families; this standard remains the source for human review of meaning and project-shaping decisions.

The goal is to catch drift between human-readable Markdown and agent-readable JSON without turning every check into a full audit.

## When To Validate

Validate paired artifacts:

- before a phase gate passes;
- during `run project status` when status or checklist claims look stale;
- during `/audit project`;
- after editing only one side of a Markdown/JSON pair;
- before shipping, publishing, or handing off a project.

Run the automated check with:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools/artifact-validate.ps1 -All
```

The tracked pre-commit hook runs the same validator against staged artifact files.

Core schemas live in `contracts/schemas/`. The validator currently applies schemas to project status, project checklists, phase gates, phase summaries, task records, common phase artifacts, human actions, approvals, and the base artifact shape. It also performs lightweight semantic checks for cross-file drift. Legacy project artifacts may be explicitly marked as legacy when they predate the current schemas.

## Automated Semantic Checks

The validator checks these project-shaping relationships:

- `status.json` checklist file references point to existing checklist files;
- `status.json` and `project-checklist.json` agree on project name, slug, current phase, and open questions;
- the current phase appears in the checklist by phase id or phase name;
- non-current phases should not be marked `in-progress`, `blocked`, or `ready-for-gate`;
- project `current_phase_gate` uses the same vocabulary as phase gate artifacts: `pending`, `passed`, `blocked`, or `deferred-with-approval`;
- passed phase gates require approved human approval, Markdown/JSON alignment, security/privacy check, no unresolved current-phase errors, completed or deferred human actions, and no blocking questions;
- `deferred-with-approval` phase gates require human approval and at least one deferred issue.

These checks are intentionally narrow. They catch contradictions in the state model; they do not replace human review of scope, quality, architecture, or acceptance.

## What Counts As A Pair

A paired artifact is a Markdown file and JSON file that represent the same record.

Limit this check to Software Factory artifacts and project status records. Do not treat application source files, package manifests, dependency metadata, generated build output, or workspace README files as required Markdown/JSON pairs unless a phase explicitly names them as artifacts.

Common examples:

- `STATUS.md` and `status.json`
- `PROJECT-CHECKLIST.md` and `project-checklist.json`
- `VISION-001-*.md` and `VISION-001-*.json`
- `REQ-001-*.md` and `REQ-001-*.json`
- `ARCH-001-*.md` and `ARCH-001-*.json`
- `PLAN-001-*.md` and `PLAN-001-*.json`
- `SUMMARY-*.md` and `SUMMARY-*.json`
- `GATE-*.md` and `GATE-*.json`
- `ACTION-*.md` and `ACTION-*.json`

Legacy projects may be missing newer artifact pairs. Report that as a limitation or migration need, not as proof that the project is invalid.

## Manual Check

For each pair, confirm:

- both files exist;
- the JSON parses;
- applicable JSON Schema checks pass or legacy warnings are explicitly understood;
- automated semantic checks pass;
- the artifact id, type, project, phase, and status fields agree where those concepts exist;
- the latest decision in Markdown matches the structured decision or status in JSON;
- open questions match;
- blocking issues match;
- human actions match;
- deferred items match;
- approval status and approver notes match for gates;
- test, review, shipping, and memory results match for those phase artifacts;
- `last_updated` or equivalent date fields are current when present.

Markdown may contain friendlier wording than JSON. That is fine when the meaning is the same.

## Checklist Validation

For project checklists, confirm:

- `current_phase` matches the active status files;
- every phase has a supported status value;
- required artifacts listed in Markdown match `required_artifacts` in JSON;
- blocking issues listed in Markdown match `blocking_issues` in JSON;
- human actions, open questions, and deferred items match;
- the next action matches the current phase state.

Supported phase status values are documented in `commands/contracts.md`.

## Status Validation

For project status, confirm:

- project name and slug agree;
- state agrees;
- current phase agrees;
- current phase gate agrees;
- open questions agree;
- blocking issues agree;
- next step agrees.

If status and checklist disagree, report the mismatch and use the actual artifacts to decide which record is stale.

## Pass, Warning, Fail

Use these results:

- `pass`: the pair exists, parses, and agrees on all project-shaping facts.
- `warning`: the pair agrees on meaning but has minor wording, date, or completeness issues.
- `fail`: files are missing, JSON does not parse, or project-shaping facts disagree.

Fail closed when validation fails for the current phase gate, shipping readiness, or phase advancement.

## Repair Rules

Agents may fix obvious clerical drift, such as a missing artifact id or stale wording, when the existing decision is clear.

Agents must ask before changing project-shaping facts, including scope, approval status, blockers, deferrals, architecture, dependencies, shipping target, or human acceptance.

When the human must decide something before repair, create or update a human-action artifact.

## Reporting

Validation notes should include:

- files checked;
- result for each pair;
- mismatches found;
- repairs made;
- remaining limitations;
- next recommended action.
