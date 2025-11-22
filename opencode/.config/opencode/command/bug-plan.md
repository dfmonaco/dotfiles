---
description: Plan a bug fix by creating an implementation-ready bug analysis document
---

# Bug Plan

## Objective
Create a clear, implementation-focused bug analysis document that a junior developer can use to fix the bug. The document serves as the source of truth for the problem, root cause, solution approach, and acceptance criteria.

## Role & Standards
Act as a Senior Software Engineer writing for a **Junior Developer**.
- **Tone:** Explicit, unambiguous, and implementation-focused
- **Quality:** Root cause must be identified, reproduction steps must be clear, fix must prevent regression
- **Format:** Markdown

## Process

### 1. Discovery
Ask the user to describe the bug they want to fix. Prompt them to provide:
- What is the expected behavior?
- What is the actual behavior?
- How can it be reproduced?
- Is there an associated GitHub issue or ticket?

### 2. Clarification
Once the user responds, analyze their request and:

1. **Restate** your understanding of the bug
2. **Ask clarifying questions** covering:
   - Reproduction Steps (Can you consistently reproduce it? What are the exact steps?)
   - Affected Scope (Which users/features/environments are impacted?)
   - Severity & Priority (Is this blocking users? How urgent?)
   - Root Cause Hypothesis (What might be causing this?)
   - Context (When did this start? Recent changes? Related code areas?)
   - Error Messages (Any logs, stack traces, error codes?)

3. **Provide proposed answers** for every question based on best practices and code analysis
   - Tell the user: *"You can reply 'Agree' to accept all proposed answers, or correct specific ones"*

### 3. Draft Bug Analysis Document
Once details are confirmed, generate the bug analysis with this structure:

#### Required Sections

**1. Bug Overview**
- Bug title/name
- Severity level (Critical/High/Medium/Low)
- Affected users/features
- Date discovered

**2. Problem Statement**
- Clear description of what's broken
- Expected vs actual behavior
- User impact (how does this affect users?)

**3. Reproduction Steps**
Step-by-step instructions to reproduce:
```
1. [Action 1]
2. [Action 2]
3. [Expected result]
4. [Actual result]
```

**4. Root Cause Analysis**
- Hypothesis of what's causing the bug
- Relevant code locations (files and line numbers)
- Why the bug occurs (technical explanation)
- When/how it was introduced (if known)

**5. Proposed Solution**
- High-level approach to fix
- Which files need modification
- Alternative approaches considered (and why rejected)
- Potential risks or side effects

**6. Fix Requirements**
- Numbered format (FR-1, FR-2, etc.)
- Must be specific, testable, and complete
- Cover the fix itself, edge cases, and regression prevention

Example:
```
FR-1: Fix [specific issue] in [file/component]
FR-2: Add validation to prevent [error condition]
FR-3: Add regression test to ensure bug doesn't reoccur
FR-4: Update error handling for [scenario]
```

**7. Testing Strategy**
- Unit tests to add/modify
- Integration tests needed
- Manual testing checklist
- Regression testing requirements
- Edge cases to verify

**8. Acceptance Criteria**
What must be true for the bug to be considered fixed:
- [ ] Original reproduction steps no longer produce the error
- [ ] All existing tests still pass
- [ ] New regression tests added and passing
- [ ] Edge cases handled
- [ ] No new bugs introduced

**9. Technical Notes**
- Dependencies affected
- Database/schema changes (if any)
- API changes (if any)
- Performance considerations
- Security implications

**10. Related Information**
- GitHub issue number (if applicable)
- Related bugs or PRs
- Relevant documentation
- Stack traces or error logs

### 4. Git Branch Setup
Before saving the document, create a fix branch for this work:

```bash
git checkout main  # or develop, depending on project
git pull origin main
git checkout -b fix/[bug-name]
```

**Branch naming:** Use kebab-case describing the bug (e.g., `fix/user-authentication-timeout`)

**Important:** The branch name should match the bug document filename for seamless integration with the `/task-implement` command.

### 5. Generate Task Folder ID
Before saving, generate a unique folder ID using the date-counter convention:

```bash
# Get today's date in YYYYMMDD format
TODAY=$(date +%Y%m%d)

# Find existing tasks with today's date
EXISTING=$(find ./docs/tasks -maxdepth 1 -type d -name "${TODAY}-*" 2>/dev/null | wc -l)

# Calculate next counter (pad to 3 digits)
COUNTER=$(printf "%03d" $((EXISTING + 1)))

# Generate folder ID
FOLDER_ID="${TODAY}-${COUNTER}-[bug-name]"
```

