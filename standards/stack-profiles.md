# Stack Profiles

Stack profiles are known-good starting points for common project types.

They are guidance, not automatic approval. Agents should still recommend a stack based on the approved project, human constraints, target platforms, security/privacy needs, and available tools.

## Required Use

During architecture, check whether a known profile fits before inventing a new stack.

Record in `ARCH-001`:

- selected profile, or `custom`;
- why it fits;
- why alternatives were not chosen;
- required system tools;
- project-local dependency strategy;
- setup, build, test, and run commands;
- profile-specific risks.

If no profile fits, document why and use the smallest custom stack that satisfies the project.

## Profile Format

Each profile should define:

- best for;
- avoid when;
- typical stack;
- system tools;
- project-local dependencies;
- default commands;
- verification;
- risks and tradeoffs;
- upgrade path.

## V1 Profiles

### Static Website

Best for:

- simple public pages;
- documentation;
- landing pages;
- small content sites with little or no dynamic behavior.

Avoid when:

- the app needs accounts, server-side data, payments, or complex interactivity.

Typical stack:

- HTML, CSS, and minimal JavaScript;
- optional Vite only when tooling meaningfully helps.

System tools:

- Git;
- a browser;
- Node.js only if a bundler is used.

Project-local dependencies:

- none for plain static files;
- `node_modules` and lockfile if Vite or another tool is used.

Default commands:

- plain site: open `index.html`;
- Vite site: `npm install`, `npm run dev`, `npm run build`.

Verification:

- inspect desktop and phone-sized layouts;
- check links, forms, images, and console errors;
- run build if tooling exists.

Risks and tradeoffs:

- easiest to maintain;
- limited backend capability;
- frontend-only forms or data handling may be misleading without real services.

Upgrade path:

- Vite React app for richer interactivity;
- backend/API profile when server-side behavior is required.

### Vite React Web App

Best for:

- interactive browser apps;
- dashboards;
- local or client-heavy tools;
- prototypes that need a polished UI quickly.

Avoid when:

- the project is mostly static content;
- SEO-heavy content is central;
- server-rendering, accounts, payments, or database-backed workflows are required from day one.

Typical stack:

- Vite;
- React;
- TypeScript when maintainability matters;
- project-local npm dependencies and lockfile.

System tools:

- Node.js;
- Git;
- browser.

Project-local dependencies:

- `node_modules`;
- `package-lock.json` or equivalent lockfile.

Default commands:

- `npm install`;
- `npm run dev`;
- `npm run build`;
- `npm run lint` or equivalent when configured.

Verification:

- build succeeds;
- main workflows work in browser;
- desktop and phone-sized layouts are checked;
- console is clean enough for the project level.

Risks and tradeoffs:

- easy to overbuild;
- frontend-only persistence is fragile unless explicitly local-only;
- dependency churn should be controlled with lockfiles.

Upgrade path:

- add a backend/API profile when server-side data or authentication is needed;
- consider Next.js or another full-stack framework only when its benefits are real.

### Tauri Desktop App

Best for:

- local-first desktop apps;
- apps needing file access or native desktop packaging;
- cross-platform desktop apps with a web UI.

Avoid when:

- a normal website is enough;
- the human cannot install native build tools;
- mobile or browser-first use matters more than desktop.

Typical stack:

- Tauri;
- Rust backend;
- Vite React or equivalent frontend;
- local storage such as files or SQLite when needed.

System tools:

- Node.js;
- Rust toolchain;
- platform-specific Tauri prerequisites;
- Git.

Project-local dependencies:

- npm dependencies and lockfile;
- Cargo dependencies and lockfile.

Default commands:

- `npm install`;
- `npm run dev`;
- `npm run build`;
- `cargo check --locked`;
- `cargo test --locked` when tests exist;
- `cargo audit` when available and justified by project risk;
- frontend dependency audit command such as `npm audit` when npm dependencies exist;
- Tauri dev/build commands defined by the project.

Verification:

