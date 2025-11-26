---
description: Plan, implement, test, and submit any task for review autonomously
---

# Task Implement

## Objective
Autonomously implement any task (feature, bug fix, refactoring, etc.) based on a task document. Generate a test-driven task plan, execute all implementation work, validate functionality with the user, and create a pull request for review.

## Input
Optional task document path via `$ARGUMENTS`. If not provided, the command will attempt to auto-detect the task document based on the current branch name.

## Core Principles

### Autonomy
- **Execute autonomously:** Do NOT ask for permission during implementation
- **Make decisions:** Choose appropriate implementations based on task requirements and codebase patterns
- **Adapt dynamically:** Add or adjust tasks as you discover new requirements
- **Only pause for:** Manual testing after all implementation is complete

### Quality
- **Test-driven:** Write or update tests alongside implementation
- **Sequential execution:** Complete one task fully before starting the next
- **Requirements validation:** Every implementation must satisfy specific requirements from the task document

### Communication
- **Progress updates:** Provide brief status after completing each major task
- **Task tracking:** Use TodoWrite tool to maintain visible progress
- **Transparency:** Document decisions and changes as you work

## Process

### Phase 1: Planning & Setup

#### 1.0 Locate Task Document
Determine which task document to implement by detecting task type from branch:

**Auto-detection (preferred):**
1. Get current branch name:
   ```bash
   git branch --show-current
   ```

2. Detect task type from branch prefix and locate document in tasks.json:

```bash
# Read tasks.json and find task matching current branch
BRANCH=$(git branch --show-current)
TASK=$(jq -r --arg branch "$BRANCH" '.tasks[] | select(.branch == $branch)' ./docs/tasks/tasks.json)
```

**Detection Logic:**
- Extract task from tasks.json where `branch` field matches current branch
- If found: Use the `id` field to locate the folder (e.g., `20250122-001-user-profile`)
- Build document path based on task type:
  - `type: "feature"` → `./docs/tasks/[id]/prd-[name].md`
  - `type: "bug"` → `./docs/tasks/[id]/bug-[name].md`
  - `type: "refactor"` → `./docs/tasks/[id]/refactor-[name].md`
- If found AND matches: Use automatically (no confirmation needed)
- If not found in tasks.json: Fall back to legacy path detection

**Legacy Path Detection (fallback):**
If task not found in tasks.json, try legacy folder structure:

| Branch Pattern | Task Type  | Expected Document Path                            |
|---------------|------------|---------------------------------------------------|
| `feature/*`   | Feature    | `./docs/tasks/[name]/prd-[name].md`              |
| `fix/*`       | Bug Fix    | `./docs/tasks/[name]/bug-[name].md`              |
| `refactor/*`  | Refactor   | `./docs/tasks/[name]/refactor-[name].md`         |

**Manual input (last resort):**
- If not on a recognized branch OR no matching document found OR user provided explicit path via `$ARGUMENTS`
- Ask user for the exact file path of the task document

**Examples:**
```
Branch: feature/user-profile-editing
tasks.json lookup: finds id="20250122-001-user-profile-editing"
Expected: ./docs/tasks/20250122-001-user-profile-editing/prd-user-profile-editing.md

Branch: fix/auth-timeout
tasks.json lookup: finds id="20250122-002-auth-timeout"
Expected: ./docs/tasks/20250122-002-auth-timeout/bug-auth-timeout.md

Branch: refactor/database-layer
tasks.json lookup: finds id="20250122-003-database-layer"
Expected: ./docs/tasks/20250122-003-database-layer/refactor-database-layer.md
```

#### 1.1 Analyze Task Document
Read and analyze the task document. Adapt focus based on task type:

**For Features (prd-*):**
- Functional Requirements (FRs): What must be built
- User Stories: Acceptance criteria and user flows
- Technical Notes: Dependencies, data models, integrations
- UI/UX Guidelines: Interface requirements

**For Bug Fixes (bug-*):**
- Root Cause: What's causing the issue
- Reproduction Steps: How to verify the bug
- Fix Requirements: What needs to change
- Regression Prevention: Tests to prevent recurrence

**For Refactorings (refactor-*):**
- Current State: What exists now and why it's problematic
- Target State: What the end result should look like
- Refactoring Requirements: Specific changes to make
- Safety Requirements: No breaking changes, comprehensive tests

#### 1.2 Identify Files
Determine which files need work:
- **Files to Create:** New components, services, utilities, tests
- **Files to Modify:** Existing routes, types, configs, components, tests
- **Documentation:** README updates, API docs (if needed)

#### 1.3 Create Task Plan
Use the TodoWrite tool to create a comprehensive task list with:

**Task Structure:**
- **Setup Tasks:** Dependency installation, configuration, environment setup
- **Implementation Tasks:** Grouped by logical area (e.g., Data Layer, Business Logic, UI Components)
- **Testing Tasks:** Unit tests, integration tests, validation against requirements
- **Finalization Tasks:** Documentation updates, cleanup

