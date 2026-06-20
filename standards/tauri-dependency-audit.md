# Tauri Dependency Audit Standard

Use this standard for Tauri desktop apps and other Rust-backed desktop apps with a web frontend.

Tauri projects have two dependency and security surfaces:

- Rust / Cargo dependencies for the native backend.
- Node / npm dependencies for the frontend and build tooling.

They also have a desktop permission surface because the web UI can bridge into native filesystem, shell, network, updater, window, and operating-system capabilities.

## When To Use

Use this standard:

- during architecture when recommending the Tauri Desktop App stack profile;
- during implementation when adding Tauri plugins, Rust crates, npm packages, or native capabilities;
- during testing / verification before review;
- during review before approving ship readiness;
- during ship before GitHub, installer, package, or public distribution.

## Required Audit Areas

### Rust / Cargo

Check:

- `Cargo.toml` and `Cargo.lock` exist where expected.
- `Cargo.lock` is committed for app projects.
- dependencies resolve from the lockfile.
- no unnecessary Rust crates or Tauri plugins were added.
- native capabilities match approved requirements.

Recommended commands from the Tauri app workspace or Rust crate folder:

```powershell
cargo check --locked
cargo test --locked
```

If `cargo audit` is installed, run:

```powershell
cargo audit
```

If `cargo audit` is not installed, do not install it silently. Either record that it was unavailable or create a human-action file if the project risk justifies installing it.

### Node / npm

Check:

- `package.json` exists where expected.
- package lockfile is committed when npm dependencies exist.
- frontend dependencies are project-local.
- build scripts are documented.
- unused packages are removed.

Recommended commands from the frontend workspace:

```powershell
npm install
npm run build
npm audit
```

Use the package manager selected in architecture. If the project uses `pnpm`, `yarn`, or another manager, use its equivalent install/build/audit commands.

Do not treat every low-severity advisory as a blocker. Explain severity, exploitability, reachable surface, and whether a fix is available.

### Tauri Permissions And Capabilities

Review Tauri configuration and capability files for:

- filesystem access;
- shell command access;
- network access;
- updater configuration;
- deep links or custom protocols;
- window and webview configuration;
- drag/drop, clipboard, notifications, and OS integrations;
- allowlists, permissions, and capability scopes.

Capabilities should be minimal and tied to approved requirements.

Ask for human approval before adding broad filesystem access, shell execution, auto-updaters, background services, or network integrations.

### Webview Surface

Check:

- external links open safely;
- untrusted content is not loaded into privileged webviews;
- local file paths are not exposed unnecessarily;
- content security policy or equivalent restrictions are documented when relevant;
- frontend does not rely on unsafe dynamic HTML or unreviewed script injection.

### Secrets And Local Data

Check:

- `.env`, local databases, test data, and build outputs are ignored where appropriate;
- no API keys, tokens, private file paths, or personal data are included in tracked files;
- local SQLite or data files have a documented path, backup/export story, and shipping exclusion when relevant;
- generated installers/packages do not include unintended local files.

Run the project or framework secret scan before publishing or pushing when credentials may have been used.

## Review Outcomes

Classify each finding as:

- `fixed`: resolved during the phase;
- `accepted`: acceptable for the approved project risk level;
- `deferred`: explicitly deferred by the human;
- `blocked`: must be resolved before phase advancement or shipping;
- `not-applicable`: does not apply to this project.

Do not advance a phase when a high-impact security or dependency issue is unresolved unless the human explicitly approves deferral and the risk is documented.

## Documentation Requirements

Record in the relevant verification, review, or shipping artifact:

- commands run;
- lockfiles checked;
- audit tools available or unavailable;
- dependency advisories found;
- permission/capability review result;
- secrets/local-data review result;
- unresolved risks and human decisions.

## Human Actions

Create a human-action file when the human needs to:

- install Rust, Node.js, platform build tools, or Tauri prerequisites;
- install `cargo-audit` or another audit tool;
- authenticate to GitHub or a package registry;
- run a command on their machine;
- approve adding a broad native capability;
- decide whether to fix, accept, or defer an advisory.

Human-action files must include the exact folder, exact command, expected result, and what output to send back if it fails.

## Minimum Before Shipping

Before shipping a Tauri app, confirm:

- build succeeds with locked dependencies;
- Rust side checks pass or unresolved failures are documented and approved;
- frontend build passes;
- dependency advisories are fixed, accepted, or deferred with approval;
- Tauri permissions/capabilities are minimal and documented;
- secrets and local-only files are excluded;
- README includes setup, run, build, and known-risk notes;
- release notes name unresolved dependency, packaging, or permission risks.

