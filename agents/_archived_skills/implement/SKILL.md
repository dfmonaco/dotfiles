---
name: implement
description: "Execute an implementation plan by writing code, task by task. Use after planning (or when the user provides a clear, ordered list of code changes to make). Works through tasks sequentially, follows codebase conventions, verifies as it goes, and checks in with the user at key decision points. Triggers: 'implement this plan', 'execute this plan', 'build this', 'start implementing', 'do the tasks'."
---

# Implement

Execute an implementation plan by writing code, one task at a time.

This is NOT planning - the technical decisions should already be made. If the plan is missing critical details (which files, what approach), say so and suggest running the planning skill first rather than guessing.

## Rules

- Follow the plan's task order. Don't skip ahead or reorder without explaining why.
- Match existing codebase conventions (naming, structure, patterns, style). The plan's Research Notes section describes what to follow - read it.
- One task at a time. Finish and verify a task before moving to the next.
- If something in the plan doesn't work as expected (wrong file path, API changed, approach doesn't fit), stop and tell the user. Propose an adjustment rather than silently deviating.
- Don't refactor, rename, or "improve" code that the plan doesn't ask you to touch.
- Use Context7 to look up library APIs when writing code that depends on them. Don't guess at function signatures or options from training data.

## Input

This skill works best with an implementation plan from the planning skill (found in `.plans/<feature-name>.plan.md`). It also accepts any ordered list of code changes that specifies what files to touch and what to change.

If the input is just a vague idea or feature description, say so and suggest running the brainstorming or planning skills first.

## Workflow

### 1) Review

Before writing any code:

- Read the full plan (Context, Research Notes, all Tasks, Verification).
- Load the plan's tasks into a todo list to track progress.
- Identify if anything is unclear or stale (file that no longer exists, dependency that changed). Raise it now, not mid-implementation.

### 2) Execute

Work through tasks in order. For each task:

- **Read first.** Open the files listed in the task. Understand the surrounding code before editing.
- **Make the change.** Write the minimum code that satisfies the task description. Follow the patterns noted in Research Notes.
- **Verify.** After each task, do a quick sanity check: does the change look right in context? If the plan mentions tests or build commands, run them. If not, at minimum re-read the modified code to catch obvious mistakes.
- **Mark complete.** Update the todo list before moving on.

If a task is large, break it into sub-steps and work through them. But don't break the plan's task boundaries - each plan task should result in a coherent, working state.

### 3) Verify

After all tasks are done:

- Run the verification steps from the plan's Verification section.
- If the project has tests, run the full test suite. **All tests must pass before the implementation is considered done.** Fix failures caused by your changes. If a failure is pre-existing or unrelated, flag it to the user but don't let it block completion silently.
- If there's a build step, run it and confirm it succeeds.
- Report results: what was implemented, what passed, and anything the user should review or test manually.

## When Things Go Wrong

These are the common situations where the plan meets reality:

- **File doesn't exist or moved:** Tell the user. Search for it. Propose the fix.
- **API or library behaves differently than the plan assumed:** Look up the current docs (Context7 / WebFetch), adapt the approach, and explain what changed.
- **A task is more complex than expected:** Break it down, but check with the user if it's significantly more work than the plan suggested.
- **Tests fail after a change:** Read the failure. Fix if it's a direct consequence of the change. If it's a pre-existing issue or unrelated, flag it and move on.
- **You realize the plan has a design flaw:** Stop. Explain the issue and propose an alternative. Don't silently rewrite the approach.