**Example:**
- Date: January 22, 2025
- Existing tasks today: 2
- New folder ID: `20250122-003-user-auth-timeout`

### 6. Update tasks.json
Create or update `./docs/tasks/tasks.json` to track this task:

**If tasks.json doesn't exist, create it:**
```json
{
  "tasks": []
}
```

**Add new task entry:**
```json
{
  "id": "20250122-003-user-auth-timeout",
  "type": "bug",
  "status": "pending",
  "priority": null,
  "created": "2025-01-22T15:45:00Z",
  "branch": "fix/user-auth-timeout",
  "description": "Fix user authentication timeout issue"
}
```

**Priority Assignment:**
- Ask user: "What priority should this bug fix have? (1=highest, 2, 3, etc., or leave empty for no priority)"
- If user provides a number, set `priority` to that value
- If user leaves empty, set `priority` to `null`
- Consider severity when suggesting priority (Critical/High bugs typically get priority 1)

**Notes:**
- Use ISO 8601 format for timestamps
- `status` starts as "pending" for new tasks
- `priority` is optional (null) - used to order pending tasks

### 7. Review & Save
1. Review the document against the **Role & Standards**
2. Ensure root cause is identified (or best hypothesis documented)
3. Ensure fix requirements are implementation-ready
4. Save the file:
   - **Path:** `./docs/tasks/[FOLDER_ID]/bug-[bug-name].md`
   - **Format:** `YYYYMMDD-NNN-[bug-name]/bug-[bug-name].md`
   - Create directory if needed

**Example:**
- Branch: `fix/user-auth-timeout`
- Folder ID: `20250122-003-user-auth-timeout`
- Document Path: `./docs/tasks/20250122-003-user-auth-timeout/bug-user-auth-timeout.md`
- tasks.json entry created with priority (if specified)

### 8. Commit Document and Metadata
Commit the bug analysis and updated tasks.json to the fix branch:

```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add bug analysis for [bug-name]

- Document reproduction steps and root cause
- Define fix requirements and testing strategy
- Outline acceptance criteria
- Add task tracking entry"
```

## Output
- Fix branch created: `fix/[bug-name]`
- Task folder created with unique ID: `./docs/tasks/[FOLDER_ID]/`
- Bug analysis document saved to `./docs/tasks/[FOLDER_ID]/bug-[bug-name].md`
- tasks.json updated with new task entry (status: pending, priority: user-specified or null)
- Document and metadata committed to fix branch
- Ready for implementation via `/task-implement` command

## Success Criteria
- [ ] Fix branch created with consistent naming
- [ ] Unique task folder ID generated using YYYYMMDD-NNN format
- [ ] Bug analysis contains all required sections
- [ ] Reproduction steps are clear and actionable
- [ ] Root cause is identified or best hypothesis documented
- [ ] Fix requirements are atomic and testable
- [ ] Testing strategy includes regression tests
- [ ] Acceptance criteria are measurable
- [ ] Document is saved to correct location with unique folder ID
- [ ] tasks.json created (if needed) and updated with new task entry
- [ ] Task entry includes: id, type, status, priority, created timestamp, branch, description
- [ ] Document and tasks.json committed to the fix branch
- [ ] Branch name matches task name (not folder ID prefix)
- [ ] User has confirmed the analysis is complete and accurate

## Notes

### Tips for Root Cause Analysis
- Read the relevant code files thoroughly
- Check recent commits in the affected areas (`git log --oneline [file]`)
- Look for related issues in issue tracker
- Check error logs and stack traces carefully
- Consider timing (race conditions, async issues)
- Consider state (data corruption, cache staleness)
- Consider environment (works locally but not in production?)

### Common Bug Categories
- **Logic errors:** Incorrect conditionals, off-by-one errors
- **State management:** Race conditions, stale data, incorrect updates
- **Error handling:** Unhandled exceptions, incorrect error responses
- **Data validation:** Missing validation, incorrect validation logic
- **Integration issues:** API mismatches, dependency version conflicts
- **Performance bugs:** Memory leaks, inefficient queries, N+1 problems
- **UI bugs:** Rendering issues, event handling problems, state sync issues

### Severity Guidelines
- **Critical:** System down, data loss, security vulnerability
- **High:** Major feature broken, significant user impact, no workaround
- **Medium:** Feature partially broken, moderate impact, workaround exists
- **Low:** Minor issue, cosmetic problem, minimal impact
