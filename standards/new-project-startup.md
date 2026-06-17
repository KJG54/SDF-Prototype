# New Project Startup Standard

Use this at the beginning of every Software Factory project before the Vision Interview gets deep.

The goal is to make the first few minutes consistent without making them rigid.

## Startup Checklist

The agent should confirm:

- What the human wants to build.
- Who the project is for.
- What the project should help someone do.
- Whether the project is personal, public, business, learning, internal, or experimental.
- The human's technical experience and preferred explanation level.
- The human's question preference.
- The development computer and operating system.
- The preferred IDE/editor.
- Whether the human can install tools.
- Where the finished project should run.
- Whether broad platform support is expected.
- Whether dependencies should be project-local when practical.
- Whether Docker, Conda, Python virtual environments, dev containers, or similar isolation tools are acceptable.
- Known constraints, examples, styles, required tools, privacy concerns, or deadlines.

## Agent Behavior

- Ask enough questions to understand the goal, but do not turn startup into a long form if the human is already clear.
- Explain that the first version will be intentionally scoped.
- Separate user-requested scope from agent-suggested ideas.
- Surface obvious risks early.
- Create or update `STARTUP-001` when a project begins.
- Move into the Vision Interview only after the startup context is clear enough.

## Exit Criteria

- The human has described the project in plain language.
- The development environment context is known or marked as an open question.
- The target platform context is known or marked as an open question.
- The agent can begin the Vision Interview with enough context to ask smarter follow-up questions.
