# Local Command Runner

Software Factory includes an optional repo-local command runner at `tools/factory.ps1`.

The runner is not an installed CLI and does not replace Codex workflow prompts. It is a small convenience wrapper for repeatable local checks and read-only status views.

## Usage

Run commands from the Software Factory repo root:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 help
```

## Commands

| Command | Purpose | Mutates Project State |
| --- | --- | --- |
| `help` | Show available commands. | No |
| `doctor` | Check that core framework files, schemas, scripts, and Git are available. | No |
| `status` | Show active or named project status. | No |
| `validate` | Run artifact validation across templates and projects. | No |
| `secret-scan` | Run tracked-file secret scan. | No |
| `toolbox` | Show registered tools grouped by status. | No |
| `event` | Append a local ignored JSONL event. | Local logs only |
| `events` | Show recent local ignored JSONL events. | No |
| `tasks` | Show file-based task records. | No |

Use a named project with:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 status -Project portfolio
```

## Boundaries

The local runner must not:

- create projects;
- advance phases;
- approve gates;
- install dependencies;
- create GitHub repositories;
- push, publish, deploy, or release;
- edit artifacts;
- hide human approval decisions behind automation.

The `event` command may append to ignored local log files. It must not be used as the authoritative record for phase state, approvals, requirements, architecture, verification, review, shipping, or memory.

## Local Events

Framework event:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 event -EventType validation-run -Summary "Ran artifact validation"
```

Project event:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 event -Project portfolio -EventType follow-up-note -Summary "Discussed publishing options"
```

View recent events:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 events
```

See [../standards/local-logs-events.md](../standards/local-logs-events.md).

Those actions remain Codex-led and human-approved until a later explicit decision expands automation.

## Task Records

View all task records:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 tasks
```

View task records for one project:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 tasks -Project portfolio
```

The runner does not create or approve tasks. See [../standards/file-based-task-records.md](../standards/file-based-task-records.md).

## Design Direction

The runner is intentionally PowerShell-first because the current development environment is Windows and the repo already uses PowerShell validation scripts.

If this grows beyond simple wrappers, evaluate whether to keep PowerShell, add a `factory` CLI, or use Taskfile. Apply `standards/tool-adoption.md` before promoting a new command system.
