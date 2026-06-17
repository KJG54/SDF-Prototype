# Phase Rules

Software Factory projects move through phases:

1. Vision Interview
2. Requirements
3. Tech Stack / Architecture
4. Build Plan
5. Scaffold
6. Implementation
7. Testing / Verification
8. Review
9. Ship
10. Memory / Lessons Learned

Each phase should produce a short human summary and update `PROJECT-CHECKLIST.md` and `project-checklist.json`. Project-shaping phase exits require human approval.

Agents may move backward when new information invalidates earlier assumptions. When that happens, explain why and update artifacts.

## Phase Gate

Every phase must pass a phase gate before moving forward.

Required checks:

- `PROJECT-CHECKLIST.md` and `project-checklist.json` reflect the current phase state.
- Required artifacts for the phase exist.
- Paired Markdown and JSON artifacts are aligned.
- Known errors in the current phase are fixed.
- Any unresolved error is explicitly deferred by the human or documented as naturally resolved by a later phase.
- Required human actions are completed or intentionally deferred by the human.
- Open questions that affect scope, architecture, privacy, security, cost, runtime, or shipping are answered.
- The agent has summarized what was done in plain language.
- The agent has stated the next recommendation.
- The human has approved moving to the next phase.

The agent must not move to a new phase just because implementation work is finished. The phase changes only after the gate passes.

## Phase Closeout Format

At phase closeout, the agent should provide:

- What was completed.
- What changed in the project.
- What the human needs to check.
- Any errors, risks, or deferred issues.
- The recommended next phase.
- A direct approval question.
