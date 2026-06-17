# Platform Support Standard

Software Factory assumes projects should be broadly usable by default.

## Required Intake Questions

At the beginning of a project, the agent must ask:

- What computer and operating system are you using to develop this project?
- What operating system version are you using, if you know it?
- What IDE or editor do you prefer?
- Do you have permission/admin access to install development tools?
- Where should the finished project run?
- Should the finished project support Windows, macOS, Linux, web browsers, phones, tablets, or something else?

## Default Assumptions

- Desktop apps should prefer cross-platform technologies unless the human wants a single operating system or there is a strong technical reason.
- Websites and web apps must be responsive by default.
- Websites and web apps should be tested on phone-sized and desktop-sized screens before shipping.
- CLIs, libraries, and tools should avoid OS-specific behavior unless it is required and documented.
- If the agent recommends limiting support to one operating system, one browser size, or one device type, it must explain why and get human approval.

## Development Machine vs Target Platforms

The development machine is where the project is built.

Target platforms are where the finished project should run.

Agents must keep these separate. A project can be developed on Windows while targeting Windows, macOS, Linux, and web browsers. Setup instructions should focus on the development machine; architecture, testing, and shipping plans should focus on target platforms.

## Verification

Verification should match the approved target platforms. If full cross-platform testing is not possible during v1, the limitation must be documented and revisited before shipping.
