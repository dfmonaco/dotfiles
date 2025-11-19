---
description: Execute task lists with a simple TDD workflow
---

# Execute task lists

## Initial Step
**ASK** the user for the **exact file path** of the feature task list document to begin processing.

## Git Workflow

**Create a new branch** before starting:
```bash
git checkout develop
git pull origin develop
git checkout -b feature/[feature-name]
```

**Branch Naming:** Use kebab-case (e.g., `feature/user-profile-editing`)

## Core principles

- **Sequential:** Work on one sub-task at a time; do not start the next until the current one is fully complete.
- **Test-driven:** Whenever practical, write or update tests alongside the implementation, and require tests to pass before marking tasks complete.
- **Validated:** Check each sub-task against its acceptance criteria and the PRD intent.

## Maintaining the task list

- Keep the task list as the single source of truth for progress.
- Add or adjust tasks when new work is discovered, rather than silently diverging.
- Keep any "Relevant Files" or similar sections reasonably up to date.
- When things change significantly, briefly note the change so future readers understand why.

## Communication

Throughout the process:

- Provide short status updates after each sub-task: what changed, what was tested, and current progress within the parent task.

Success means the task list matches reality, tests cover the implemented behavior, and the feature satisfies the PRD requirements.
