---
description: Autonomously implement a feature based on PRD, adapting architecture as needed based on implementation feedback
---

# Feature Implementation

## Objective

Autonomously implement a feature based on its PRD. Start with the planned architecture but adapt based on real feedback from tests, compilers, and runtime behavior. Execute with transparency: explicitly note deviations but continue without blocking for approval.

## Input

Optional PRD path via `$ARGUMENTS`. If not provided, auto-detect based on current branch and tasks.json.

## Core Principles

### 1. Start with Architecture Guidance

- Begin with the recommended architecture from the PRD
- Use the Codebase Analysis and Key Design Decisions as starting points
- Follow the Implementation Structure unless feedback suggests otherwise

### 2. Adapt Based on Implementation Feedback

The PRD was written without the benefit of:
- Actual test failures and edge cases discovered
- Compiler and type errors
- Runtime behavior and performance characteristics
- Integration issues with existing code

**You SHOULD deviate from the plan when:**
- Tests reveal the approach won't work or is overly complex
- Compiler/type errors indicate a different structure is needed
- Runtime behavior shows performance or correctness issues
- Existing code patterns discovered during work suggest better integration
- Security or data integrity concerns emerge

**When deviating:**
- ✅ **Explicit:** Mention it clearly: "Pivoting from middleware to hybrid approach because [specific feedback]"
- ✅ **Non-blocking:** Continue immediately, don't wait for approval
- ✅ **Documented:** Note reasoning in commit message
- ✅ **Transparent:** Summarize deviations in PR description

### 3. Autonomous Execution

- **Execute autonomously:** Do NOT ask for permission during implementation
- **Make decisions:** Choose implementations based on requirements + feedback
- **Adapt dynamically:** Add or adjust tasks as you discover new requirements
- **Only pause for:** Manual testing after all implementation is complete

### 4. Quality Standards

- **Test-driven:** Write or update tests alongside implementation
- **Sequential execution:** Complete one task fully before starting the next
- **Requirements validation:** Every implementation must satisfy specific FRs from PRD
- **Commit atomically:** Follow conventional commits, one logical unit per commit

### 5. Communication

- **Progress updates:** Brief status after completing each major task
- **Task tracking:** Use TodoWrite tool to maintain visible progress
- **Transparency:** Document decisions and deviations as you work

## Process

### Phase 1: Planning & Setup

#### 1.0 Locate PRD

Determine which PRD to implement:

**Auto-detection (preferred):**

1. Get current branch name:
   ```bash
   git branch --show-current
   ```

2. Look up task in tasks.json:
   ```bash
   BRANCH=$(git branch --show-current)
   TASK=$(jq -r --arg branch "$BRANCH" '.tasks[] | select(.branch == $branch)' ./docs/tasks/tasks.json)
   ```

3. Build PRD path:
   - Extract `id` field from task (e.g., `20250122-001-user-profile-editing`)
   - Extract `type` field
   - If `type === "feature"`: PRD path is `./docs/tasks/[id]/prd-[name].md`
   - If found and exists: Use automatically (no confirmation needed)

**Legacy fallback:**

If not found in tasks.json, try legacy path:
- Branch: `feature/user-profile` → `./docs/tasks/user-profile/prd-user-profile.md`

**Manual input (last resort):**

If auto-detection fails or user provided explicit `$ARGUMENTS`:
- Ask user for exact PRD file path

**Examples:**
```
Branch: feature/user-profile-editing
tasks.json lookup: finds id="20250122-001-user-profile-editing"
Expected PRD: ./docs/tasks/20250122-001-user-profile-editing/prd-user-profile-editing.md
```

#### 1.1 Analyze PRD

Read and deeply understand the PRD:

**Focus on:**
- **Functional Requirements (FR-N):** What must be built (these are your acceptance criteria)
- **User Stories:** User flows and expected behavior
- **Architectural Approach:** Recommended architecture, codebase analysis, key decisions
- **Non-Functional Requirements:** Performance, security, constraints
- **UI/UX Guidelines:** Interface requirements and states

**Remember:** Architecture is guidance, not rigid specification. Implementation feedback may reveal better approaches.

#### 1.2 Identify Files

Based on PRD's Architecture → Implementation Structure section and your own analysis:

- **Files to create:** New components, services, utilities, tests
- **Files to modify:** Existing routes, types, configs, components, tests
- **Documentation:** README updates, API docs (if needed)

