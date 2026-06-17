# Error Handling Rules

When something fails:

1. State what failed.
2. State what is known.
3. State what is uncertain.
4. Check relevant docs, logs, tests, or prior known problems.
5. Recommend the next move.
6. Ask for approval when the fix is project-shaping.

Repeated failures should be recorded as known problems or memory proposals when they are reusable.

## Phase Blocking Rule

An unresolved error blocks phase advancement unless one of these is true:

- The human explicitly approves deferring it.
- The issue is documented as out of scope for the current version.
- The next phase naturally resolves the issue and the reason is documented.

If an error is deferred, the agent must record where it is tracked and what would trigger revisiting it.

Agents should not minimize uncertainty. If the cause or impact of an error is unclear, treat that uncertainty as part of the error until it is investigated or explicitly deferred.
