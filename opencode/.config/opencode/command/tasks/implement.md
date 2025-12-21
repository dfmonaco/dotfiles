---
description: Implement any task (feature, bug, refactor) from a task document in autonomous or guided mode
---

# Task Implement

## Objective
Implement a task from its document using one of two modes:
- **Autonomous (`auto`):** Execute without asking permission, only pause for manual testing at the end
- **Guided (`guide`):** Step-by-step implementation with user approval and atomic commits after each step

## Core Principles
- **Test-driven:** Write/update tests alongside implementation
- **Sequential:** Complete one task fully before starting the next
- **Tracked:** Use TodoWrite to maintain visible progress
- **Atomic commits:** Each step should result in a single, coherent commit (critical in guided mode)

---

## Prerequisites
- `jq` — Required for JSON manipulation
- `gh` — GitHub CLI for PR creation (Phase 5)

---

## Mode Selection

### Invocation
- `/tasks/implement auto` — Run autonomously
- `/tasks/implement guide` — Run with step-by-step guidance
- `/tasks/implement` — Ask user which mode to use

### Mode Selection Prompt (when no argument provided)
```
Which implementation mode would you like to use?

1. **auto** — I'll implement the entire task autonomously, only pausing for final manual testing.
2. **guide** — I'll present a step-by-step plan, implement each step one at a time, and wait for your approval before committing.

Reply with `1`, `2`, `auto`, or `guide`.
```

---

## Phase 1: Setup (Both Modes)

### 1.1 Locate Task Document
Auto-detect from current branch:
```bash
BRANCH=$(git branch --show-current)
```

Find task in tasks.json matching branch, then locate document:
- `type: "feature"` → `./docs/tasks/[id]/feature-[name].md`
- `type: "bug"` → `./docs/tasks/[id]/bug-[name].md`
- `type: "refactor"` → `./docs/tasks/[id]/refactor-[name].md`

If not found: ask user for the document path.

### 1.2 Analyze Task Document
Read the task document and identify:
- Requirements to implement (FR-1, BF-1, RR-1, etc.)
- Files to create/modify
- Tests to write
- Dependencies or setup needed

### 1.3 Update Task Status
```bash
jq --arg branch "$(git branch --show-current)" \
   '(.tasks[] | select(.branch == $branch) | .status) = "in_progress"' \
   ./docs/tasks/tasks.json > tmp.json && mv tmp.json ./docs/tasks/tasks.json
git add docs/tasks/tasks.json && git commit -m "chore: mark task as in_progress"
```

---

## Phase 2: Planning

### 2.0 Implementation Autonomy
The task document defines requirements and constraints — not implementation details.
You have full autonomy to:
- Choose approaches, libraries, and patterns
- Deviate from any technical suggestions in the task document
- Adapt the plan based on what you discover during implementation

If the task document contains implementation details, treat them as suggestions, not instructions.

### 2.1 Create Implementation Plan
Design a step-by-step plan where **each step is an atomic unit** that:
- Implements a logical piece of functionality
- Includes its associated tests
- Can be committed independently without breaking the build
- Is coherent and reviewable on its own

**Step grouping guidelines:**
- Group by logical unit, not by file (e.g., "Add User model + tests" not "Add User model" then "Add User tests")
- Each step should pass all tests after completion
- Steps should build upon each other sequentially

**Example plan structure:**
```
Step 1: Add data models for [feature]
Step 2: Implement [service/logic] with unit tests
Step 3: Add API endpoints with integration tests
Step 4: Update documentation
```

### 2.2 Present Plan

#### In Guided Mode
Present the plan and wait for explicit approval:

```
## Implementation Plan

I've analyzed the task document and created the following implementation plan.
Each step is atomic and will be committed separately after your approval.

**Step 1:** [Brief description]
- Files: [list of files to create/modify]
- Tests: [tests to add/update]

**Step 2:** [Brief description]
- Files: [list of files to create/modify]
- Tests: [tests to add/update]

[... additional steps ...]

---

Do you approve this plan? Reply `yes` to proceed, or provide feedback to adjust.
```

#### In Autonomous Mode
Create the plan internally using TodoWrite. Do not wait for approval—proceed to implementation.

---

## Phase 3: Implementation

### Autonomous Mode (`auto`)

