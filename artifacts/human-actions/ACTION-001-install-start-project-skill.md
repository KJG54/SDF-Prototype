# ACTION-001: Install SF Start Skill

## Type

recommended

## Status

complete

## What To Do

Install the canonical `sf-start` skill from this repo into your personal Codex skills folder so Codex can discover it automatically in future sessions.

## Why

The repo copy is the source of truth, but Codex only auto-discovers personal skills from its configured skills locations. Installing the skill makes `start a new project` routing available without manually pointing Codex at the repo skill.

## Who Does This

human, or agent with approval

## Where To Do It

Folder or app/window: `C:\Users\kryst\Code\Software Factory`

## Before You Start

- Confirm `skills\sf-start\SKILL.md` exists in the repo.
- Confirm you want a personal Codex install at `C:\Users\kryst\.codex\skills\sf-start`.
- Close or restart Codex after installation if it does not pick up the new skill immediately.

## Exact Steps

1. Copy the repo skill folder into your personal Codex skills folder.
2. Confirm the copied folder contains `SKILL.md` and `agents\openai.yaml`.
3. Restart or refresh Codex if the skill does not appear.

## Exact Commands

Run from `C:\Users\kryst\Code\Software Factory`:

```powershell
Copy-Item -Recurse -Force -LiteralPath .\skills\sf-start -Destination C:\Users\kryst\.codex\skills\
```

## How To Verify

Verified on 2026-06-22: `C:\Users\kryst\.codex\skills\sf-start` exists and contains `SKILL.md` plus `agents\`.

Start a new Codex session and ask to use `$sf-start` to start a new Software Factory project. Codex should route the project type before normal Startup.

## If Something Goes Wrong

Delete the copied folder at `C:\Users\kryst\.codex\skills\sf-start`, then repeat the copy from the repo source after confirming the repo skill validates.

## What To Tell The Agent

Tell Codex whether the skill was installed successfully, deferred, or if you want Codex to do the copy with explicit approval.

## Can The Agent Do This Later With Approval?

Yes. Codex can copy the folder into `C:\Users\kryst\.codex\skills` later if you explicitly approve writing outside the workspace.

## Phase Impact

Does this block the current phase from closing? no
