# Project Operating Tiers

Use this during Startup to decide how much agent process, questioning, detail, and coordination a project deserves.

Operating tier is different from project rigor level:

- Rigor level measures risk, audience, data sensitivity, and shipping seriousness.
- Operating tier measures how much process and agent effort to spend.

A project can be low-risk but high-touch if the human wants to learn deeply. A project can also be quick-moving but still require security checks if it touches sensitive data.

## Required Use

During Phase 0 Startup, recommend an operating tier and record it in `STARTUP-001` and `OPERATING-001`.

Revisit the operating tier when the human changes speed, learning, quality, documentation, collaboration, or token/time expectations.

## Tiers

### Tier 1: Full Operating Model

Use when the project is important, complex, educational, business-facing, public, or likely to become reusable.

Agent behavior:

- Ask more questions before committing direction.
- Create detailed artifacts and explanations.
- Use role/personality/skills planning explicitly.
- Consider Claude for review, debugging, implementation, or second opinions.
- Document tradeoffs, risks, alternatives, and decisions carefully.
- Prefer stronger verification and handoffs.

Best fit:

- Serious apps, business tools, public releases, learning projects where the human wants depth, and projects with meaningful uncertainty.

### Tier 2: Standard Guided Project

Use for normal Software Factory projects.

Agent behavior:

- Use the full phase flow, but keep artifacts concise.
- Ask balanced questions.
- Record role, skills, commands, and artifacts in short form.
- Use Claude only when it clearly helps.
- Verify core behavior without over-documenting obvious choices.

Best fit:

- Most useful personal apps, shareable projects, portfolio projects, and normal prototypes.

### Tier 3: Lean Build

Use when speed matters and the project is simple, but the human still wants the framework to keep state and approvals straight.

Agent behavior:

- Ask only the questions needed to avoid bad assumptions.
- Use compact artifacts.
- Choose one primary agent role and only the necessary skills.
- Prefer existing templates and defaults.
- Keep explanations short unless the human asks for more.
- Do not skip safety, privacy, dependency, or approval checks when they are relevant.

Best fit:

- Small utilities, simple sites, local automations, and quick but useful prototypes.

### Tier 4: Fast MVP

Use when the human wants the simplest usable version with minimal ceremony.

Agent behavior:

- Create the smallest viable project wrapper and operating model.
- Ask only blocking questions.
- Use defaults aggressively and state them plainly.
- Keep artifacts very short.
- Avoid optional roles, extra reviews, embellishments, and speculative planning.
- Run only essential checks for the approved scope.
- Escalate if the project introduces real risk, public shipping, sensitive data, paid services, or irreversible actions.

Best fit:

- Tiny experiments, throwaway prototypes, and quick proof-of-concept work.

## Tier Selection Questions

Ask only enough to choose safely:

- Is speed or thoroughness more important right now?
- Is this for learning, personal use, public sharing, business use, or production?
- Should Codex explain decisions deeply or keep moving?
- Is this project likely to handle sensitive data, money, auth, public users, or real business workflows?
- Is Claude useful for this project, or should Codex keep it simple?

## Risk Floor

Operating tier cannot reduce required safety.

If a Tier 4 project includes sensitive data, auth, payments, public deployment, destructive actions, legal concerns, or business-critical behavior, the agent must still apply the relevant rigor-level expectations and ask for approval where required.

## Startup Recording

Record:

- selected tier;
- why it fits;
- what the tier changes about agent behavior;
- what it intentionally avoids;
- what would trigger moving to a higher-touch tier;
- primary agent role;
- desired agent posture/personality;
- skills likely needed;
- workflow prompts likely used;
- artifacts expected.

