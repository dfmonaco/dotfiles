---
description: List all tasks from tasks.json with their status
---

# Task List

## Objective
Display all tasks from tasks.json in a readable format.

## Process

### 1. Check tasks.json Exists
```bash
if [ ! -f ./docs/tasks/tasks.json ]; then
  echo "No tasks.json found. Run /tasks/feature, /tasks/bug, or /tasks/refactor to create one."
  exit 0
fi
```

### 2. Display Tasks
```bash
jq -r '.tasks[] | "[\(.status | ascii_upcase)] \(.type): \(.description) (branch: \(.branch))"' ./docs/tasks/tasks.json
```

If no tasks exist, display: "No tasks found."

## Output
List of tasks with status, type, description, and branch.
