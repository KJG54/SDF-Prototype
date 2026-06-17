# Desktop Playbook

Use for desktop applications.

Prioritize:

- operating system target
- installation and updates
- local file access
- permissions
- packaging
- native UX expectations

## Planning Requirements

- Ask which computer and operating system the human is developing on.
- Identify native build tools before scaffolding.
- Decide whether dependencies are project-local, system-wide, containerized, or hybrid.
- Explain why any system-wide install is necessary.
- Decide during shipping whether source upload, installer/package, or both are required.

## Shipping Guidance

Do not assume every desktop V1 needs an installer.

GitHub-ready source shipping is acceptable when the human approves it. Installer/package creation should be treated as a separate shipping target because it can require additional tools, certificates, downloads, or platform-specific work.
