# Environment / Runtime Standard

Projects should be easy to set up, run, test, and ship without scattering unnecessary dependencies across the human's computer.

## Default Rule

Use project-local dependencies by default.

System-wide installs are allowed when they are foundational tools, operating-system requirements, device SDKs, native build toolchains, container engines, IDEs, or clearly simpler and safer than forcing project-local isolation.

## Required Planning

Before scaffolding, document:

- Development machine and operating system.
- Target platforms for the finished project.
- App runtime: what the finished app needs to run.
- Build runtime: what is needed to develop, build, test, or package.
- Package manager and lockfile strategy.
- Dependency isolation strategy.
- Local services, such as databases, containers, emulators, or background processes.
- System-wide tools and why they cannot reasonably be project-local.
- Exact setup and verification commands.

## Isolation Options

- Python: prefer `venv`, Conda, or another project-specific environment.
- JavaScript / TypeScript: prefer project-local `node_modules` with a lockfile.
- Rust: prefer Cargo-managed project dependencies.
- .NET, Java, Go, and similar ecosystems: prefer project files and lockfiles when available.
- Docker or dev containers: use when they reduce setup pain, improve reproducibility, or package supporting services cleanly.
- Native local toolchain: use when the project needs OS-specific compilers, desktop app packaging, mobile/device SDKs, hardware access, or GUI/runtime integration.

## Package Manager Caches

Package-manager caches should not become project artifacts.

For generated projects, keep install caches either:

- inside `projects/<slug>/workspace/` when the package manager supports a local cache path; or
- in another ignored, validator-safe location.

Avoid placing npm, pnpm, yarn, pip, Cargo, or similar generated cache folders directly in the project wrapper root unless the validator explicitly ignores them. Wrapper-root caches can be mistaken for Software Factory artifacts when they contain Markdown or JSON metadata.

## Docker Guidance

Docker is useful, but it is not automatically simpler.

Use Docker when:

- the project needs databases, queues, services, or backend dependencies;
- the app should run consistently across machines;
- setup would otherwise require many manual installs;
- the human wants a containerized handoff.

Avoid forcing Docker when:

- the app needs a native GUI workflow that Docker complicates;
- the language package manager already gives enough isolation;
- Docker would add more setup burden than it removes.

## Beginner-Safe Instructions

When the human must install or run something, state:

- what folder or app to open;
- the exact command or click path;
- what the action does;
- what success looks like;
- what error output to send back if it fails.
