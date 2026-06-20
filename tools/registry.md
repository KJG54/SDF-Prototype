# Tool Registry

This registry tracks tools, MCP servers, plugins, skills, and services that may help Software Factory projects.

Statuses:

- `known`
- `core`
- `preferred`
- `approved`
- `optional`
- `deferred`
- `restricted`
- `deprecated`
- `rejected-for-now`

The registry is a map, not permission to use every tool automatically.
Use `standards/tool-adoption.md` before promoting a tool or making it a dependency.

## Current State

The registry is intentionally small. These entries are preferred starting points, not automatic approval for every project.

## Preferred Stack Profiles

| Profile | Status | Best Fit | Notes |
| --- | --- | --- | --- |
| Static Website | preferred | Simple sites, docs, landing pages | Avoid backend-shaped needs unless explicitly scoped. |
| Vite React Web App | preferred | Interactive browser apps and polished prototypes | Use TypeScript when maintainability matters. |
| Tauri Desktop App | preferred | Local-first desktop apps needing native shell behavior | Higher setup burden; document system prerequisites. |
| Python CLI Or Local Automation | preferred | Scripts, file processing, local tools | Use project-local virtual environments. |
| FastAPI Backend | known | APIs and Python-backed services | Adds server and deployment responsibility. |
| Local-First SQLite App | preferred | Personal/local data apps | Document database path, backup/export, and migration expectations. |

## Foundational Tools

| Tool | Status | Use |
| --- | --- | --- |
| Git | core | Source control, rollback, review, and GitHub-ready handoff. |
| Local file system | core | Project artifacts, source files, logs, memory, templates, and handoffs. |
| Markdown + JSON artifacts | core | Human-readable and agent-readable project state. |
| Artifact validation | core | Catch drift between paired Markdown and JSON artifacts; run core JSON Schema checks. |
| JSON Schema contracts | core | Machine-readable contracts for project status, checklists, gates, summaries, tasks, common phase artifacts, actions, and approvals. |
| Local command runner | core | Optional repo-local PowerShell runner for safe checks and read-only status views. |
| Local logs and events | core | Ignored JSONL event files for troubleshooting breadcrumbs; artifacts remain authoritative. |
| File-based task records | core | Markdown/JSON task records for coordination without external task managers or brokers. |
| Tauri dependency audit | core | Rust/Cargo, frontend dependency, permission, webview, and local-data audit guidance for Tauri desktop apps. |
| Secret safety rules | core | Avoid committing credentials or unsafe local configuration. |
| Mermaid | preferred | Lightweight diagrams inside Markdown. |
| VS Code | optional | Default editor suggestion unless the human prefers another. |
| Node.js | known | Required for JavaScript/TypeScript, Vite, and many frontend tools. |
| Python | known | Required for Python scripts, CLIs, and FastAPI projects. |
| Rust toolchain | known | Required for Tauri and Rust projects. |
| Docker | preferred | Use when it reduces service setup or improves reproducibility. Do not force it by default. |
| Docker Compose | preferred | Use for local multi-service project templates when needed. |
| GitHub | optional | Remote backup, collaboration, publishing, and optional CI. |
| GitHub Actions | optional | Cloud CI for GitHub projects; keep local checks equivalent. |
| Obsidian | optional | Local knowledge interface over Markdown files. |
| Chroma | deferred | Targeted semantic search after retrieval pain is proven; avoid broad indexing. |
| Kubernetes | rejected-for-now | Too heavy for current local-first workflow. |
| Minikube | rejected-for-now | Defer with Kubernetes. |
| Temporal | deferred | Consider only if CLI and file-based orchestration become insufficient. |
| Redis | deferred | Consider only for real queues, caches, or event streams. |
| RabbitMQ | deferred | Consider only for reliable async messaging between multiple services. |
| Prometheus/Grafana/OpenTelemetry | deferred | Add only after long-running services need observability. |
| Jira/ClickUp/Trello/Confluence/Miro | rejected-for-now | Cloud-oriented and redundant with local files, Markdown, and optional Obsidian. |

Use `standards/stack-profiles.md` for profile details, `standards/project-rigor-levels.md` to decide how much testing, security, documentation, and shipping discipline to apply, and `standards/starter-toolbox.md` for the current toolbox decision.
