---
description: Execute task lists with a simple TDD workflow
---

Read and process the task list at @$ARGUMENTS.

## Goal

Help the user work through the task list in a disciplined, test-driven, and sequential way, updating the Markdown as progress is made.

## Core principles

- **Sequential:** Work on one sub-task at a time; do not start the next until the current one is fully complete.
- **Test-driven:** Whenever practical, write or update tests alongside the implementation, and require tests to pass before marking tasks complete.
- **Validated:** Check each sub-task against its acceptance criteria and the PRD intent.
- **Interactive:** Regularly confirm with the user before moving on.

## Sub-task loop

For each incomplete sub-task in order:

1. **Understand**
   - Restate what the sub-task is asking for.
   - Identify the files likely involved (implementation, tests, configuration, docs).
   - Flag any missing context and ask quick clarifying questions if needed.

2. **Implement (with tests)**
   - Propose or perform the code changes needed.
   - Add or update tests that verify the behavior.
   - Ensure changes follow the project’s conventions.

3. **Validate**
   - Run or describe the relevant tests and checks.
   - Confirm that acceptance criteria (if any are written) are met.
   - Note any side effects or regressions that were checked.

4. **Update the task list**
   - Change `[ ]` to `[x]` for the completed sub-task.
   - Optionally add a brief note or bullet under the task summarizing what changed.

5. **Ask before continuing**
   - Tell the user what was done and what you plan to do next.
   - Ask something like:  
     "Sub-task [X.Y] looks complete based on the current plan. Proceed to [X.Y+1]? (y/n)"
   - Wait for an explicit "yes"/"y" (or similar) before continuing.

## Parent task completion

When all sub-tasks under a parent task are marked complete:

1. **Full check**
   - Ensure tests relevant to that parent task all pass.
   - If the project has a standard test command (e.g., `npm test`, `pytest`, `bin/rails test`), make sure it is run or planned.

2. **Clean-up & review**
   - Look for obvious cleanup: dead code, debug logging, unused imports, etc.
   - Confirm code follows style and architectural conventions used in the project.

3. **Commit guidance** (if using Git)
   - Suggest staging and committing changes with a conventional commit-style message, e.g.:
     - `feat(profile): add profile editing flow`
     - `fix(auth): handle expired sessions correctly`
   - Reference the parent task number and/or PRD name in the extended description if helpful.

4. **Mark the parent task**
   - Change the parent task checkbox to `[x]`.
   - Optionally add a short summary line under the parent task of what was delivered.

## Maintaining the task list

- Keep the task list as the single source of truth for progress.
- Add or adjust tasks when new work is discovered, rather than silently diverging.
- Keep any "Relevant Files" or similar sections reasonably up to date.
- When things change significantly, briefly note the change so future readers understand why.

## Communication

Throughout the process:

- Provide short status updates after each sub-task: what changed, what was tested, and current progress within the parent task.
- Ask for guidance when encountering ambiguous requirements or multiple plausible approaches; present 2–3 options with trade-offs.
- Encourage the user to pause and adjust the plan if tests fail repeatedly or new information appears.

Success means the task list matches reality, tests cover the implemented behavior, and the feature satisfies the PRD requirements.
