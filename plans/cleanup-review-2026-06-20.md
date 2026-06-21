# Cleanup Review - 2026-06-20

## Purpose

This is the first cleanup candidate review under `standards/cleanup-workflow.md`.

The human approved selectively keeping helpful `Explanation.md` files. Boilerplate ignored explanation notes were removed, while useful local orientation notes were kept.

## Baseline

Recent checks before this review:

- `tools\factory.ps1 doctor`: passed.
- `tools\factory.ps1 validate`: passed, 273 files checked, 0 warnings.
- `tools\factory.ps1 secret-scan`: passed.

## Candidate Summary

| Path | Category | Recommendation | Approval Needed | Reason |
| --- | --- | --- | --- | --- |
| `CHANGELOG.md` | update | Fixed the control-character typo before `factory.config.json`. | no | Obvious text damage in a tracked public doc. |
| `Explanation.md` files across framework folders | delete / keep | Kept 13 helpful local orientation notes and deleted 81 boilerplate ignored notes. | approved and done | The kept notes explain the private vault taxonomy, local project boundary, and local project wrapper purposes. |
| `FRAMEWORK-IDEAS.md` | update / private | Keep private, then clean encoding damage and loose trailing bullets during idea intake. | no for cleanup edits; yes before publishing | It is an ignored scratchpad with useful raw ideas, not approved framework scope. |
| `PROJECT-IDEAS.md` | update / private | Keep private, then clean encoding damage and loose trailing bullets during idea intake. | no for cleanup edits; yes before publishing | It is an ignored scratchpad with useful raw project ideas, not approved project scope. |
| `commands/potential-future-commands.md` | update or merge | Clean the rough bullets now, or merge later into idea intake / command planning. | yes if merged or removed | It contains a useful `/clean-up` idea, but the file is rough and overlaps future intake work. |
| `.env` | private | Leave ignored and do not inspect content unless a secret-safety task requires it. | yes before deletion or publication | It is intentionally ignored local environment state. |
| `.remember/` logs | private | Leave ignored; optionally offer disk cleanup later if the human wants it. | yes before deletion | Local automation/log state, not framework content. |
| `projects/recipe-keeper/workspace/` generated outputs | private | Leave ignored; optionally offer disk cleanup later if the human wants to reclaim space. | yes before deletion | Generated project build/cache output under ignored `projects/`. |
| `roles/README.md` | keep for now | Keep separate until role/skill/operating model guidance is tested on a real project. | yes before merge | It may overlap agent docs, but it now supports the operating model discussion. |

## Recommended Next Actions

1. Defer `FRAMEWORK-IDEAS.md` and `PROJECT-IDEAS.md` cleanup to the Control The Inflow lane.
2. Keep private/generated outputs ignored unless the human explicitly asks for disk cleanup.
3. Decide later whether `commands/potential-future-commands.md` should remain separate after idea intake is tightened.

## Kept Explanation Notes

- `memory/vault/Explanation.md`
- `memory/vault/00-session-summaries/Explanation.md`
- `memory/vault/01-user-preferences/Explanation.md`
- `memory/vault/02-framework-decisions/Explanation.md`
- `memory/vault/03-project-history/Explanation.md`
- `memory/vault/04-known-problems/Explanation.md`
- `memory/vault/05-reusable-patterns/Explanation.md`
- `memory/vault/06-reference/Explanation.md`
- `memory/vault/sessions/Explanation.md`
- `projects/Explanation.md`
- `projects/portfolio/Explanation.md`
- `projects/recipe-keeper/Explanation.md`
- `projects/toolbox-smoke-test/Explanation.md`

## Approval Needed Before Action

Explicit approval is needed before:

- merging or removing `commands/potential-future-commands.md`;
- deleting `.remember/` logs or generated project output;
- changing `.gitignore` behavior;
- publishing ignored scratchpads or vault memory.
