# Phase 3: Tech Stack / Architecture

## Purpose

Choose how the project should be built.

## Agent Responsibilities

- Recommend a stack based on the project, not personal preference.
- Right-size architecture detail to the approved operating tier and rigor level.
- Check `standards/stack-profiles.md` for a known-good stack profile before recommending a custom stack.
- Check `standards/starter-toolbox.md` and `tools/registry.md` before recommending tools.
- Apply `standards/tool-adoption.md` before adding any tool that is not already core or clearly required by the selected stack profile.
- Apply `standards/tauri-dependency-audit.md` when recommending Tauri or another Rust-backed desktop stack.
- Compare alternatives only when tradeoffs matter.
- Consider existing tools, libraries, databases, hosting, security, privacy, and cost.
- Choose a stack that supports the approved target platforms unless the human approves a narrower target.
- Define an environment strategy for the project.
- Apply the engineering quality standard in proportion to the project's purpose, risk, audience, and lifecycle.
- Identify the app runtime, build runtime, package manager, dependency isolation strategy, local services, and system-level prerequisites.
- Create a step-by-step setup guide for any tools needed to develop, run, test, or package the project.
- Update `PROJECT-CHECKLIST.md` and `project-checklist.json`.
- Ask approval for major dependencies or services.
- Classify each meaningful tool as core, preferred, optional, deferred, restricted, or rejected-for-now when the classification affects the architecture.

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
- Quality level: prototype, local tool, internal tool, public app, business-critical system, or another justified category.
- Quality implications: testing, documentation, security, deployment, observability, and maintenance expectations that fit the chosen quality level.
- Stack profile: selected known-good profile or `custom`, with reasons.
- Tool adoption: any new tool's classification, why it is needed, what it replaces, setup burden, local/cloud status, data/security implications, and replacement path.

Project-local dependencies are preferred. System installs are acceptable when they are foundational tools, OS-level requirements, or clearly simpler and safer than local isolation.

For Tier 3, Tier 4, Level 0, or Level 1 projects, brief entries are enough when the project has no services, no sensitive data, no public deployment, and no meaningful tool risk. Do not skip tool-adoption, security, privacy, or approval checks when they are relevant.

## Platform Support

- Development machine setup must be based on the human's actual operating system.
- Target platforms must be documented separately from the development machine.
- Websites and web apps must be responsive by default.
- Desktop apps should prefer cross-platform stacks unless there is a strong reason not to.
- Any one-platform recommendation requires explanation and human approval.
