# Human Approval Rules

Human approval is required before:

- major scope changes
- architecture changes
- adding major dependencies
- adding paid services
- using cloud resources
- deployment or publishing
- GitHub repo creation or push
- authentication or payment systems
- databases or external APIs with meaningful risk
- collecting, storing, or sending sensitive data
- destructive filesystem or repository actions
- legal or license decisions when they matter
- moving from one phase to the next

## Approval Format

Approval artifacts should include:

- what is being approved
- why it matters
- risks and tradeoffs
- alternatives considered
- human decision
- date

Phase-move approvals can be lightweight, but they must be explicit. The agent should summarize what was completed, identify any unresolved or deferred issues, recommend the next phase, and ask the human to approve moving forward.
