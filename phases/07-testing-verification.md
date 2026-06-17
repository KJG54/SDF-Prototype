# Phase 7: Testing / Verification

## Purpose

Prove the project works for the human.

## Agent Responsibilities

- Run technical checks.
- Test core workflows.
- Provide clear manual testing instructions.
- Summarize pass/fail results.
- Keep investigating failures until fixed or clearly blocked.
- Ask the human to verify subjective, visual, interactive, or goal-fit behavior.
- Keep a clear list of what passed, failed, needs retest, or was deferred.
- Update `PROJECT-CHECKLIST.md` and `project-checklist.json`.

## Human Responsibilities

- Test subjective or interactive behavior when needed.
- Confirm whether the result works as intended.

## Required Output

- `VERIFY-001-verification-report.json` / `VERIFY-001-verification-report.md`
- `UAT-001-user-acceptance-testing.json` / `UAT-001-user-acceptance-testing.md` when human testing is needed
- Human-action files when the human must test something manually
- Phase gate
- Phase summary
- Known issues, if any

## Questions To Ask During This Phase

- What exact workflow should we test first?
- Did the app/tool/game behave the way you expected?
- What felt confusing, broken, slow, ugly, or annoying?
- Are there any must-fix issues before review?
- Are any failures acceptable to defer, or should I fix them before we move on?
- Do you approve the current verification result as good enough for review?

## Exit Criteria

The project passes technical checks and the human confirms interactive or subjective acceptance where relevant.

The phase must not close with unresolved test failures unless the human explicitly approves deferral.

## Closeout Prompt

Summarize automated checks, manual checks, human acceptance results, failures fixed, failures deferred, and remaining risks. Then ask whether the human approves moving to Review.
