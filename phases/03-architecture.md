# Phase 3: Tech Stack / Architecture

## Purpose

Choose how the project should be built.

## Agent Responsibilities

- Recommend a stack based on the project, not personal preference.
- Compare alternatives only when tradeoffs matter.
- Consider existing tools, libraries, databases, hosting, security, privacy, and cost.
- Choose a stack that supports the approved target platforms unless the human approves a narrower target.
- Define an environment strategy for the project.
- Identify the app runtime, build runtime, package manager, dependency isolation strategy, local services, and system-level prerequisites.
- Create a step-by-step setup guide for any tools needed to develop, run, test, or package the project.
- Update `PROJECT-CHECKLIST.md` and `project-checklist.json`.
- Ask approval for major dependencies or services.

## Human Responsibilities

- Decide whether the recommendation fits their needs.
- Approve architecture before build planning.

## Required Output

- `ARCH-001-tech-stack-architecture.json`
- `ARCH-001-tech-stack-architecture.md`
- `ENV-001-environment-setup.json`
- `ENV-001-environment-setup.md`
- Phase gate
- Phase summary

## Exit Criteria

The human approves the architecture and environment setup strategy.

## Environment Strategy Options

- Native local toolchain: best for desktop apps, mobile apps, OS-specific packaging, hardware access, and GUI apps.
- Docker / dev container: best for web apps, APIs, databases, CLIs, backend services, and team handoff.
- Language-native isolation: best for focused projects using tools like Python `venv`, Node lockfiles, Rust Cargo, or .NET project files.
- Hybrid: best when part of the project needs native tooling and another part benefits from containers.

## Runtime Planning

Document these before scaffolding:

- App runtime: what the finished app needs to run.
- Build runtime: what is needed to develop, build, test, or package the app.
- Package manager: how dependencies are installed and locked.
- Dependency isolation: project-local dependencies, Python `venv`, Conda environment, Docker, dev container, language-native lockfile, or another justified approach.
- Local services: databases, queues, emulators, background processes, or containers.
- System tools: anything that must be installed on the computer rather than inside the project.

Project-local dependencies are preferred. System installs are acceptable when they are foundational tools, OS-level requirements, or clearly simpler and safer than local isolation.

## Platform Support

- Development machine setup must be based on the human's actual operating system.
- Target platforms must be documented separately from the development machine.
- Websites and web apps must be responsive by default.
- Desktop apps should prefer cross-platform stacks unless there is a strong reason not to.
- Any one-platform recommendation requires explanation and human approval.
