---
description: Implement any task (feature, bug, refactor) autonomously from a task document
---

# Task Implement

## Objective
Autonomously implement a task from its document, validate with user, and create a pull request.

## Core Principles
- **Autonomous:** Execute without asking permission, only pause for manual testing
- **Test-driven:** Write/update tests alongside implementation
- **Sequential:** Complete one task fully before starting the next
- **Tracked:** Use TodoWrite to maintain visible progress

## Process

### Phase 1: Setup

#### 1.1 Locate Task Document
Auto-detect from current branch:
```bash
BRANCH=$(git branch --show-current)
```

Find task in tasks.json matching branch, then locate document:
- `type: "feature"` → `./docs/tasks/[id]/feature-[name].md`
- `type: "bug"` → `./docs/tasks/[id]/bug-[name].md`
- `type: "refactor"` → `./docs/tasks/[id]/refactor-[name].md`

If not found: ask user for the document path.

#### 1.2 Analyze & Plan
Read the task document and identify:
- Requirements to implement
- Files to create/modify
- Tests to write

Create task list using TodoWrite:
- Setup tasks (dependencies, config)
- Implementation tasks (grouped by area)
- Testing tasks
- Documentation tasks

#### 1.3 Update Task Status
```bash
jq --arg branch "$(git branch --show-current)" \
   '(.tasks[] | select(.branch == $branch) | .status) = "in_progress"' \
   ./docs/tasks/tasks.json > tmp.json && mv tmp.json ./docs/tasks/tasks.json
git add docs/tasks/tasks.json && git commit -m "chore: mark task as in_progress"
```

### Phase 2: Implementation

For each task:
1. Mark as in_progress (TodoWrite)
2. Implement the change
3. Write/update tests
4. Run tests
5. Commit with conventional message
6. Mark as completed (TodoWrite)

**Commit prefixes by type:**
- Features: `feat(scope): ...`
- Bug fixes: `fix(scope): ...`
- Refactors: `refactor(scope): ...`

**Handle discoveries:** Add new tasks to TodoWrite as needed, continue autonomously.

### Phase 3: Validation

#### 3.1 Pre-validation
Verify before requesting manual testing:
- All TodoWrite tasks completed
- All tests pass
- All requirements satisfied

#### 3.2 Request Manual Testing
Summarize changes and provide testing instructions. Wait for user approval.

#### 3.3 Handle Feedback
If issues reported: add fix tasks, implement, re-test.

If approved, update tasks.json:
```bash
jq --arg branch "$(git branch --show-current)" \
   --arg completed "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
   '(.tasks[] | select(.branch == $branch) | .status) = "done" | 
    (.tasks[] | select(.branch == $branch) | .completed) = $completed | 
    (.tasks[] | select(.branch == $branch) | .priority) = null' \
   ./docs/tasks/tasks.json > tmp.json && mv tmp.json ./docs/tasks/tasks.json
git add docs/tasks/tasks.json && git commit -m "chore: mark task as completed"
```

### Phase 4: Pull Request

Create PR after user approves:
```bash
gh pr create --title "[type]: [name]" --body "$(cat <<'EOF'
## Summary
[2-3 bullet points]

## Changes
- [Key changes]

## Testing
- [x] All tests pass
- [x] Manual testing approved
EOF
)"
```

Return PR URL to user.

### Phase 5: Review Management

When user asks to check PR comments:
```bash
gh pr view [pr-number] --comments
gh api repos/{owner}/{repo}/pulls/[pr-number]/comments
```

For each comment requiring changes:
- Implement fix
- Commit with reference
- Push and notify user

## Output
- Task implemented per document
- All tests passing
- Conventional commits
- tasks.json updated (pending → in_progress → done)
- Pull request created
