# Tool Registry

This registry tracks tools, MCP servers, plugins, skills, and services that may help Software Factory projects.

Statuses:

- `known`
- `preferred`
- `approved`
- `restricted`
- `deprecated`

The registry is a map, not permission to use every tool automatically.

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
| Git | preferred | Source control and GitHub-ready handoff. |
| VS Code | preferred | Default editor unless the human prefers another. |
| Node.js | known | Required for JavaScript/TypeScript, Vite, and many frontend tools. |
| Python | known | Required for Python scripts, CLIs, and FastAPI projects. |
| Rust toolchain | known | Required for Tauri and Rust projects. |
| Docker | known | Use when it reduces service setup or improves reproducibility. Do not force it by default. |

Use `standards/stack-profiles.md` for profile details and `standards/project-rigor-levels.md` to decide how much testing, security, documentation, and shipping discipline to apply.
