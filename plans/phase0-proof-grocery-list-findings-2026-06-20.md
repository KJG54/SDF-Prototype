# Phase 0 Proof Findings - Grocery List Maker

## Purpose

This dry run tested whether Software Factory Phase 0 can create a useful project wrapper and operating model without turning a small idea into a full build.

The subject was a low-risk toy project: Grocery List Maker.

## What Was Created

Local ignored project wrapper:

```text
projects/phase0-proof-grocery-list/
```

Created Phase 0 files:

- `STATUS.md`
- `status.json`
- `PROJECT-CHECKLIST.md`
- `project-checklist.json`
- `artifacts/startup/STARTUP-001-new-project-startup.md`
- `artifacts/startup/STARTUP-001-new-project-startup.json`
- `artifacts/startup/OPERATING-001-project-operating-model.md`
- `artifacts/startup/OPERATING-001-project-operating-model.json`

No source code was scaffolded.

## What Worked

- Phase 0 produced the expected wrapper, status files, checklist files, startup artifact, and operating model.
- Tier 3 Lean Build was enough for a small proof run.
- Level 1 personal local tool fit the grocery list idea.
- `OPERATING-001` made the agent role, posture, likely skills, expected prompts, broad plan, and approval boundaries explicit.
- Artifact validation passed after the wrapper was created.
- `tools/factory.ps1 status` listed the proof project and showed the next step.

## Friction Found

- `STARTUP-001` does not currently have a dedicated JSON Schema, so validation only checks its base artifact shape.
- The local runner supports `status -Project <slug>`, but a guessed `project <slug>` command fails. The help text is correct, so this is minor discoverability friction rather than a bug.
- Phase 0 asks for enough context to be useful, but using it well depends on the operating tier staying lean. Tier 3 worked here.

## Recommendations

- Keep the Phase 0 startup flow as-is for now.
- Defer a dedicated `STARTUP-001` schema until schema gaps become a repeated source of drift.
- Use this proof wrapper as a local reference, not as public framework content.
- Stop the proof here, per human approval.

## Final Decision

The human approved stopping the proof after Phase 0.

Do not continue this proof project into Phase 1 Vision Interview unless the human explicitly reopens it later.
