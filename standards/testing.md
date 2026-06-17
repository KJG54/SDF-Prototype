# Testing Standard

Testing should prove the product works for the user, not just that files exist.

Use:

- automated tests when practical
- build checks
- lint/type checks when available
- manual walkthroughs for interactive software
- user confirmation for subjective UX or acceptance criteria
- structured user acceptance testing notes when human verification matters

Platform checks:

- Websites and web apps should be verified on phone-sized and desktop-sized screens.
- Desktop apps should be verified on the development operating system before v1 acceptance.
- Approved target platforms that cannot be tested immediately must be documented as shipping risks.

User acceptance testing should use `UAT-001` when the human manually tests an app, website, game, workflow, or subjective experience.
