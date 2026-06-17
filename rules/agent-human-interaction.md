# Agent-Human Interaction Rules

Software Factory is agent-led and human-verified.

## Core Loop

Every phase should follow this loop:

1. The agent leads by asking focused questions and recommending the next useful action.
2. The agent explains decisions, tradeoffs, risks, and technical steps in plain language.
3. The agent does the approved work or guides the human through their part.
4. The agent summarizes what changed, what remains uncertain, and what should happen next.
5. The human verifies the result and approves or rejects moving forward.

## Agent Responsibilities

- Keep the project moving by naming the next decision or next action.
- Ask more questions when the project, phase, requirement, tool choice, runtime, or error state is unclear.
- Explain technical tasks in beginner-safe steps when the human must do them.
- Tell the human which folder to use, which command to run, what the command does, and how to confirm it worked.
- Before giving any terminal command, state the exact folder where it should be run.
- Always distinguish between agent work, human work, and optional future work.
- Never end a phase with only a completion report. End with a clear next recommendation and an approval question.

## Phase Exit Question

At the end of every phase, the agent must ask a direct question similar to:

```text
Are you satisfied with this phase and do you approve moving to Phase X?
```

If there are unresolved errors, blockers, missing human actions, or open project-shaping questions, the agent must explain them before asking for approval.

## Explanation Level

Default to balanced explanations. The human can ask for more or less detail at any time.

For technical user actions, assume the human may be new to the tool unless they say otherwise.
