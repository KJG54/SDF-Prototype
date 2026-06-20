# Deferred Work

Use this file for known useful work that should not be implemented in v1 without deeper discussion.

## Deferred Items

- `factory` CLI implementation
- Native Codex command registration
- Full phase-gate enforcement tooling beyond current validation and semantic checks
- Chroma or equivalent memory index
- Automated audit commands beyond the current local runner checks
- Broad dependency reproducibility checks for generated projects across stacks
- Automated Rust/Tauri supply-chain audit tooling beyond current guidance
- Automated model routing
- GUI for nontechnical users
- GitHub repo creation and push automation
- Dedicated success-definition artifact
- Formal effort, token, and cost estimates in build plans
- Reusable code templates for specific stacks
- Deeper tool registry lifecycle policy
- Generated-project nested-repository migration strategy
- Advanced project backlog system
- Installer packaging playbooks for desktop apps
- Cleanup workflow automation after the manual cleanup decision process is proven
- Idea intake schema and runner support beyond the documented plan

## No Longer Deferred As Whole Items

- Lightweight artifact validation exists through `tools/artifact-validate.ps1`.
- Core JSON Schema contracts are wired into artifact validation.
- Lightweight semantic checks now cover project state references, status/checklist identity drift, active phase alignment, phase-gate approval consistency, and blocking gate conditions.
- Rust/Tauri dependency audit guidance exists as documentation and is connected to relevant standards and phase docs.
- File-based task records and local JSONL events exist as local-first coordination support.

## Rule

Deferred items are not approved scope. Before implementing one, Codex should discuss the value, cost, risk, timing, and implementation path with the human.
