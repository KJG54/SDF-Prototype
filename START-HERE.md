# Start Here

Welcome to Software Factory.

This framework helps a human and one or more agents build software together. You do not need to know how to code. The agent should guide you, explain tradeoffs, ask questions, and turn your decisions into a working project.

## How To Use This

1. Tell Codex what you want to build.
2. Codex starts with a short project startup checklist.
3. Codex starts the Vision Interview and asks questions until the project is clear enough.
4. Codex writes human-readable summaries and machine-readable artifacts for each phase.
5. You approve project-shaping decisions before the agent moves forward.
6. Codex builds the project in `projects/<project-slug>/workspace/`.
7. You test the result with Codex's help.
8. Codex prepares the project for shipping and records lessons for future work.

At the end of each phase, Codex should explain what happened, what you should check, what comes next, and ask whether you approve moving forward.

## What Codex Should Ask First

- What do you want to build?
- Who is it for?
- What should it help them do?
- What would a simple first version include?
- Is this for personal use, public release, business use, or learning?
- What computer and operating system are you using to develop it?
- Where should the finished project run?
- Do you want dependencies kept local to the project when practical?
- Are Docker, Conda, Python virtual environments, or dev containers acceptable if they make setup easier?
- Are there tools, styles, examples, or constraints you already know you want?

These answers should be captured in `STARTUP-001` before the deeper Vision Interview continues.

## What You Can Write In

These files are safe for human notes:

- [FRAMEWORK-IDEAS.md](FRAMEWORK-IDEAS.md)
- [PROJECT-IDEAS.md](PROJECT-IDEAS.md)
- [FIXES.md](FIXES.md)

Notes in those files are context, not automatically approved scope. Codex should discuss them with you before turning them into framework or project changes.

## Important Rule

If something could significantly change the project, cost real money, affect privacy/security, add a major dependency, change architecture, or create deployment/legal risk, Codex must explain it and ask for approval.

Software Factory assumes projects should be broadly usable by default. Websites and web apps should work on phone-sized and desktop-sized screens. Desktop apps should prefer cross-platform technologies unless the human approves a narrower target.
