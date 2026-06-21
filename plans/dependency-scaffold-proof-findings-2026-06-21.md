# Dependency Scaffold Proof Findings

Date: 2026-06-21

## Purpose

Validate that Software Factory can handle a dependency-based scaffold, not only static no-dependency workspace creation.

## Proof Project

Local ignored project wrapper:

```text
projects/dependency-scaffold-proof/
```

Generated workspace:

```text
projects/dependency-scaffold-proof/workspace/
```

Stack used for proof:

- Node.js v24.13.0
- npm 11.6.2 through `npm.cmd`
- Vite 8
- TypeScript 6

## What Passed

- `npm.cmd create vite@latest workspace -- --template vanilla-ts` succeeded after approval for registry access.
- `npm.cmd install` succeeded with 16 packages installed.
- npm audit during install reported 0 vulnerabilities.
- `npm.cmd run build` succeeded.
- Generated source stayed under `workspace/`.
- Software Factory validation passed with 304 files checked and 0 warnings.
- Secret scan passed.

## Friction Found

- `npm --version` failed in PowerShell because the `npm.ps1` shim was blocked by execution policy.
- `npm.cmd --version` worked.
- Initial npm scaffold failed under sandboxed registry/cache restrictions.
- npm cache placed at the project wrapper root can interfere with artifact validation because `projects/<slug>/` outside `workspace/` is scanned for Markdown and JSON artifacts.
- Project status alignment expects `current_phase` to match the checklist phase id or name. `testing-verification` did not match `Testing / Verification`, so the wrapper was corrected to use the checklist phase name.

## Useful Lessons

- Windows guidance should prefer `npm.cmd` when PowerShell execution policy blocks npm's `.ps1` shim.
- Dependency scaffold commands should use a cache path under `workspace/` or remove generated wrapper-root cache before validation.
- Dependency-based proofs need explicit registry approval in sandboxed environments.
- The current validator correctly catches phase-name drift between `status.json` and `project-checklist.json`.

## Current State

The proof project is closed:

- state: `completed-proof`
- current phase: `Testing / Verification`
- gate: `passed`

The human approved closing the proof gate in the Codex thread on 2026-06-21. The remaining findings are framework guidance follow-ups, not proof blockers.

## Validation Commands

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 status -Project dependency-scaffold-proof
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 secret-scan
```

Results:

- Project status reports `completed-proof`, `Testing / Verification`, and gate `passed`.
- Artifact validation passed with 304 files checked and 0 warnings.
- Secret scan passed.

## Recommended Follow-Up

After human approval, consider a tiny framework documentation update:

- add a Windows note that `npm.cmd` may be needed when `npm.ps1` is blocked;
- add dependency scaffold guidance to place package-manager caches under `workspace/` or another validator-skipped path.