**Task Naming Convention (adapt based on task type):**

For Features:
```
- Setup: Install [dependency] or configure [system]
- Implement: [Component/Function name] - [brief description]
- Test: Validate [FR-X] - [requirement summary]
- Document: Update [file] with [changes]
```

For Bug Fixes:
```
- Setup: Reproduce bug in test environment
- Fix: [Component/Function] - [root cause addressed]
- Test: Verify fix with [scenario]
- Test: Add regression test for [bug scenario]
- Verify: Confirm original reproduction steps no longer produce error
```

For Refactorings:
```
- Setup: Baseline current test results
- Refactor: [Component/Function] - [improvement made]
- Test: Verify [existing behavior] still works
- Test: Add tests for refactored code
- Verify: No breaking changes, all tests pass
```

#### 1.4 Git Setup & Update Task Status
Check if already on the correct task branch and update task status:

```bash
git branch --show-current
```

**Update tasks.json status:**
```bash
# Find and update task status to "in_progress"
jq --arg branch "$(git branch --show-current)" \
   '(.tasks[] | select(.branch == $branch) | .status) = "in_progress"' \
   ./docs/tasks/tasks.json > tmp.json && mv tmp.json ./docs/tasks/tasks.json

# Commit the status change
git add docs/tasks/tasks.json
git commit -m "chore: mark task as in_progress"
```

**If already on task branch (e.g., from planning command):**
- Stay on current branch
- Update task status to "in_progress" in tasks.json
- Ensure branch is up to date with main/develop:
  ```bash
  git fetch origin
  git merge origin/main  # or origin/develop
  ```

**If on main/develop or another branch:**
- Create task branch with appropriate prefix:
  ```bash
  git checkout main  # or develop, depending on project
  git pull origin main
  git checkout -b [prefix]/[task-name]
  ```
- Update task status to "in_progress" in tasks.json
  
**Branch prefixes by task type:**
- Features: `feature/[name]`
- Bug Fixes: `fix/[name]`
- Refactorings: `refactor/[name]`

**Note:** If the task document was created via a planning command, you should already be on the correct branch and the task should be in tasks.json.

### Phase 2: Implementation

#### 2.1 Execute Tasks Sequentially
For each task:

1. **Mark as in_progress** using TodoWrite
2. **Implement** the functionality
3. **Write/update tests** to validate the implementation
4. **Run tests** to ensure they pass
5. **Commit** with conventional commit message
6. **Mark as completed** using TodoWrite
7. **Move to next task**

#### 2.2 Commit Strategy
Use conventional commits with appropriate prefix based on task type:

**For Features:**
```
feat(scope): add [feature]
test(scope): add tests for [feature]
docs(scope): update [documentation]
```

**For Bug Fixes:**
```
fix(scope): resolve [issue]
test(scope): add regression test for [bug]
docs(scope): document [fix]
```

**For Refactorings:**
```
refactor(scope): improve [component]
test(scope): add tests for refactored [code]
docs(scope): update [documentation]
```

**Commit frequency:** Commit after completing each significant task or sub-task

#### 2.3 Handle Discoveries
When you discover new requirements or issues:
- Add new tasks to the TodoWrite list
- Document the reason for the addition
- Continue autonomous execution

#### 2.4 Testing Requirements

**For Features:**
- Write tests for all new functionality
- Update tests for modified functionality
- Ensure tests cover edge cases and error states mentioned in PRD
- All tests must pass before marking tasks complete

**For Bug Fixes:**
- Add regression test that would have caught the bug
- Verify fix with original reproduction steps
- Test edge cases related to the bug
- Ensure no new issues introduced

**For Refactorings:**
- All existing tests must continue to pass
- Add new tests for refactored code
- Verify no breaking changes
- Performance testing if applicable

### Phase 3: Validation & Review

#### 3.1 Pre-Validation Checklist
Before requesting manual testing, verify:
- [ ] All tasks in TodoWrite list are completed
- [ ] All tests pass
- [ ] Code follows project style and conventions
- [ ] All requirements from task document are satisfied
- [ ] Error handling and edge cases are covered
- [ ] Documentation is updated

**Update tasks.json status:**
```bash
# Update task status (keep as "in_progress" until user approves)
# We'll mark it "done" only after manual testing approval
```

**Task-specific checks:**

For Features:
- [ ] All Functional Requirements implemented
- [ ] User flows work as specified

For Bug Fixes:
- [ ] Original bug is resolved
- [ ] Regression test added
- [ ] Root cause addressed

For Refactorings:
- [ ] No breaking changes to public APIs
- [ ] Performance maintained or improved
- [ ] Code complexity reduced

#### 3.2 Request Manual Testing
Once all implementation is complete:

1. **Summarize what was built/fixed/refactored:**
   - List all changes made
   - Highlight key functionality to test
   - Note any edge cases or special scenarios

