# Windows Local Development Standard

Use this when a project is developed on Windows or when a Windows-specific issue appears.

## PowerShell And npm

PowerShell may block scripts such as `npm.ps1` depending on execution policy.

If `npm` fails because scripts are blocked, use:

```powershell
npm.cmd <command>
```

Example:

```powershell
npm.cmd run dev
```

Human action files should say exactly which folder to run the command from.

## Native Build Tools

Some desktop stacks need native Windows build tooling.

Examples:

- Tauri may need Rust, Cargo, WebView2, and Visual Studio C++ build tools.
- Python packages may need Microsoft C++ Build Tools for native extensions.
- Node packages may need native build tooling when dependencies compile from source.

Only recommend system-wide build tools when they are genuinely required. Explain why they cannot be installed only inside the project.

## Git Safe Directory

If a repository is created by a sandbox or different Windows account, Git may report dubious ownership.

Recommended human action:

```powershell
git config --global --add safe.directory "FULL/PATH/TO/WORKSPACE"
```

Use the actual app workspace path, not the Software Factory wrapper path.

## Folder Discipline

Commands for generated apps should usually be run from:

```text
projects/<slug>/workspace
```

If a command must be run somewhere else, the agent must state the exact folder.
