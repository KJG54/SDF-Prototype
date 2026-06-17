# Framework Git / Backup Standard

Software Factory itself should be easy to back up and eventually publish, but repository setup is a project-shaping action and needs human approval.

## Recommended Approach

- Treat `Software Factory/` as the framework repository root when the human approves Git tracking.
- Keep generated apps as separate repositories inside `projects/<slug>/workspace/` whenever practical.
- Do not mix generated app Git history with Software Factory framework Git history.
- Ignore secrets, local environment files, dependency folders, build outputs, and generated caches.
- Keep `projects/` ignored by default because it contains local generated work and private project artifacts.
- Keep `memory/vault/` ignored by default because it can contain private user preferences, session summaries, and lessons learned.
- Use sanitized examples or docs folders for anything that should be public.

## Before Initializing Git

Confirm with the human:

- Should `Software Factory/` become its own Git repository?
- Should the repository be public or private?
- Should any sanitized memory examples be included outside `memory/vault/`?
- Are there secrets or private notes that must be excluded?
- Should existing generated project workspaces stay as nested independent repositories?

## Suggested First Commit Scope

- Framework docs.
- Rules.
- Standards.
- Phase files.
- Templates.
- Scratchpad files, unless the human wants them private.
- `.env.example`.

## Must Not Commit

- `.env`
- `.env.*`
- API keys or tokens
- `projects/`
- `memory/vault/`
- dependency directories
- build outputs
- app-local databases with personal data
- private notes the human marks as excluded