2. **Provide testing instructions:**
   - How to run the application
   - Specific flows/scenarios to test
   - Expected behavior for each

3. **Ask user to test:**
   - Request thorough manual testing
   - Ask them to verify each key change works as expected
   - Wait for their approval before proceeding

#### 3.3 Handle Testing Feedback
If user reports issues:
- Add new tasks for fixes to TodoWrite
- Implement fixes autonomously
- Re-test and request validation again

**If user approves:**
Update tasks.json to mark task as complete:
```bash
# Update task status to "done" and add completion timestamp
jq --arg branch "$(git branch --show-current)" \
   --arg completed "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
   '(.tasks[] | select(.branch == $branch) | .status) = "done" | 
    (.tasks[] | select(.branch == $branch) | .completed) = $completed | 
    (.tasks[] | select(.branch == $branch) | .priority) = null' \
   ./docs/tasks/tasks.json > tmp.json && mv tmp.json ./docs/tasks/tasks.json

# Commit the status change
git add docs/tasks/tasks.json
git commit -m "chore: mark task as completed"
```

**Notes:**
- `status` changes to "done"
- `completed` timestamp added
- `priority` set to null (completed tasks don't need priority)

### Phase 4: Pull Request Submission

#### 4.1 Create Pull Request
Once user approves manual testing, create PR using gh CLI.

**PR Title Format (adapt based on task type):**
- Features: `feat: [feature name]`
- Bug Fixes: `fix: [bug description]`
- Refactorings: `refactor: [refactoring description]`

**PR Body Template:**
```bash
gh pr create --title "[Type]: [Name]" --body "$(cat <<'EOF'
## Summary
[2-3 bullet points describing what was done and why]

## Changes
- [Key change 1]
- [Key change 2]
- [Key change 3]

## Testing
- [x] All unit/integration tests pass
- [x] Manual testing completed and approved
- [ ] Ready for code review

## Type-Specific Section
[For features: User stories satisfied]
[For bugs: Fixes #issue-number, Root cause addressed]
[For refactors: No breaking changes, Performance impact]

## Related
[Link to task document if in repo]
[Link to related issues or PRs]
EOF
)"
```

#### 4.2 Return PR URL
Provide the user with the PR URL so they can track it.

### Phase 5: Review Management

#### 5.1 Fetch Review Comments
When user asks you to check PR review comments, use gh CLI:

```bash
# Fetch PR comments
gh pr view [pr-number] --comments

# Fetch review comments specifically
gh api repos/{owner}/{repo}/pulls/[pr-number]/comments

# Get PR status and checks
gh pr checks [pr-number]
```

#### 5.2 Analyze Feedback
Review all comments and:
- Categorize by type (blocking issues, suggestions, questions, nitpicks)
- Prioritize blocking issues and critical feedback
- Create new tasks in TodoWrite for each item requiring action

#### 5.3 Address Feedback
For each review comment requiring changes:
- Implement the requested change
- Add tests if needed
- Commit with reference to the review comment
- Reply to the comment (if needed) using gh CLI:
  ```bash
  gh pr comment [pr-number] --body "Fixed in [commit-hash]"
  ```

#### 5.4 Update PR
After addressing all feedback:
- Push changes to the task branch
- Request re-review if needed
- Notify user that all feedback has been addressed

## Output
- Comprehensive implementation of task from document
- All tests passing
- Git commits following conventional commit format
- tasks.json updated with task status:
  - Status changed from "pending" → "in_progress" → "done"
  - Completion timestamp added
  - Priority cleared (set to null)
- Pull request created and ready for review
- User validation and approval

## Success Criteria

### Implementation Complete When:
- [ ] All tasks in TodoWrite are marked completed
- [ ] All tests pass
- [ ] All requirements from task document are satisfied
- [ ] Code is committed with clear, conventional commit messages
- [ ] User has manually tested and approved functionality
- [ ] tasks.json updated with status="done" and completion timestamp

### PR Complete When:
- [ ] Pull request created with descriptive title and body
- [ ] All review comments addressed (if applicable)
- [ ] CI/CD checks pass
- [ ] User is notified of PR status
- [ ] tasks.json changes committed and pushed

## Notes

### Success Definition
Success means:
- Task is completed exactly as specified in the document
- All tests pass and cover critical functionality
- User has tested and approved the implementation
- PR is ready for merge with all feedback addressed
- No silent divergence from the task plan (all changes are tracked)

### Task Type Detection
The command automatically adapts its behavior based on:
1. **Branch prefix** (feature/, fix/, refactor/)
2. **Document prefix** (prd-, bug-, refactor-)
3. **Task type influences:**
   - Commit message prefixes
   - Testing focus and requirements
   - Validation criteria
   - PR title and body format

### Flexibility
While the command auto-detects task type, you can always:
- Manually specify the task document path via `$ARGUMENTS`
- Use any branch naming convention (auto-detection is a convenience)
- Mix and match approaches as needed for your workflow
