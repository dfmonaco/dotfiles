---
description: Plan a feature through collaborative architecture design and create an implementation-ready PRD
---

# Feature Planning

## Objective
Create a comprehensive PRD through collaborative architecture design. The agent explores the codebase, proposes context-aware architecture options, and works with you to make informed decisions. The result is an implementation-ready document with clear requirements and architectural guidance.

## Role & Standards
Act as a **Senior Technical Architect and Product Manager**.
- **Tone:** Collaborative, contextual, and explicit
- **Quality:** All Functional Requirements must be atomic, testable, and numbered for tracking
- **Approach:** Always provide recommendations based on codebase context and best practices
- **Format:** Markdown PRD with consistent structure

## Core Principle: Agent-Led Recommendations

**CRITICAL:** You must NEVER ask questions without providing your recommended answer based on:
- Current codebase patterns and architecture
- Best practices and industry standards  
- Context from exploration
- Educated reasoning

**Format for all questions:**
```
Question: [The question]
- My recommendation: [Your answer]
- Why: [Reasoning based on context]
- Context: [What you found in codebase or best practice]
- Trade-offs: [Pros and cons]
- Do you agree, or prefer a different approach?
```

User can respond with:
- "Agree" to accept all recommendations
- "Agree except [number]" to discuss specific items
- Detailed feedback on any question

## Process

### Phase 1: Initial Understanding & Light Exploration

#### 1.1 Feature Description
Ask the user to briefly describe the feature they want to build.

#### 1.2 Light Codebase Exploration
Before asking detailed questions, do a quick scan to understand the project context:

**Explore:**
- Project structure and technology stack
- Existing similar features or components
- State management approach
- API/routing patterns
- Testing setup

**Purpose:** Inform your questions and recommendations with actual codebase context.

### Phase 2: Requirements Gathering

#### 2.1 Restate Understanding
Summarize what you understood from the feature description.

#### 2.2 Clarifying Questions with Recommended Answers
Ask questions covering these areas, **always with your recommended answer**:

**Context & Problem**
- Why is this feature needed? What problem does it solve?
- Who are the target users?
- What's the expected impact?

**Scope & Boundaries**
- What's explicitly in scope for this iteration?
- What's explicitly out of scope?
- Are there existing features this integrates with?

**User Experience**
- What are the key user flows?
- What interactive states are needed (loading, error, empty, success)?
- Any accessibility requirements?

**Technical Constraints**
- Performance requirements or constraints?
- Browser/platform requirements?
- Security considerations?
- Data persistence needs?

**Example Format:**
```markdown
### Questions & Recommended Answers

#### 1. Validation approach: Client-side, server-side, or both?
- **My recommendation:** Both client and server-side validation
- **Why:** Client-side for immediate UX feedback, server-side for security
- **Context:** Your existing forms use this pattern (src/forms/LoginForm.js)
- **Best practice:** Never trust client-side validation alone for security
- **Trade-offs:** More code to maintain vs better UX and security
- **Do you agree?**

#### 2. State management: Extend Redux store or use Context API?
- **My recommendation:** Extend existing Redux store
- **Why:** Consistency with existing user state management
- **Context:** Your app uses Redux for user state (src/store/user/)
- **Trade-offs:** Context API would be lighter but introduces inconsistency
- **Do you agree?**

[User can respond: "Agree" or provide specific feedback]
```

### Phase 3: Deep Codebase Exploration

Once requirements are clear, perform thorough exploration:

**Analyze in detail:**
- Relevant existing patterns and their implementation
- Integration points and extension mechanisms
- Data models and schemas
- API endpoints and contracts
- Similar components and their approaches
- Test patterns and coverage
- Error handling patterns
- Configuration and environment setup

**Document findings** to inform architecture proposals.

### Phase 4: Architecture Discussion

#### 4.1 Propose Architecture Options
Based on deep exploration, propose 2-3 architecture options with detailed context.

**For each option, provide:**
- Approach name and high-level description
- How it fits with existing architecture
- **Specific files and integration points** (e.g., "Modify src/middleware/auth.js line 45")
- **Concrete implementation structure** (new files, modified files, patterns to use)
- Pros and cons with context from codebase
- Alignment with best practices
- Effort estimate and complexity

**Rank options** from most recommended to least recommended with clear reasoning.

#### 4.2 Discuss Each Option One-by-One
Walk through each architecture option with the user:
- Explain the approach in detail
- Show how it fits the existing codebase
- Discuss trade-offs
- Get feedback

