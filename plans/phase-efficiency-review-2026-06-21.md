# Phase Efficiency Review - 2026-06-21

## Purpose

Review the Software Factory phase files for unnecessary ceremony, unclear artifacts, missing gates, and token-heavy behavior after the Phase 0 proof run.

This review is a recommendation artifact. It does not change phase behavior by itself.

## Review Scope

Reviewed:

- `phases/00-startup.md` through `phases/10-memory-lessons.md`
- `commands/contracts.md`
- `commands/README.md`
- `standards/project-operating-tiers.md`
- `standards/project-rigor-levels.md`
- `standards/tool-adoption.md`
- `standards/starter-toolbox.md`
- `standards/artifact-validation.md`
- artifact template and schema inventory

## Overall Finding

The phase sequence is sound and should stay intact. The main efficiency issue is not that there are too many phases; it is that some phase files do not consistently say how to right-size the work by operating tier and rigor level.

The best next change is a small consistency pass, not a redesign.

## Findings

| Area | Finding | Impact | Recommendation | Approval Needed |
| --- | --- | --- | --- | --- |
| Phase 1 Vision | Vision repeats environment intake already collected during Startup. | Agents may re-ask questions that are already recorded. | Change wording to confirm or update Startup environment context instead of re-asking when known. | no, if wording-only |
| Phase 3 Architecture | Architecture is comprehensive, but heavy for Tier 3/Tier 4 or Level 0/Level 1 projects. | Small projects can feel over-processed. | Add tier-aware language: document the minimum viable architecture for lean projects while preserving tool-adoption and safety checks. | yes, because it affects workflow expectations |
| Phase 4 Build Plan | "Complete plan agents can execute from scaffold to ship" can imply too much planning for simple builds. | Lean projects may get oversized plans. | Change to "right-sized plan" and allow one-screen plans for simple projects. | yes, because it changes planning expectations |
| Phase 5 Scaffold | Scaffold has no explicit closeout prompt or approval question before implementation. | File creation may be completed without a clear human checkpoint. | Add a closeout prompt matching later phases. | yes, because it touches phase advancement wording |
| Phase 6 Implementation | "Delegate to Claude when useful" should reflect the repo rule that Codex asks first. | Delegation boundary is slightly under-specified. | Change to "ask whether Claude would be useful before delegating." | no, clarifies existing rule |
| Phase 7 Testing | Testing is mostly well-scoped and already says depth should match quality level and risk. | Low risk. | Keep as-is, possibly add a compact-check note for Level 0/1 projects later. | no immediate change |
| Phase 8 Review | Review is strong but checklist-like. | Can feel heavy, but most checks are already risk-scoped. | Keep core checks; optionally add "review depth follows approved rigor level." | no, if wording-only |
| Phase 9 Ship | Shipping distinguishes source, package, hosted deployment, and store publication well. | Low risk. | Keep as-is. | no |
| Phase 10 Memory | Memory is much thinner than other phases and lacks closeout guidance. | Project closure and memory promotion can be inconsistent. | Add named `MEMORY-001` output, status/checklist closure expectations, and a closeout prompt. | yes, because it affects final phase closure behavior |
| All phases | Required output wording varies: some use paired names, some use generic "phase summary" or "project status update." | Agents may create inconsistent artifact names. | Standardize output wording around existing templates: `SUMMARY-*`, `GATE-*`, and status/checklist updates. | no, if naming-only |

## Recommended Edit Set

### Safe Clarifying Edits

These can be made without changing approved phase gates:

- Phase 1: confirm/update Startup environment context instead of repeating questions.
- Phase 6: clarify Claude delegation requires asking the human first.
- Phase 8: explicitly say review depth follows the approved rigor level.
- All phases: standardize artifact naming where it only reflects existing templates.

### Approval-Sensitive Edits

These should wait for human approval:

- Phase 3: add tier-aware minimum architecture expectations.
- Phase 4: allow right-sized or one-screen build plans for lean/simple projects.
- Phase 5: add an explicit Scaffold closeout approval prompt before Implementation.
- Phase 10: define final closure expectations and closeout prompt.

## Recommended Next Step

Make one small phase-doc consistency pass that implements the safe clarifying edits and the approval-sensitive edits if the human approves them.

Suggested approval question:

```text
Do you approve updating the phase docs with the recommended efficiency changes, including tier-aware Architecture and Build Plan wording, a Scaffold closeout prompt, and clearer Memory closeout expectations?
```

## Human Decision

Approved on 2026-06-21.

## Applied Edits

- Phase 1 now confirms or updates Startup environment context instead of re-asking it from scratch.
- Phase 3 now says Architecture detail should be right-sized to operating tier and rigor level.
- Phase 4 now supports right-sized and one-screen build plans for lean/simple projects.
- Phase 5 now has a closeout prompt before moving to Implementation.
- Phase 6 now clarifies that Codex asks whether Claude would be useful before delegating.
- Phase 8 now says review depth follows the approved rigor level and operating tier.
- Phase 10 now names the memory packet artifact, final status/checklist update, and closeout prompt.
