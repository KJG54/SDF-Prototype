# Git / GitHub Standard

Every project should be GitHub-ready by default.

Before shipping:

- ensure `.gitignore` is appropriate
- avoid secrets
- prefer `gh auth login` or Git Credential Manager over tokens in `.env`
- run a secret scan or manual token-pattern check before pushing
- include README and setup instructions
- document known issues
- confirm license only when needed
- ask approval before creating, pushing, or publishing a repository

## Credential Handling

GitHub credentials should usually be handled by:

- `gh auth login`;
- Git Credential Manager;
- a short-lived, least-privilege token set only for the current shell session when no safer option works.

Do not ask a nontechnical user to keep a long-lived GitHub token in `.env`.

If a token is exposed to an agent, terminal log, review output, or pasted text, treat it as compromised and create a human action to rotate it.

## Secret Scan Guard

Before committing or pushing framework changes, run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools/secret-scan.ps1 -All
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools/artifact-validate.ps1 -All
```

To enable the tracked pre-commit hook for this repo:

```powershell
git config core.hooksPath .githooks
```

The hook scans staged files for secret patterns and validates staged artifact pairs without printing secret values.

## Repository Location

Generated project workspaces should be GitHub-ready and independent whenever practical.

For Software Factory projects, the app repository should usually be:

```text
projects/<slug>/workspace
```

The parent `projects/<slug>/` folder is the Software Factory wrapper for artifacts, memory, phase gates, and human-action files.

## Human-Led Push

If authentication friction would slow the project down, it is acceptable to give the human a clear push task instead of forcing agent-side GitHub automation.

Human push instructions must include:

- exact folder;
- remote URL;
- commands;
- what success looks like;
- what error output to send back.

## Windows Safe Directory

If Git reports dubious ownership, create a human action that uses:

```powershell
git config --global --add safe.directory "FULL/PATH/TO/WORKSPACE"
```

Use the generated app workspace path, not the wrapper folder.