#### 4.3 Finalize Architecture Choice
Based on discussion, confirm which architecture approach(es) to include in the PRD.

If multiple viable options emerge, rank them in order of preference with guidance on when to choose each.

### Phase 5: Generate PRD

Create the PRD with this **exact structure**. All sections must always be present.

#### Required Sections

**1. Feature Overview**
- Feature name
- Problem statement (why this matters)
- Solution summary (what we're building)
- Target users

**2. Goals & Success Metrics**
- Primary goals (2-3 max)
- Measurable success criteria
- Expected impact

**3. User Stories**
- Format: *"As a [role], I want to [action], so that [benefit]"*
- Include primary flow and edge-case scenarios
- Cover different user types if applicable

**4. Functional Requirements**
**MUST use rigid numbering format: FR-1, FR-2, FR-3, etc.**

Each requirement must be:
- Specific and unambiguous
- Testable and verifiable
- Atomic (one clear requirement per number)
- Complete (covers happy path, edge cases, error states)

Example:
```markdown
## Functional Requirements

**FR-1:** User can edit profile name by clicking the name field, entering text, and pressing Enter or clicking outside the field

**FR-2:** Changes to profile name save automatically on blur (clicking outside) or Enter key press

**FR-3:** Display loading indicator in the name field while save is in progress

**FR-4:** Validate name is not empty and is maximum 100 characters before saving

**FR-5:** Show inline error message if validation fails, preventing save

**FR-6:** Display success toast notification when save completes successfully

**FR-7:** Display error toast notification if save fails due to network or server error

**FR-8:** Provide "Retry" button in error toast to retry failed save
```

**5. Non-Functional Requirements**
If applicable, include:
- Performance expectations (e.g., "Save operation completes within 2 seconds")
- Security considerations (e.g., "Profile data encrypted at rest")
- Platform/browser constraints (e.g., "Support Chrome 90+, Firefox 88+, Safari 14+")
- Accessibility requirements (e.g., "WCAG 2.1 AA compliance")

**If none applicable:** State "Not applicable - no specific non-functional requirements for this feature"

**6. UI/UX Guidelines**
If applicable, include:
- Key screens and layouts
- User flows and navigation
- Interactive states (loading, error, empty, success)
- Visual design notes
- Responsive behavior
- Accessibility considerations

**If none applicable:** State "Not applicable - backend-only feature" or similar

**7. Architectural Approach**

This section documents the architecture decision and provides implementation guidance.

**7.1 Codebase Analysis**
Document what you discovered during exploration:

```markdown
### Codebase Analysis

**[Relevant System Name]** (e.g., Authentication System, State Management, etc.)
- Current implementation: [Description]
- Location: [File paths]
- Pattern used: [Pattern name and description]
- Extension points: [Where/how to integrate]

**[Another Relevant System]**
- Current implementation: [Description]
- Location: [File paths]
- Pattern used: [Pattern name]
- Integration approach: [How it works]

**[Relevant Pattern]** (e.g., Validation, Error Handling)
- Current pattern: [Description with examples]
- Files: [Specific examples from codebase]
- Standard: [The established approach]
```

**Example:**
```markdown
### Codebase Analysis

**Authentication System**
- Uses Passport.js middleware chain (src/middleware/auth/)
- Current flow: request → authenticate (auth.js:23) → authorize (auth.js:45) → route handler
- Extension point: After auth.js line 45, before route handlers are called

**State Management**
- Redux store for user state (src/store/user/)
- Async actions use redux-thunk pattern
- Pattern: action creator → thunk → API call → dispatch → reducer
- User updates follow: updateUserRequest → updateUserSuccess/Failure pattern

**Validation Patterns**
- Server-side: express-validator middleware (src/middleware/validators/)
- Client-side: Formik + Yup schemas (src/validation/schemas/)
- Standard: Both layers validate, server is source of truth for data integrity
```

**7.2 Architecture Options**

List all options discussed, ranked from most to least recommended.

For each option:

```markdown
#### Option [N]: [Approach Name] ([RECOMMENDED/ALTERNATIVE/FALLBACK])

**Overview**
[1-2 sentence description of the approach]

**How It Fits Existing Architecture**
[Explain how this integrates with current patterns from Codebase Analysis]

**Implementation Structure**
- **New files:**
  - `path/to/new/file.js` - [Purpose]
  - `path/to/another/file.js` - [Purpose]
- **Modified files:**
  - `path/to/existing/file.js` (line ~XX) - [What changes]
  - `path/to/another/existing.js` - [What changes]
- **Patterns to use:**
  - [Pattern name from codebase] for [purpose]
  - [Another pattern] for [purpose]

**Pros**
- [Pro 1 with context]
- [Pro 2 with context]

**Cons**
- [Con 1 with context]
- [Con 2 with context]

**Effort Estimate**
[Small/Medium/Large] - [Brief reasoning]

**When to Use This Option**
[Scenarios where this is the right choice]
```

**Example:**
```markdown
#### Option 1: Middleware Approach (RECOMMENDED)

**Overview**
Add new middleware to the existing Passport.js authentication chain for profile validation.

**How It Fits Existing Architecture**
Extends the current middleware pattern (src/middleware/auth/) by inserting validation after authentication but before route handlers, following the established request pipeline pattern.

**Implementation Structure**
- **New files:**
  - `src/middleware/profileValidator.js` - Validation middleware following express-validator pattern
  - `src/validation/schemas/profileSchema.js` - Yup schema for client-side validation
  - `src/middleware/__tests__/profileValidator.test.js` - Unit tests
- **Modified files:**
  - `src/routes/profile.js` (line 15) - Add profileValidator middleware to PUT /profile route
  - `src/middleware/index.js` - Export new middleware
- **Patterns to use:**
  - express-validator pattern (matches existing validators/)
  - Async middleware error handling (matches auth.js pattern)
  - Redux thunk pattern for client state updates (matches user store)

**Pros**
- Isolated and testable
- Follows existing middleware chain pattern
- Easy to enable/disable or reuse for other routes
- Consistent with current architecture philosophy

**Cons**
- Adds one more layer of abstraction
- Slight performance overhead (negligible in practice)

**Effort Estimate**
Medium - 3-4 files to create, 2 files to modify, tests to write

**When to Use This Option**
Default choice - use unless middleware hooks prove insufficient during implementation
```

**7.3 Key Design Decisions for Implementation**

List important decisions that implementation will need to make, with your recommendations:

```markdown
### Key Design Decisions

**[Decision Area]**
- **Recommendation:** [Your recommended approach]
- **Why:** [Reasoning from context and best practices]
- **Alternative:** [Another valid approach and when to use it]
- **Implementation note:** [Specific guidance]

**[Another Decision Area]**
- **Recommendation:** [Your recommended approach]
- **Why:** [Reasoning]
- **Flexibility:** [Where implementation can adapt based on feedback]
```

**Example:**
```markdown
### Key Design Decisions

**1. Validation Timing**
- **Recommendation:** Validate on blur and on submit
- **Why:** Blur gives immediate feedback, submit prevents navigation with errors
- **Alternative:** Validate on every keystroke - use only for critical fields (like username availability)
- **Implementation note:** Follow pattern in src/forms/LoginForm.js lines 45-67

**2. Error Message Display**
- **Recommendation:** Inline errors for field-specific issues, toast for network/server errors
- **Why:** Inline keeps context visible, toast for system-level issues
- **Alternative:** Modal for all errors - only if errors need detailed explanation
- **Flexibility:** Can adjust based on actual error scenarios encountered during testing

**3. Optimistic Updates**
- **Recommendation:** Show change immediately, rollback on error
- **Why:** Better perceived performance, users expect instant feedback for profile edits
- **Alternative:** Wait for server confirmation - use if data consistency is critical
- **Implementation note:** Redux store should keep previous value for rollback
```

**8. Technical Notes**

If applicable, document:
- Data model changes or new schemas
- API endpoints (new or modified)
- Database migrations needed
- Third-party integrations or dependencies
- Environment variables or configuration
- Deployment considerations

**If none:** State "Not applicable - no additional technical notes"

**9. Open Questions**

Document any items requiring future decision or clarification:
- Known unknowns
- Dependencies on other teams or systems
- Items deferred to later iterations
- Assumptions that need validation

**If none:** State "No open questions - ready for implementation"

### Phase 6: Git Branch Setup

Before saving the PRD, set up the feature branch:

```bash
git checkout main  # or develop, depending on project
git pull origin main
git checkout -b feature/[feature-name]
```

**Branch naming:** Use kebab-case matching the feature name (e.g., `feature/user-profile-editing`)

**Important:** The branch name should match the PRD filename for seamless integration with `/feature-implement`.

### Phase 7: Generate Task Folder ID

Generate a unique folder ID using the date-counter convention:

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

### Phase 8: Update tasks.json

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
  "priority": "medium",
  "created": "2025-01-22T14:30:00Z",
  "branch": "feature/user-profile-editing",
  "description": "Add user profile editing functionality"
}
```

**Task Priority Assignment:**

Assign priority based on these criteria:
- **high:** Critical path items blocking other work, breaking bugs, security issues, core functionality
- **medium:** Important features, non-blocking bugs, refactorings improving maintainability
- **low:** Nice-to-have features, minor optimizations, documentation updates, code cleanup

Consider:
- Dependencies (blockers = high priority)
- Impact on functionality (core features = high, enhancements = medium/low)
- Urgency and severity (critical bugs = high, minor issues = low)

**Notes:**
- Use ISO 8601 format for timestamps
- `status` starts as "pending" for new tasks
- Assign priority automatically based on best judgment

### Phase 9: Review & Save

1. Review the PRD against the **Role & Standards**
2. Ensure all sections are present (N/A if not applicable)
3. Verify all Functional Requirements are numbered and testable
4. Confirm architecture decisions are clear and actionable
5. Save the file:
   - **Path:** `./docs/tasks/[FOLDER_ID]/prd-[feature-name].md`
   - **Format:** `YYYYMMDD-NNN-[feature-name]/prd-[feature-name].md`
   - Create directory if needed

**Example:**
- Branch: `feature/user-profile-editing`
- Folder ID: `20250122-002-user-profile-editing`
- PRD Path: `./docs/tasks/20250122-002-user-profile-editing/prd-user-profile-editing.md`

### Phase 10: Commit PRD and Metadata

Commit the PRD and updated tasks.json to the feature branch:

```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add PRD for [feature-name]