For each step:
1. Mark as in_progress (TodoWrite)
2. Implement the change
3. Write/update tests
4. Run tests to verify
5. Commit with conventional message
6. Mark as completed (TodoWrite)

**Continue autonomously** until all steps complete. Handle discoveries by adding new tasks to TodoWrite.

**Commit prefixes by type:**
- Features: `feat(scope): ...`
- Bug fixes: `fix(scope): ...`
- Refactors: `refactor(scope): ...`
- Tests: `test(scope): ...`
- Docs: `docs(scope): ...`

---

### Guided Mode (`guide`)

For each step:

#### 3.1 Announce Step
```
## Step [N]: [Step Title]

Starting implementation of this step.

**What I'll do:**
- [Action 1]
- [Action 2]
- [...]

Implementing now...
```

#### 3.2 Implement
- Mark step as in_progress (TodoWrite)
- Implement the changes
- Write/update associated tests
- Run tests

#### 3.3 Present Summary and Wait for Approval
```
## Step [N] Complete: [Step Title]

**Rationale — Why These Changes Were Needed:**
[CRITICAL: This section is mandatory. Explain the motivation behind this step.
Connect to requirements from the task document. What problem does this solve?
What capability does it enable? The reviewer must understand the purpose before approving.]

**Files changed:**
- `path/to/file1.ts` — [brief description of change]
- `path/to/file2.ts` — [brief description of change]

**Tests:**
- [X passed, Y total] — All tests passing

**Proposed commit:**
`feat(scope): add [description]`

---

Reply `approve` to commit and continue, or provide feedback for adjustments.
```

#### 3.4 Handle Response
- **If approved:** Commit the changes, mark step as completed (TodoWrite), proceed to next step
- **If feedback provided:** Make requested adjustments, re-run tests, present updated summary

#### 3.5 Commit
```bash
git add [relevant files]
git commit -m "[conventional commit message]"
```

#### 3.6 Repeat
Continue to next step. Repeat 3.1–3.5 until all steps complete.

---

## Phase 4: Validation (Both Modes)

### 4.1 Pre-validation
Verify before requesting manual testing:
- All TodoWrite tasks completed
- All tests pass
- All requirements from task document satisfied

### 4.2 Request Manual Testing
Summarize all changes and provide testing instructions:

```
## Implementation Complete

All steps have been implemented and committed.

**Summary of changes:**
- [Key change 1]
- [Key change 2]
- [...]

**Testing instructions:**
1. [Step to verify functionality]
2. [Step to verify functionality]
3. [...]

Please test and reply `approved` if everything works, or describe any issues.
```

### 4.3 Handle Feedback
If issues reported:
- Add fix tasks to TodoWrite
- Implement fixes (following mode-appropriate workflow)
- Re-test and re-request approval

### 4.4 Update tasks.json (After Approval)
```bash
jq --arg branch "$(git branch --show-current)" \
   --arg completed "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
   '(.tasks[] | select(.branch == $branch) | .status) = "done" | 
    (.tasks[] | select(.branch == $branch) | .completed) = $completed | 
    (.tasks[] | select(.branch == $branch) | .priority) = null' \
   ./docs/tasks/tasks.json > tmp.json && mv tmp.json ./docs/tasks/tasks.json
git add docs/tasks/tasks.json && git commit -m "chore: mark task as completed"
```

---

## Phase 5: Pull Request (Both Modes)

Create PR after user approves manual testing:

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

---

## Phase 6: Review Management (Both Modes)

When user asks to check PR comments:
```bash
gh pr view [pr-number] --comments
gh api repos/{owner}/{repo}/pulls/[pr-number]/comments
```

For each comment requiring changes:
- Implement fix
- Commit with reference
- Push and notify user

---

## Phase 7: Merge (Both Modes)

After all PR review comments are addressed, ask for explicit confirmation:

```
All review feedback has been addressed.

Reply `merge` to merge the PR and delete the remote branch.
```

**After user confirms:**
```bash
gh pr merge --merge --delete-branch
```

Confirm merge completion to user.

---

## Output
- Task implemented per document
- All tests passing
- Conventional commits (atomic in guided mode)
- tasks.json updated (pending → in_progress → done)
- Pull request created and merged
- Remote branch deleted