The PRD provides a starting point, but you may discover more files during implementation.

#### 1.3 Create Task Plan

Use TodoWrite to create a comprehensive task list:

**Task Structure:**

```markdown
**Setup Tasks**
- Install [dependency] or configure [system]

**Implementation Tasks** (grouped by logical area)
- Implement: [Component/Function] - [brief description]
- Test: [Component/Function] - validate [FR-N]

**Validation Tasks**
- Verify: All functional requirements (FR-1 through FR-N)
- Test: Integration scenarios from user stories

**Finalization Tasks**
- Document: Update [file] with [changes]
- Clean: Remove debug code, unused imports
```

**Task Naming Convention:**
```
- Setup: Install [dependency] or configure [system]
- Implement: [Component/Function name] - [brief description]
- Test: Validate [FR-X] - [requirement summary]
- Verify: [User story or integration scenario]
- Document: Update [file] with [changes]
```

**Example:**
```
1. Setup: Install dependencies (if needed)
2. Implement: ProfileValidator middleware - validation logic
3. Test: ProfileValidator - validate FR-1, FR-4, FR-5
4. Implement: Profile API route - integrate middleware
5. Test: Profile route - validate FR-2, FR-6, FR-7
6. Implement: ProfileForm component - UI with inline errors
7. Test: ProfileForm - validate FR-3, FR-8, user story #1
8. Verify: End-to-end profile editing flow
9. Document: Update README with new validation rules
```

#### 1.4 Git Setup & Update Task Status

Check current branch and update task status:

```bash
git branch --show-current
```

**Update tasks.json status to "in_progress":**

```bash
jq --arg branch "$(git branch --show-current)" \
   '(.tasks[] | select(.branch == $branch) | .status) = "in_progress"' \
   ./docs/tasks/tasks.json > tmp.json && mv tmp.json ./docs/tasks/tasks.json

git add docs/tasks/tasks.json
git commit -m "chore: mark task as in_progress"
```

**If already on task branch (from planning):**
- Stay on current branch
- Update status to "in_progress"
- Ensure branch is up to date:
  ```bash
  git fetch origin
  git merge origin/main  # or origin/develop
  ```

**If on different branch:**
- Create feature branch:
  ```bash
  git checkout main
  git pull origin main
  git checkout -b feature/[feature-name]
  ```
- Update status to "in_progress"

### Phase 2: Implementation

#### 2.1 Execute Tasks Sequentially

For each task in your plan:

1. **Mark as in_progress** (TodoWrite)
2. **Implement** the functionality
   - Start with PRD's recommended approach
   - Use patterns from Codebase Analysis
   - Follow Key Design Decisions as guidance
3. **Write/update tests** to validate against specific FRs
4. **Run tests** - observe failures and feedback
5. **Adapt if needed** based on test feedback
6. **Commit** with conventional commit message
7. **Mark as completed** (TodoWrite)
8. **Move to next task**

#### 2.2 Making Implementation Decisions

**Use this priority order:**

