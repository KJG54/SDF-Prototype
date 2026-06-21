# Schema Refinement

Date: 2026-06-21

## Purpose

Tighten the artifact schemas based on friction observed during the Scaffold To Memory proof.

The proof showed that phase gate Markdown needed an explicit `Security / Privacy Check` section when the JSON gate included `security_privacy_check`. The validator caught the missing Markdown section, but the phase gate schema still treated the JSON security/privacy block as optional.

## Changes Made

- Required `security_privacy_check` in `contracts/schemas/phase-gate.schema.json`.
- Constrained `phase_gate.type` to `phase_gate`.
- Constrained `gate_status` to:
  - `pending`
  - `passed`
  - `blocked`
  - `deferred-with-approval`
- Constrained `human_approval` to:
  - `pending`
  - `approved`
  - `rejected`
- Updated `standards/artifact-validation.md` to document the schema-level phase gate constraints.

## Validation

Commands run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 doctor
```

Results:

- Artifact validation passed with 280 files checked and 0 warnings.
- Doctor passed.

## Decision

Treat this as a small schema-hardening pass, not a new phase-gate policy.

The change codifies behavior already expected by templates, semantic validation, and recent proof projects.

## Remaining Follow-Up

- Keep full phase-gate enforcement automation deferred.
- Consider another schema refinement only after the next proof or real project exposes repeated drift.