- web build succeeds;
- Cargo check succeeds with locked dependencies;
- Rust and frontend dependency audit results are recorded according to `standards/tauri-dependency-audit.md`;
- Tauri permissions/capabilities are reviewed when native access is used;
- desktop app launches on the development OS;
- core desktop workflows are manually tested.

Risks and tradeoffs:

- higher setup burden than a web app;
- native prerequisites vary by operating system;
- packaging/installers require extra shipping work.
- dependency and permission surfaces are broader than plain web apps because Tauri bridges web UI and native capabilities.

Upgrade path:

- add installer packaging playbooks when the human wants distribution beyond GitHub source;
- apply `standards/tauri-dependency-audit.md` before review and shipping.

### Python CLI Or Local Automation

Best for:

- scripts;
- local file processing;
- developer tools;
- small automations;
- data wrangling where a GUI is unnecessary.

Avoid when:

- the human needs a polished visual interface;
- nontechnical users need to run it without command-line comfort;
- long-running services or many users are required.

Typical stack:

- Python;
- project-local virtual environment;
- `requirements.txt`, `pyproject.toml`, or lockfile strategy appropriate to the project.

System tools:

- Python;
- Git;
- optional platform-specific tools required by the automation.

Project-local dependencies:

- `.venv`;
- pinned or lockable dependency file.

Default commands:

- create/activate virtual environment;
- install dependencies;
- run script or CLI entry point;
- run tests if configured.

Verification:

- run representative input through the tool;
- check output files or side effects;
- test failure cases that could damage files or data.

Risks and tradeoffs:

- command-line UX may be hard for beginners;
- file operations need careful safety checks;
- packaging for nontechnical users may require extra work.

Upgrade path:

- add a small GUI or web UI when usability matters;
- package as an executable only when distribution needs justify it.

### FastAPI Backend

Best for:

- APIs;
- small services;
- backend for a web app;
- automation endpoints;
- projects where Python ecosystem libraries matter.

Avoid when:

- a static or frontend-only app satisfies the requirements;
- the human does not want to run a server;
- authentication, deployment, or operations would exceed the project goal.

Typical stack:

- Python;
- FastAPI;
- virtual environment;
- SQLite or Postgres depending on scale;
- Docker only when it reduces setup or service complexity.

System tools:

- Python;
- Git;
- Docker only when selected;
- database tools only when needed.

Project-local dependencies:

- `.venv`;
- dependency file or lockfile;
- local database or container configuration when relevant.

Default commands:

- create/activate virtual environment;
- install dependencies;
- run development server;
- run tests;
- run database migration commands when configured.

Verification:

- API server starts;
- health route or core endpoint works;
- tests cover important routes and validation;
- security/privacy review for data and external access.

Risks and tradeoffs:

- adds server operations;
- deployment, auth, and database choices can expand scope quickly;
- APIs need validation and error handling.

Upgrade path:

- add frontend profile for UI;
- add deployment and observability guidance for shared or public use.

### Local-First SQLite App

Best for:

- personal databases;
- offline-first tools;
- apps where the human owns local data;
- small desktop or local web apps.

Avoid when:

- multiple users need concurrent shared access;
- cloud sync is a V1 requirement;
- data loss would have high consequences without backup planning.

Typical stack:

- SQLite;
- app framework chosen by interface needs: Tauri, Python, web local server, or another fit.

System tools:

- depends on host stack;
- SQLite library usually comes through the language/runtime.

Project-local dependencies:

- host stack dependencies;
- local database file strategy documented in architecture.

Default commands:

- host stack setup/build/run commands;
- optional migration or seed commands.

Verification:

- create, read, update, delete, search, and backup/export workflows when relevant;
- confirm database file location;
- test behavior when data is missing or malformed.

Risks and tradeoffs:

- local data needs backup/export thinking;
- schema changes need migration discipline;
- multi-device sync is a separate product decision.

Upgrade path:

- add backup/export;
- add cloud sync or server database only after explicit approval.

## Adding A Profile

Add a new profile when a stack has been used successfully or is a common professional default for a project type.

Do not add a profile just because a tool is popular. Add it when the framework can explain when to use it, when to avoid it, and how to verify it.
