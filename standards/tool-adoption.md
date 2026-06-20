# Tool Adoption Standard

Use this standard before adding a tool, service, platform, MCP server, database, message broker, dependency family, or workflow engine to Software Factory or to a generated project.

The goal is to keep the factory useful, local-first, inspectable, and modular. A tool is welcome when it solves a real problem with acceptable cost. A tool should not be added because it is popular, powerful, or interesting.

## Default Rule

Start with the smallest local-first tool that satisfies the approved need.

Prefer:

- files before databases;
- local commands before workflow engines;
- local logs before monitoring stacks;
- Docker Compose before Kubernetes;
- Markdown and JSON before external project-management platforms;
- optional adapters before mandatory platform dependencies.

## Approval Required

Human approval is required before adding any tool that:

- changes project architecture;
- adds a major dependency or service;
- requires a system-wide install;
- uses cloud resources;
- may cost money now or later;
- collects, stores, sends, or indexes sensitive data;
- requires authentication, tokens, or accounts;
- changes publishing, deployment, or GitHub behavior;
- creates a long-running background service;
- changes how agents coordinate or act autonomously.

If the tool is project-shaping, record the decision in the relevant project artifact or an ADR.

## Adoption Test

Before recommending adoption, answer these questions in plain language:

1. What exact problem does this tool solve?
2. What current tool, file, script, or process would it replace or improve?
3. Is the problem already painful enough to justify the tool?
4. Can the core workflow still run without it?
5. Is there a local-first alternative?
6. What does the human need to install, configure, or learn?
7. Does it require accounts, cloud services, credentials, or paid plans?
8. What data can it read, write, store, or transmit?
9. How will agents access it safely?
10. How will we verify that it works?
11. How will we remove or replace it later?

If these answers are weak, defer the tool.

## Classification

Classify proposed tools with one of these statuses:

- `core`: required for the framework's normal local workflow.
- `preferred`: recommended starting point when its problem appears.
- `optional`: useful adapter, integration, or project-specific choice.
- `deferred`: promising, but not justified yet.
- `restricted`: use only after explicit approval because of cost, cloud, security, privacy, operational, or complexity risk.
- `rejected-for-now`: do not add until a future decision changes this.

Do not treat `known` or `interesting` as approval.

## Core Tool Criteria

A tool may become core only when all of these are true:

- it supports the phase workflow directly;
- it is needed across most projects or framework operations;
- it has low setup burden;
- it works locally or has a local fallback;
- it does not create unnecessary vendor lock-in;
- its failure mode is understandable to a non-expert human;
- it has clear validation and troubleshooting steps.

## Optional Adapter Criteria

Prefer optional adapters when a tool is useful but not universally needed.

Good adapter examples:

- GitHub publishing when the human chooses GitHub;
- Docker Compose for multi-service projects;
- SQLite for local data apps;
- Jupyter for education or data exploration;
- Obsidian as a human knowledge interface over Markdown files;
- Chroma for targeted semantic search after retrieval pain is proven.

Adapters must not block the plain local workflow.

## Deferral Criteria

Defer tools when they:

- require long-running infrastructure before the project has services;
- duplicate an existing local workflow;
- are mostly cloud-based while a local option is good enough;
- require significant maintenance or troubleshooting;
- solve scale problems the project does not have;
- encourage agents to hide state outside the repo;
- make the project harder for a nontechnical human to understand.

## Security And Privacy Review

Before adopting a tool that touches data, credentials, repositories, or external networks, check:

- what data leaves the local machine;
- what files or folders it can access;
- where credentials are stored;
- whether `.env`, ignored files, or secret stores are needed;
- whether generated projects might accidentally commit secrets;
- whether logs, traces, indexes, or caches contain private content;
- whether uninstalling the tool leaves private data behind.

When in doubt, create a human-action file instead of silently asking the human to install or authenticate.

## Documentation Required

For an approved tool, document:

- status and responsibility;
- install requirements;
- local setup commands;
- verification commands;
- project-local versus system-wide dependency strategy;
- risks and tradeoffs;
- when to avoid it;
- removal or replacement path.

Update `tools/registry.md` for framework-level tools and the active project's architecture or environment artifacts for project-level tools.

## Hard Guardrails

Do not add these to the core workflow without a new explicit decision:

- Kubernetes or Minikube;
- Temporal;
- RabbitMQ;
- Redis as coordination infrastructure;
- Prometheus, Grafana, or OpenTelemetry;
- Jira, ClickUp, Trello, Confluence, or Miro;
- broad automatic Chroma indexing;
- cloud-only workflow dependencies;
- paid services.

These tools may still be useful later. They are not starter dependencies.

