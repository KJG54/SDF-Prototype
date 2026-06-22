# Software Factory Workflow Playbook

Use for Software Factory framework changes, Codex workflow prompts, reserved slash-command behavior, Codex skills, agent procedures, templates, standards, playbooks, and framework-level automation.

Prioritize:

- command or skill trigger wording
- workflow boundaries
- artifact and schema impact
- human approval gates
- installability and portability
- validation and dry-run behavior
- avoiding claims of unsupported native slash-command registration

## Planning Requirements

- Keep the framework local-first and file-first.
- Treat native slash commands as reserved/documented names unless Codex supports project-local command registration.
- Prefer a Codex skill for reusable agent behavior that can work now.
- Keep canonical skill or command source in the repo when it is part of Software Factory.
- Create human-action files for manual skill installs or any setup outside normal conversation.
