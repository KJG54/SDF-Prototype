# Cleanup Workflow

Use this standard before removing, merging, archiving, or reorganizing Software Factory framework files or generated project files.

Cleanup should reduce friction without deleting useful context, private memory, project history, or framework guidance by accident.

## When To Use

Use this workflow when:

- the human asks to clean up files;
- files appear redundant, stale, empty, generated, confusing, or misplaced;
- a project is being prepared for publishing;
- ignored local folders may contain private memory or generated work;
- old plans, fixes, commands, or roadmap notes overlap;
- validation warnings suggest stale or placeholder artifacts.

Do not use cleanup as a shortcut for unresolved design decisions. If a file is confusing because the decision is unclear, discuss the decision first.

## Cleanup Categories

Classify each candidate before acting:

| Category | Meaning | Default Action |
| --- | --- | --- |
| keep | Current, useful, and in the right place. | Leave unchanged. |
| update | Useful, but stale, unclear, or lightly damaged. | Edit only the stale or unclear parts. |
| merge | Overlaps another file and should become one clearer source. | Propose the merge and wait for approval. |
| archive | Useful history, but not active guidance. | Propose an archive location and wait for approval. |
| delete | Redundant, generated, empty, misleading, or no longer useful. | Propose deletion and wait for approval. |
| private | Local-only memory, logs, secrets, ignored generated work, or personal state. | Leave out of public repo scope unless explicitly approved. |

## Approval Rules

Codex may do without special approval:

- inspect files;
- classify candidates;
- report recommendations;
- fix obvious non-destructive wording or link drift when asked to implement;
- update roadmap, fixes, deferred, or queue notes to reflect approved decisions.

Codex must get explicit human approval before:

- deleting files;
- merging files;
- archiving files;
- removing guidance;
- changing `.gitignore` behavior for private or generated paths;
- moving generated projects into or out of public framework scope;
- publishing private memory, logs, local project work, or secrets.

If a cleanup action affects phase gates, approval behavior, memory, delegation, security, project startup, or major structure, escalate from Tier 3 to Tier 2 or Tier 1 before proceeding.

## Review Process

1. Baseline the repo.

   Run validation and inspect git status before proposing cleanup.

2. Find candidates.

   Look for placeholder notes, stale docs, duplicated guidance, encoding damage, generated files, ignored local folders, and validation warnings.

3. Classify each candidate.

   Use keep, update, merge, archive, delete, or private.

4. Explain the reason.

   Tie each recommendation to friction: confusing entry point, stale guidance, duplicated source of truth, validation noise, privacy risk, or generated output.

5. Separate safe edits from approval-needed actions.

   Safe edits can be implemented when requested. Delete, merge, archive, and guidance-removal actions wait for approval.

6. Validate after changes.

   Run the framework checks and report any remaining issues.

## Candidate Report Format

Use this compact format for cleanup reviews:

| Path | Category | Recommendation | Approval Needed | Reason |
| --- | --- | --- | --- | --- |
| `path/to/file.md` | update | Fix stale wording. | no | The file is useful, but points to an old workflow. |

Keep private paths high-level when they may contain sensitive content.

## Validation

After approved cleanup changes, run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 doctor
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 secret-scan
git status --short
```

If validation fails, fix the cleanup-induced issue before continuing unless the human explicitly approves deferral.