1. **PRD's Functional Requirements** - Non-negotiable, must satisfy all FR-N items
2. **PRD's Recommended Architecture** - Strong starting point
3. **Implementation Feedback** - Tests, compiler, runtime (adapt when this conflicts with #2)
4. **Existing Codebase Patterns** - Consistency matters (discovered during work)
5. **Best Practices** - Industry standards and conventions

**Examples of valid deviations:**

```
✅ "Pivoting from pure middleware approach to hybrid (middleware + route handler validation) 
   because existing middleware lacks async error handling needed for database validation checks 
   discovered in tests"

✅ "Using Context API instead of Redux for this feature state because tests revealed 
   unnecessary re-renders and state is truly local to profile section"

✅ "Adding debouncing to validation (not in PRD) because manual testing showed 
   excessive API calls on every keystroke"
```

**Examples of invalid deviations:**

```
❌ "Skipping FR-7 error handling because it's complex" 
   → Functional requirements are mandatory

❌ "Using different validation library because I prefer it" 
   → Follow existing patterns unless they prevent implementation

❌ "Removing tests to go faster" 
   → Quality standards are not negotiable
```

#### 2.3 Communicating Deviations

When you deviate from the PRD's planned architecture:

**1. Mention explicitly in real-time:**
```
"Deviating from PRD: Using hybrid validation approach instead of pure middleware.

Reason: Tests revealed that middleware runs before body parsing in current setup 
(src/middleware/bodyParser.js:15 runs after auth chain). Hybrid approach validates 
in route handler where body is available.

Continuing with implementation..."
```

**2. Document in commit message:**
```bash
git commit -m "feat(profile): add profile validation with hybrid approach

Use route-handler validation instead of pure middleware approach
planned in PRD due to middleware execution order. Current bodyParser
runs after auth chain, making request body unavailable in middleware.

Implements FR-1, FR-4, FR-5"
```

**3. Note in task list:**
Update your TodoWrite list to reflect the new approach if it changes subsequent tasks.

**4. DO NOT wait for approval:**
State the deviation and reasoning, then continue immediately.

#### 2.4 Commit Strategy

**Commit Frequency:**
Commit after completing each significant task or logical unit of work.

**Conventional Commit Format:**
```
<type>(scope): <subject>

[optional body explaining WHY and any deviations]

[optional footer with FR references]
```

**Types:**
- `feat`: New functionality (implements FRs)
- `test`: Adding or updating tests
- `refactor`: Code restructuring without behavior change
- `fix`: Bug fixes discovered during implementation
- `docs`: Documentation updates
- `chore`: Maintenance (deps, config)

**Examples:**
```bash
# Implementing a feature requirement
git commit -m "feat(profile): add profile name editing with auto-save

Implements FR-1, FR-2, FR-3"

# Adding tests
git commit -m "test(profile): add validation tests for FR-4 and FR-5"

# Documenting a deviation
git commit -m "feat(profile): add error handling with toast notifications

Implements FR-7, FR-8. Uses toast library (react-hot-toast) instead
of custom implementation - library already in project dependencies
and provides accessibility features needed for FR compliance."
```

#### 2.5 Handle Discoveries

When you discover new requirements or issues during implementation:

**Add new tasks:**
```
"Discovered: Need to handle concurrent profile updates (race condition in tests)
Adding task: Implement optimistic locking for profile updates"
```

**Update TodoWrite:**
Add the new tasks to your list.

**Continue autonomously:**
Implement the newly discovered work without asking permission.

**Document in PR:**
Mention discoveries and how they were addressed in the PR description.

#### 2.6 Testing Requirements

**Test Coverage Must Include:**

- ✅ All Functional Requirements (FR-1 through FR-N)
- ✅ Edge cases mentioned in PRD
- ✅ Error states and error handling
- ✅ User stories and flows from PRD
- ✅ Integration with existing features

**Test Types:**

- **Unit tests:** Individual functions, components, utilities
- **Integration tests:** Feature working with real/mocked dependencies
- **End-to-end tests:** Full user flows (if project has E2E setup)

**All tests must pass** before marking tasks complete.

### Phase 3: Validation & Review

#### 3.1 Pre-Validation Checklist

Before requesting manual testing, verify:

**Implementation Complete:**
- [ ] All tasks in TodoWrite list are completed
- [ ] All tests pass
- [ ] All Functional Requirements (FR-1 through FR-N) implemented
- [ ] All user stories from PRD work as specified
- [ ] Error handling and edge cases covered
- [ ] Code follows project style and conventions
- [ ] No debug code, console.logs, or commented-out code
- [ ] Documentation updated (if needed)

**Code Quality:**
- [ ] No linting errors
- [ ] No type errors (if using TypeScript)
- [ ] No security vulnerabilities introduced
- [ ] Performance is acceptable

#### 3.2 Request Manual Testing

Once implementation is complete, provide the user with:

**1. Summary of What Was Built:**
```markdown
## Implementation Complete

**Implemented:**
- All N functional requirements (FR-1 through FR-N)
- User story: [summary of main flow]
- Edge cases: [list key edge cases]

**Architecture:**
- Used: [Actual architecture approach used]
- [If deviated]: Deviated from PRD in [area] because [reasoning]

**Key Changes:**
- Created: [list new files]
- Modified: [list modified files]
- Tests: [X] unit tests, [Y] integration tests

**All tests passing:** ✅
```

**2. Testing Instructions:**
```markdown
## Manual Testing Instructions

**Setup:**
1. [How to run the application]
2. [Any seed data or setup needed]

**Test Scenario 1: [Main User Flow]**
1. [Step-by-step instructions]
2. [Expected behavior at each step]

**Test Scenario 2: [Edge Case]**
1. [Step-by-step instructions]
2. [Expected behavior]

**Test Scenario 3: [Error Handling]**
1. [How to trigger error]
2. [Expected error handling behavior]

**What to look for:**
- [Key functionality to verify]
- [UI/UX elements to check]
- [Error states to test]
```

**3. Request Approval:**
```
Please test the implementation thoroughly and let me know:
- ✅ Approve to proceed with PR creation
- 🔧 Report issues to fix
```

#### 3.3 Handle Testing Feedback

**If user reports issues:**

1. **Acknowledge:** "Thanks for testing. I found [N] issues to address."
2. **Add tasks:** Create new TodoWrite tasks for each fix
3. **Implement fixes:** Work through them autonomously
4. **Re-test:** Run all tests again
5. **Request validation again:** Provide updated testing instructions

**If user approves:**

Proceed to Phase 4 (Pull Request).

**Before proceeding, update tasks.json:**

```bash
# Mark task as complete
jq --arg branch "$(git branch --show-current)" \
   --arg completed "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
   '(.tasks[] | select(.branch == $branch) | .status) = "done" | 
    (.tasks[] | select(.branch == $branch) | .completed) = $completed | 
    (.tasks[] | select(.branch == $branch) | .priority) = null' \
   ./docs/tasks/tasks.json > tmp.json && mv tmp.json ./docs/tasks/tasks.json

git add docs/tasks/tasks.json
git commit -m "chore: mark task as completed"
```

### Phase 4: Pull Request Submission

#### 4.1 Create Pull Request

Once user approves, create PR using gh CLI:

**PR Title:**
```
feat: [feature name matching branch]
```

**PR Body:**

```bash
gh pr create --title "feat: [feature-name]" --body "$(cat <<'EOF'
## Summary
- [What was built and why - 2-3 bullets focusing on user value]
- [Key architectural decisions made]

## Functional Requirements Implemented
- ✅ FR-1: [requirement summary]
- ✅ FR-2: [requirement summary]
- ✅ FR-N: [requirement summary]

## Implementation Approach
**Architecture Used:** [Architecture approach name]

[If followed PRD recommendation]:
Implemented as planned using [approach] from PRD.

[If deviated from PRD]:
**Deviations from PRD:**
- [What changed]: [Why it changed - specific feedback that drove decision]
- [Another change]: [Reasoning]

## Changes
**New Files:**
- `path/to/file.js` - [Purpose]
- `path/to/another.js` - [Purpose]

**Modified Files:**
- `path/to/existing.js` - [What changed]
- `path/to/another.js` - [What changed]

## Testing
- ✅ [X] unit tests added/updated - all passing
- ✅ [Y] integration tests added - all passing
- ✅ Manual testing completed and approved
- ✅ All functional requirements verified
- [ ] Ready for code review

## Related
- PRD: `./docs/tasks/[folder-id]/prd-[name].md`
- Branch: `feature/[name]`
- Task ID: `[folder-id]`
EOF
)"
```

#### 4.2 Return PR URL

Provide the user with the PR URL and summary:

```
✅ Pull request created: [PR URL]

Implementation complete and ready for code review.
All [N] functional requirements implemented and tested.
```

### Phase 5: Review Management

#### 5.1 Fetch Review Comments

When user asks to check PR review comments:

```bash
# View PR with comments
gh pr view [pr-number] --comments

# Get review comments from API (more detailed)
gh api repos/{owner}/{repo}/pulls/[pr-number]/comments

# Check PR status and CI checks
gh pr checks [pr-number]
```

#### 5.2 Analyze Feedback

Review all comments and categorize:

**Categories:**
- 🚨 **Blocking issues:** Must fix before merge (bugs, security, breaking changes)
- ⚠️ **Important suggestions:** Should address (code quality, maintainability)
- 💡 **Nice-to-have suggestions:** Optional improvements (style preferences, optimizations)
- ❓ **Questions:** Need clarification or discussion

**Create Task Plan:**

Use TodoWrite to create tasks for each item requiring action:
```
1. Fix: [Blocking issue from review]
2. Address: [Important suggestion]
3. Respond: [Question needing clarification]
```

Prioritize blocking issues first.

#### 5.3 Address Feedback

For each review comment:

**Blocking Issues & Important Suggestions:**
1. Implement the requested change
2. Add/update tests if needed
3. Commit with reference to review:
   ```bash
   git commit -m "fix: address review feedback - [issue]
   
   Fixes issue raised in PR review comment [reference]
   [Explain what changed and why]"
   ```

**Questions:**
Reply to the comment using gh CLI:
```bash
gh pr comment [pr-number] --body "[Your response]"
```

**Nice-to-have Suggestions:**
Implement if they improve the code meaningfully, otherwise politely explain why you're not addressing:
```bash
gh pr comment [pr-number] --body "Thanks for the suggestion. Not addressing in this PR because [reason]. Happy to revisit in a follow-up if you feel strongly."
```

#### 5.4 Update PR

After addressing all feedback:

1. **Push changes:**
   ```bash
   git push origin feature/[name]
   ```

2. **Summarize what was addressed:**
   ```bash
   gh pr comment [pr-number] --body "## Review Feedback Addressed
   
   ✅ [Issue 1]: Fixed in [commit-hash]
   ✅ [Issue 2]: Addressed in [commit-hash]
   ❓ [Question]: Responded inline
   
   All feedback addressed. Re-running CI checks. Ready for re-review."
   ```

3. **Request re-review if needed:**
   ```bash
   gh pr ready [pr-number]  # If PR was marked as draft
   ```

4. **Notify user:**
   ```
   ✅ All review feedback addressed and pushed.
   PR updated: [PR URL]
   Ready for re-review.
   ```

## Output

- Complete implementation of all functional requirements from PRD
- All tests passing (unit, integration, E2E if applicable)
- Atomic commits following conventional commit format
- tasks.json updated: "pending" → "in_progress" → "done" with completion timestamp
- Pull request created with detailed description
- User validation and approval
- Review feedback addressed (if applicable)

## Success Criteria

### Implementation Complete When:
- [ ] All tasks in TodoWrite are marked completed
- [ ] All Functional Requirements (FR-1 through FR-N) implemented
- [ ] All user stories from PRD work as specified
- [ ] All tests pass
- [ ] Code follows project conventions
- [ ] No linting or type errors
- [ ] Documentation updated
- [ ] User has manually tested and approved
- [ ] tasks.json status updated to "done" with completion timestamp

### PR Complete When:
- [ ] Pull request created with descriptive title and body
- [ ] All deviations from PRD explained in PR description
- [ ] All review comments addressed (if applicable)
- [ ] CI/CD checks pass
- [ ] User notified of PR status
- [ ] tasks.json changes committed and pushed

## Key Philosophy

**"Start with the plan, adapt with feedback"**

The PRD provides architectural guidance based on analysis, but implementation feedback (tests, compiler, runtime) often reveals better approaches. Trust the feedback loop.

**Deviation is expected and encouraged** when feedback warrants it. The goal is a working, maintainable feature that satisfies requirements - not rigid adherence to a plan made without implementation context.

**Transparency without blocking:** Always communicate what you're doing and why, but keep moving forward. The user can course-correct if needed, but shouldn't have to approve every small decision.

## Examples

### Example: Following the Plan

```
Reading PRD... ✓
Recommended architecture: Middleware approach
Starting implementation...

✓ Created ProfileValidator middleware (src/middleware/profileValidator.js)
✓ Tests passing for FR-1, FR-4, FR-5
✓ Integrated with existing auth chain
✓ Implementation matches PRD architecture

All tests passing. Following PRD's recommended approach worked well.
```

### Example: Adapting Based on Feedback

```
Reading PRD... ✓
Recommended architecture: Middleware approach
Starting implementation...

✓ Created ProfileValidator middleware (src/middleware/profileValidator.js)
✗ Tests failing - body is undefined in middleware

Investigating... 
Root cause: bodyParser middleware runs after auth chain (src/app.js:45)

Deviating from PRD: Using hybrid approach instead of pure middleware.
- Keep ProfileValidator for reusable validation logic
- Call from route handler where body is available
- Rationale: Middleware execution order prevents planned approach

Continuing with hybrid implementation...

✓ Tests now passing for FR-1, FR-4, FR-5
✓ Hybrid approach working well

Implementation complete. Deviated from pure middleware approach due to 
middleware execution order constraints discovered during testing.
```

### Example: Communicating Deviation in Commit

```bash
git commit -m "feat(profile): add profile validation with hybrid approach

Implements FR-1, FR-4, FR-5 using route-handler validation instead
of pure middleware approach from PRD.

Deviation rationale: bodyParser middleware runs after auth chain
(src/app.js:45), making request body unavailable in middleware layer.
Hybrid approach keeps validation logic isolated in ProfileValidator
class but calls it from route handler where body is available.

Tests verify all functional requirements are met."
```
