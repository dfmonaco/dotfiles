---
description: Plan a feature by creating an implementation-ready PRD
---

# Feature Plan

## Objective
Create a clear, implementation-focused PRD that a junior developer can use to build the feature. The PRD serves as the source of truth for requirements, scope, and acceptance criteria.

## Role & Standards
Act as a Senior Product Manager writing for a **Junior Developer**.
- **Tone:** Explicit, unambiguous, and implementation-focused
- **Quality:** All Functional Requirements must be atomic, testable, and handle edge cases
- **Format:** Markdown

## Process

### 1. Discovery
Ask the user to briefly describe the feature they want to build.

### 2. Clarification
Once the user responds, analyze their request and:

1. **Restate** your understanding of the feature
2. **Ask clarifying questions** covering:
   - Context & Problem (Why is this needed?)
   - Target Users & Use Cases (Who will use this? When?)
   - Scope Boundaries (What's in scope? What's explicitly out?)
   - Constraints (Technical limitations, UX requirements, performance needs)

3. **Provide proposed answers** for every question based on best practices
   - Tell the user: *"You can reply 'Agree' to accept all proposed answers, or correct specific ones"*

### 3. Draft PRD
Once details are confirmed, generate the PRD with this structure:

#### Required Sections

**1. Feature Overview**
- Feature name
- Problem statement (why this matters)
- Solution summary (what we're building)

**2. Goals & Success Metrics**
- Primary goals (2-3 max)
- Measurable success criteria

**3. User Stories**
- Format: *"As a [role], I want to [action], so that [benefit]"*
- Include primary and edge-case scenarios

**4. Functional Requirements**
- Numbered format (FR-1, FR-2, etc.)
- Must be specific, testable, and complete
- Cover happy path, edge cases, and error states

**5. Non-Functional Requirements** (if applicable)
- Performance expectations
- Security considerations
- Platform/browser constraints

**6. UI/UX Guidelines** (if applicable)
- Key screens and user flows
- Interactive states (loading, error, empty, success)
- Accessibility requirements

**7. Technical Notes**
- Data models or schema changes
- API endpoints or integrations needed
- Dependencies or prerequisite work

**8. Open Questions**
- Items requiring decision or future clarification
- Known unknowns

### 4. Git Branch Setup
Before saving the PRD, create a feature branch for this work:

```bash
git checkout main  # or develop, depending on project
git pull origin main
git checkout -b feature/[feature-name]
```

**Branch naming:** Use kebab-case matching the feature name (e.g., `feature/user-profile-editing`)

**Important:** The branch name should match the PRD filename for seamless integration with the `/task-implement` command.

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
FOLDER_ID="${TODAY}-${COUNTER}-[feature-name]"
```

**Example:**
- Date: January 22, 2025
- Existing tasks today: 1 (20250122-001-user-auth)
- New folder ID: `20250122-002-user-profile-editing`

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
  "id": "20250122-002-user-profile-editing",
  "type": "feature",
  "status": "pending",
  "priority": null,
  "created": "2025-01-22T14:30:00Z",
  "branch": "feature/user-profile-editing",
  "description": "Add user profile editing functionality"
}
```

**Task Priority Assignment:**
Assign priority to each task based on best practice criteria without asking the user:
- **high:** Critical path items that block other work, breaking bugs, security issues, core functionality
- **medium:** Important features, non-blocking bugs, refactorings that improve maintainability
- **low:** Nice-to-have features, minor optimizations, documentation updates, code cleanup

Use your best judgment based on:
- Dependencies between tasks (blockers = high priority)
- Impact on functionality (core features = high, enhancements = medium/low)
- Urgency and severity (critical bugs = high, minor issues = low)
- Task type context (refactoring cleanup = low, refactoring core logic = medium/high)

**Notes:**
- Use ISO 8601 format for timestamps
- `status` starts as "pending" for new tasks

### 7. Review & Save
1. Review the PRD against the **Role & Standards**
2. Ensure all Functional Requirements are implementation-ready
3. Save the file:
   - **Path:** `./docs/tasks/[FOLDER_ID]/prd-[feature-name].md`
   - **Format:** `YYYYMMDD-NNN-[feature-name]/prd-[feature-name].md`
   - Create directory if needed

**Example:**
- Branch: `feature/user-profile-editing`
- Folder ID: `20250122-002-user-profile-editing`
- PRD Path: `./docs/tasks/20250122-002-user-profile-editing/prd-user-profile-editing.md`
- tasks.json entry created with priority (if specified)

### 8. Commit PRD and Metadata
Commit the PRD and updated tasks.json to the feature branch:

```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add PRD for [feature-name]

- Define feature requirements and scope
- Include user stories and acceptance criteria
- Document technical considerations
- Add task tracking entry"
```

## Output
- Feature branch created: `feature/[feature-name]`
- Task folder created with unique ID: `./docs/tasks/[FOLDER_ID]/`
- PRD document saved to `./docs/tasks/[FOLDER_ID]/prd-[feature-name].md`
- tasks.json updated with new task entry (status: pending, priority: user-specified or null)
- PRD and metadata committed to feature branch
- Ready for implementation via `/task-implement` command

## Success Criteria
- [ ] Feature branch created with consistent naming
- [ ] Unique task folder ID generated using YYYYMMDD-NNN format
- [ ] PRD contains all required sections
- [ ] All Functional Requirements are atomic and testable
- [ ] Edge cases and error states are documented
- [ ] PRD is saved to correct location with unique folder ID
- [ ] tasks.json created (if needed) and updated with new task entry
- [ ] Task entry includes: id, type, status, priority, created timestamp, branch, description
- [ ] PRD and tasks.json committed to the feature branch
- [ ] Branch name matches task name (not folder ID prefix)
- [ ] User has confirmed the PRD is complete and accurate
