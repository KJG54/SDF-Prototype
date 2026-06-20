# Starter Toolbox Decision

This document records the current Software Factory toolbox policy after reviewing `sdf_toolbox_discussion_summary.md`.

The decision is conservative: keep the framework local-first, file-first, and simple enough for a human to inspect. Add tools as adapters when they solve a proven problem.

## Core Now

These are part of the normal framework direction.

| Tool Or Practice | Responsibility | Notes |
| --- | --- | --- |
| Git | Version history, rollback, review, handoff | Foundation for framework and generated projects. |
| Local file system | Project artifacts, source files, logs, memory, templates | Treat files as first-class architecture. |
| Markdown artifacts | Human-readable decisions and phase records | Required for human control. |
| JSON artifacts | Agent-readable state and structured handoffs | Keep paired with Markdown where required. |
| Artifact validation | Catch Markdown/JSON drift | Use `tools/artifact-validate.ps1` and manual review. |
| Secret safety rules | Avoid credential leakage | `.gitignore`, `.env.example`, secret scans, safe templates. |
| Stack-specific tests, linters, and formatters | Verify generated projects | Chosen per approved stack, not globally forced. |
| Local logs and events | Explain what happened | Use `standards/local-logs-events.md`; prefer JSONL before metrics stacks. |
| File-based task records | Coordinate planned work | Use `standards/file-based-task-records.md`; avoid external task managers early. |
| Local command runner | Repeat safe local checks and read-only views | Use `tools/factory.ps1`; keep phase decisions in Codex. |
| ADRs or decision records | Record meaningful architecture/tool choices | Use for project-shaping decisions. |
| Mermaid | Lightweight diagrams in Markdown | Prefer before heavier architecture diagram tools. |

## Build Next

These are the next practical framework improvements.

| Capability | Why It Comes Next |
| --- | --- |
| Project template verification commands | Standardize setup, test, lint, build, and run checks. |
| Schema refinement | Tighten semantic validation after the broad artifact schemas prove stable. |

## Preferred When Needed

These should be recommended when the project actually needs them.

| Tool | Use When | Avoid When |
| --- | --- | --- |
| Docker | Service setup or reproducibility would otherwise be painful | A language runtime or static files are simpler. |
| Docker Compose | A project needs app plus database, cache, or other local services | A single-process app is enough. |
| SQLite | Local-first structured data is needed | Shared multi-user concurrency is central. |
| PostgreSQL | A backend project needs stronger relational data support | SQLite satisfies V1. |
| Taskfile or Makefile | Repeated local commands become hard to remember | Existing scripts are enough. |
| GitHub | The human wants remote backup, collaboration, or publishing | Local-only work is the goal. |
| GitHub Actions | A GitHub project needs cloud CI | Local checks are enough. |
| Obsidian | The human wants a local knowledge interface over Markdown | Repo docs are enough. |
| Obsidian Canvas or Excalidraw | Visual planning helps the human | Mermaid or plain Markdown is enough. |
| Jupyter | Education, notebooks, data analysis, or experiments are central | Building normal apps or services. |

## Deferred

These are reasonable later, but not starter dependencies.

| Tool | Defer Until |
| --- | --- |
| Chroma | Exact search and curated project memory are not enough. |
| MCP servers beyond built-in needs | There is a specific safe tool boundary to expose. |
| Local LLMs through Ollama | There is a clear low-risk helper task and hardware is acceptable. |
| Redis | There are real queues, caches, or event streams to manage. |
| RabbitMQ | Multiple always-running services need reliable asynchronous messaging. |
| Prometheus | There are long-running services with metrics worth collecting. |
| Grafana | Metrics exist and a dashboard would help real decisions. |
| OpenTelemetry | Multi-service tracing is needed for debugging or operations. |
| Structurizr | Mermaid and ADRs cannot explain the architecture well enough. |
| Temporal | CLI and file-based orchestration are clearly insufficient. |

## Do Not Add Now

These should not be added to Software Factory core at this stage.

| Tool | Reason |
| --- | --- |
| Kubernetes | Solves cluster-scale deployment, not current local workflow. |
| Minikube | Brings Kubernetes complexity without a near-term need. |
| Temporal | Too heavy before durable workflow pain is proven. |
| RabbitMQ as starter infrastructure | Requires service operations before async scale exists. |
| Redis as starter coordination | File events are enough until live queues or caches exist. |
| Prometheus/Grafana/OpenTelemetry | Observability stack is premature without services. |
| Jira/ClickUp/Trello | Duplicate local task artifacts and weaken local-first control. |
| Confluence | Duplicates Markdown/Obsidian-style docs and is cloud-oriented. |
| Miro | Cloud visual planning; prefer local Markdown, Mermaid, Obsidian Canvas, or Excalidraw. |
| Broad Chroma indexing | Creates noisy context, privacy risk, and hidden state. |
| Paid cloud services | Not acceptable as core dependencies. |

## Responsibility Map

Each responsibility should have one primary starter answer.

| Responsibility | Starter Answer |
| --- | --- |
| Version control | Git |
| Project state | Markdown and JSON artifacts |
| Human-facing docs | Markdown |
| Machine-readable contracts | JSON plus core JSON Schema |
| Commands | `tools/factory.ps1` plus focused PowerShell scripts; CLI or Taskfile later if justified |
| Tool decisions | `standards/tool-adoption.md` and ADRs |
| Diagrams | Mermaid |
| Tasks | File-based task records following `standards/file-based-task-records.md` |
| Events | Ignored JSONL files following `standards/local-logs-events.md` |
| Observability | Local logs first |
| Containers | Docker Compose only when useful |
| Remote hosting | GitHub optional |
| Knowledge base | Repo Markdown first; Obsidian optional |
| Semantic memory | Curated search first; Chroma later |

## Decision Notes

The toolbox discussion file is useful input, not approved implementation scope.

The approved direction is:

- strengthen standards before adding dependencies;
- make local validation and command workflows better;
- keep heavyweight systems deferred;
- treat cloud and paid tools as optional, explicit decisions;
- let generated projects choose tools based on their requirements rather than inheriting a bloated factory stack.