Define feature requirements and architectural approach through
collaborative design. Includes codebase analysis, architecture
options discussion, and implementation-ready guidance.

- [N] functional requirements
- [N] architecture options analyzed
- [Recommended approach] selected"
```

## Output

- Feature branch created: `feature/[feature-name]`
- Task folder created with unique ID: `./docs/tasks/[FOLDER_ID]/`
- PRD document saved to `./docs/tasks/[FOLDER_ID]/prd-[feature-name].md`
- tasks.json updated with new task entry (status: pending, priority assigned)
- PRD and metadata committed to feature branch
- Ready for implementation via `/feature-implement` command

## Success Criteria

- [ ] Feature branch created with consistent naming
- [ ] Unique task folder ID generated using YYYYMMDD-NNN format
- [ ] Light exploration completed before requirements gathering
- [ ] Deep exploration completed before architecture proposals
- [ ] All questions asked with agent's recommended answers
- [ ] 2-3 architecture options proposed with detailed context
- [ ] Each option discussed one-by-one with user
- [ ] PRD contains all required sections (N/A if not applicable)
- [ ] All Functional Requirements use FR-N numbering format
- [ ] All Functional Requirements are atomic and testable
- [ ] Codebase Analysis documents relevant patterns and integration points
- [ ] Architecture Options include specific files, patterns, and implementation structure
- [ ] Key Design Decisions provide implementation guidance
- [ ] Edge cases and error states documented in requirements
- [ ] PRD saved to correct location with unique folder ID
- [ ] tasks.json created (if needed) and updated with new task entry
- [ ] Task entry includes: id, type, status, priority, created timestamp, branch, description
- [ ] PRD and tasks.json committed to the feature branch
- [ ] Branch name matches task name (not folder ID prefix)
- [ ] User has confirmed the PRD is complete and accurate

## Example: Question Format

❌ **WRONG - No recommendation:**
```
Should we use approach A or approach B?
```

✅ **CORRECT - With recommendation:**
```
**Question:** Should we use approach A (middleware) or approach B (direct modification)?

- **My recommendation:** Approach A (middleware)
- **Why:** Your codebase already uses middleware pattern extensively (src/middleware/)
- **Context:** Passport.js auth uses middleware chain, this extends that pattern naturally
- **Trade-offs:** 
  - Pro: Isolated, testable, follows existing pattern
  - Con: One more abstraction layer
- **Alternative:** Approach B works if middleware proves insufficient during implementation
- **Do you agree with approach A?**
```
