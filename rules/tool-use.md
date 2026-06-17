# Tool Use Rules

Use tools to reduce effort, improve correctness, and avoid rebuilding solved problems.

## Discovery Points

Agents should consider tool discovery:

- at project start
- during architecture
- before implementing solved-problem functionality
- during debugging
- before shipping

## Constraints

- Prefer free and accessible tools when appropriate.
- Do not add tools only because they are interesting.
- Ask approval before adding major dependencies, paid tools, external services, or tools that affect privacy/security.
- Every project must have an environment strategy before scaffolding.
- Every project must identify the app runtime, build runtime, package manager, dependency isolation strategy, and required system tools before scaffolding.
- Project dependencies should be installed locally to the project by default.
- System-wide installs should be reserved for foundational tools, OS-level runtimes, build toolchains, container engines, IDEs, device SDKs, or tools that are clearly better installed once for the computer.
- Docker, virtual environments, dev containers, and language-native isolation should be used when they reduce setup risk or improve reproducibility, but they should not be required when they add unnecessary overhead.
- Tools that modify the system environment must be explained to the human and approved before installation.
