# Git / GitHub Standard

Every project should be GitHub-ready by default.

Before shipping:

- ensure `.gitignore` is appropriate
- avoid secrets
- include README and setup instructions
- document known issues
- confirm license only when needed
- ask approval before creating, pushing, or publishing a repository

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
