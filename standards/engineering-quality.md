# Engineering Quality Standard

Software Factory projects should be built with professional engineering judgment appropriate to their purpose, risk, audience, and lifecycle.

The goal is not maximum process. The goal is software that is reliable, maintainable, secure, understandable, testable, and no more complex than necessary.

## Proportional Quality

Apply engineering rigor in proportion to the project.

- A local prototype can be lightweight, but it should still avoid careless architecture, hidden security risks, untracked technical debt, and unverified behavior.
- A public app, paid product, business tool, system that handles sensitive data, or project that other people depend on needs stronger testing, documentation, security review, deployment discipline, and operational planning.
- If a recommended quality practice would add meaningful cost, delay, dependency risk, or complexity, explain the tradeoff and ask for human approval when it affects scope or direction.

## Core Principles

- Prefer simple solutions that satisfy the approved requirements.
- Keep complexity justified by real user, business, technical, security, or maintenance value.
- Optimize for readability, clarity, consistency, and future modification.
- Use the conventions of the chosen stack and generated project.
- Choose proven libraries and tools when they fit better than custom code.
- Minimize dependencies and justify major ones.
- Make important behavior explicit and predictable.
- Document meaningful technical debt instead of hiding it.

## Architecture

Architecture should fit the project scale.

Agents should consider:

- separation of concerns
- clear module or component boundaries
- dependency isolation and locking
- security and privacy surfaces
- data ownership and integrity
- likely deployment and maintenance needs
- future change paths that are reasonably likely, not speculative

Avoid premature microservices, unnecessary infrastructure, broad abstractions, or future-proofing that does not serve the approved project.

## Implementation

Code should be clean enough for a future human or agent to understand and change.

Implementation should favor:

- descriptive names
- focused files, functions, components, and modules
- clear error handling
- minimal hidden side effects
- removal of dead code and unused dependencies
- reuse when it reduces real duplication
- comments only where they explain non-obvious decisions

Do not use short-term speed as a reason to create avoidable long-term maintenance burden.

## Security And Privacy

Security is part of design and implementation, not a final polish step.

Agents should:

- protect secrets and credentials
- minimize data collection
- validate inputs and permissions when relevant
- avoid trusting client-side validation alone
- review authentication, authorization, file access, browser/webview behavior, and third-party data sharing when relevant
- run secret scanning before publishing or pushing when credentials may have been used

## Testing And Verification

Every meaningful change should be verified at the level appropriate to the project.

Use a practical mix of:

- automated tests
- build checks
- linting or type checks
- manual workflow checks
- visual and interaction checks
- user acceptance testing
- performance or reliability checks when risk justifies them

Do not claim completion when important behavior has not been checked. If verification cannot be completed, document what is unverified and why.

## Documentation

Documentation should help someone use, run, maintain, or understand the project.

For shipped projects, include enough documentation for the approved shipping path:

- README
- setup and run instructions
- dependency and environment notes
- known issues and deferred work
- final verification summary
- deployment, packaging, or operational notes when relevant

Significant technical decisions should record context, alternatives, tradeoffs, and reasoning.

## Observability And Operations

Operational rigor should match the deployment target.

- Local-only tools may need clear errors and troubleshooting notes.
- Shared internal tools may need logs, recovery notes, and documented manual procedures.
- Hosted or public systems may need structured logging, monitoring, alerting, backups, rollback plans, and deployment automation.

Do not require production operations machinery for projects that are not being operated in production.

## AI-Generated Work

AI-generated work must be reviewed and validated before it is treated as complete.

Agents should actively look for:

- incorrect assumptions
- missing requirements
- edge cases
- security and privacy risks
- performance or reliability risks
- maintainability problems
- mismatches between generated artifacts and implemented behavior

When uncertainty affects scope, architecture, security, privacy, cost, runtime, shipping, or correctness, start a discussion instead of silently guessing.

## Definition Of Done

A task is done when:

- approved requirements are satisfied
- important behavior has been verified
- known errors are fixed or explicitly deferred
- security and privacy considerations have been addressed at the appropriate level
- documentation and project artifacts are updated when needed
- meaningful technical debt is visible
- the result is maintainable for its intended environment

Completion should mean the work can be confidently used, tested, changed, and, when applicable, shipped.
