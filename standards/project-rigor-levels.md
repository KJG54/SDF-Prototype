# Project Rigor Levels

Use this to scale process, testing, documentation, security, and shipping expectations to the actual project.

The goal is proportional quality. Small projects should stay lightweight. Projects with users, money, sensitive data, or public release need stronger discipline.

## Required Use

During Startup or Requirements, classify the project into one rigor level. Revisit the level when scope, audience, data, deployment, or business use changes.

The level should be recorded in `STARTUP-001` or `REQ-001`, and its implications should appear in architecture, build planning, testing, review, and shipping artifacts.

## Levels

### Level 0: Exploration

Use for throwaway experiments, quick technical spikes, and learning exercises.

Expected rigor:

- Minimal artifacts.
- Clear statement that the result is not production-ready.
- Basic run check.
- No shipping claims unless reclassified.
- Known risks can be brief but should not be hidden.

### Level 1: Personal Local Tool

Use for one-person tools, local utilities, small automations, and apps that do not handle sensitive data beyond the human's own local files.

Expected rigor:

- Normal phase artifacts.
- Simple architecture and dependency plan.
- Local setup and run instructions.
- Basic build or smoke test.
- Manual walkthrough of core workflows.
- Secret scan before any push if credentials were used.

### Level 2: Shareable Project

Use for public GitHub projects, portfolio apps, demos meant for others, and tools the human expects to revisit or share.

Expected rigor:

- Clear requirements and success criteria.
- README, setup, run, and troubleshooting notes.
- Lockfiles or equivalent dependency reproducibility.
- Build, lint/type check, and practical automated tests where available.
- Manual verification of main workflows.
- Security and privacy review appropriate to the app surface.
- Known issues and deferred work documented before shipping.

### Level 3: Internal Or Business Tool

Use for tools that support real work, affect business decisions, store meaningful user data, integrate with external services, or may be used by more than one person.

Expected rigor:

- Explicit data, privacy, permissions, and failure-mode review.
- Stronger test coverage around important workflows.
- Clear operational notes, backup/recovery expectations when relevant, and deployment/runbook guidance.
- Dependency and supply-chain review appropriate to the stack.
- User acceptance testing notes.
- Approval before adding paid services, cloud resources, authentication, or sensitive data storage.

### Level 4: Public Product Or Critical System

Use for paid products, public production systems, regulated/sensitive data, authentication-heavy systems, and software people materially depend on.

Expected rigor:

- Formal architecture and security review.
- Defined deployment, rollback, monitoring, incident, and support expectations.
- Meaningful automated tests across critical behavior.
- Accessibility, privacy, legal/license, and operational reviews when relevant.
- Clear release criteria and shipping approval.
- Avoid rushing through phase gates.

## Default Recommendation

If unsure, start at the lowest level that honestly fits the project:

- personal experiment: Level 0
- personal useful app: Level 1
- public GitHub or portfolio project: Level 2
- team/business use: Level 3
- paid/public production or sensitive system: Level 4

Do not use a high rigor level to inflate process. Do not use a low rigor level to avoid real risk.

## Upgrade Triggers

Reclassify upward when the project adds:

- other users;
- public release;
- payment, authentication, or accounts;
- sensitive personal, financial, health, business, or private data;
- cloud deployment or external APIs with meaningful risk;
- irreversible actions such as deleting files, sending messages, or changing records;
- business-critical workflows;
- legal, compliance, or licensing concerns.

Reclassify downward only when scope is intentionally reduced and the human approves the change.

## Agent Behavior

When recommending a rigor level, explain:

- the chosen level;
- why it fits;
- what extra work it creates;
- what work it avoids;
- what would trigger a higher level.

Ask for human approval when the rigor level changes project expectations, timeline, dependencies, cost, privacy, security, deployment, or shipping.
