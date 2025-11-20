---
description: Plan, implement, test, and submit a feature for review autonomously
---
# Implement Feature from PRD

## Objective
Autonomously implement a complete feature based on a PRD. Generate a test-driven task plan, execute all implementation work, validate functionality with the user, and create a pull request for review.

## Initial Setup
**ASK** the user for the **exact file path** of the PRD document to implement.

## Core Principles

### Autonomy
- **Execute autonomously:** Do NOT ask for permission during implementation
- **Make decisions:** Choose appropriate implementations based on PRD requirements and codebase patterns
- **Adapt dynamically:** Add or adjust tasks as you discover new requirements
- **Only pause for:** Manual testing after all implementation is complete

### Quality
- **Test-driven:** Write or update tests alongside implementation
- **Sequential execution:** Complete one task fully before starting the next
- **PRD validation:** Every implementation must satisfy a specific Functional Requirement from the PRD

### Communication
- **Progress updates:** Provide brief status after completing each major task
- **Task tracking:** Use TodoWrite tool to maintain visible progress
- **Transparency:** Document decisions and changes as you work

## Workflow

### Phase 1: Planning & Setup

#### 1.1 Analyze PRD
Read and analyze the PRD, focusing on:
- Functional Requirements (FRs): What must be built
- User Stories: Acceptance criteria and user flows
- Technical Notes: Dependencies, data models, integrations
- UI/UX Guidelines: Interface requirements

#### 1.2 Identify Files
Determine which files need work:
- **Files to Create:** New components, services, utilities, tests
- **Files to Modify:** Existing routes, types, configs, components, tests
- **Documentation:** README updates, API docs (if needed)

#### 1.3 Create Task Plan
Use the TodoWrite tool to create a comprehensive task list with:

**Task Structure:**
- **Setup Tasks:** Branch creation, dependency installation, configuration
- **Implementation Tasks:** Grouped by logical feature area (e.g., Data Layer, Business Logic, UI Components)
- **Testing Tasks:** Unit tests, integration tests, validation against FRs
- **Finalization Tasks:** Documentation updates, cleanup

**Task Naming Convention:**
```
- Setup: Install [dependency] or configure [system]
- Implement: [Component/Function name] - [brief description]
- Test: Validate [FR-X] - [requirement summary]
- Document: Update [file] with [changes]
```

#### 1.4 Git Setup
Create feature branch:
```bash
git checkout main  # or develop, depending on project
git pull origin main
git checkout -b feature/[feature-name]
```
**Branch naming:** Use kebab-case matching the PRD feature name

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
Use conventional commits for each logical unit of work:
```
feat(scope): add [feature]
fix(scope): resolve [issue]
test(scope): add tests for [feature]
docs(scope): update [documentation]
refactor(scope): improve [component]
```

**Commit frequency:** Commit after completing each significant task or sub-feature

#### 2.3 Handle Discoveries
When you discover new requirements or issues:
- Add new tasks to the TodoWrite list
- Document the reason for the addition
- Continue autonomous execution

#### 2.4 Testing Requirements
- Write tests for all new functionality
- Update tests for modified functionality
- Ensure tests cover edge cases and error states mentioned in PRD
- All tests must pass before marking tasks complete

### Phase 3: Validation & Review

#### 3.1 Pre-Validation Checklist
Before requesting manual testing, verify:
- [ ] All tasks in TodoWrite list are completed
- [ ] All tests pass
- [ ] Code follows project style and conventions
- [ ] All Functional Requirements from PRD are implemented
- [ ] Error handling and edge cases are covered
- [ ] Documentation is updated

#### 3.2 Request Manual Testing
Once all implementation is complete:

1. **Summarize what was built:**
   - List all implemented features
   - Highlight key functionality to test
   - Note any edge cases or special scenarios

2. **Provide testing instructions:**
   - How to run the application
   - Specific user flows to test
   - Expected behavior for each flow

3. **Ask user to test:**
   - Request thorough manual testing
   - Ask them to verify each key feature works as expected
   - Wait for their approval before proceeding

#### 3.3 Handle Testing Feedback
If user reports issues:
- Add new tasks for fixes to TodoWrite
- Implement fixes autonomously
- Re-test and request validation again

### Phase 4: Pull Request Submission

#### 4.1 Create Pull Request
Once user approves manual testing, create PR using gh CLI:

```bash
gh pr create --title "[Feature Name]" --body "$(cat <<'EOF'
## Summary
[2-3 bullet points describing what was built and why]

## Changes
- [Key change 1]
- [Key change 2]
- [Key change 3]

## Testing
- [x] All unit/integration tests pass
- [x] Manual testing completed and approved
- [ ] Ready for code review

## Related
Implements PRD: [link to PRD file if in repo]
Closes #[issue-number] (if applicable)
EOF
)"
```

**PR Title Format:** Clear, descriptive, matching the feature name

**PR Body:** Include summary, key changes, testing status, and links to related docs

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
- Push changes to the feature branch
- Request re-review if needed
- Notify user that all feedback has been addressed

## Completion Criteria

### Implementation Complete When:
- [ ] All tasks in TodoWrite are marked completed
- [ ] All tests pass
- [ ] All Functional Requirements from PRD are satisfied
- [ ] Code is committed with clear, conventional commit messages
- [ ] User has manually tested and approved functionality

### PR Complete When:
- [ ] Pull request created with descriptive title and body
- [ ] All review comments addressed (if applicable)
- [ ] CI/CD checks pass
- [ ] User is notified of PR status

## Success Definition
Success means:
- Feature works exactly as specified in the PRD
- All tests pass and cover critical functionality
- User has tested and approved the implementation
- PR is ready for merge with all feedback addressed
- No silent divergence from the task plan (all changes are tracked)
