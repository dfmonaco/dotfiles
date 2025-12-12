---
description: Discover the best solution to a problem through collaborative exploration, codebase analysis, and architectural discussion
---

# Problem Discovery & Solution Design

## Objective

Collaboratively discover the best solution to a problem by:
1. **Understanding the problem** - What are we trying to solve and why?
2. **Exploring solutions** - Your ideas + agent's ideas based on codebase analysis
3. **Evaluating alternatives** - Discuss options, pros/cons, architecture fit, and best practices
4. **Designing the solution** - Architecture planning with implementation-ready guidance
5. **Documenting decisions** - Create comprehensive PRD capturing the journey

This is a discovery process. Start with a problem and initial ideas, then work together to find the optimal solution for your specific codebase and context.

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

**When user presents solution ideas:**
- Acknowledge and analyze each idea thoroughly
- Explain how it fits (or conflicts with) existing codebase patterns
- Add complementary ideas or variations based on codebase context
- Identify potential issues and suggest constructive alternatives
- If an idea has problems, say so directly with reasoning (don't blindly agree)
- Build on good ideas with implementation details

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

## Process Overview

### **Phase 1: Problem Discovery & Solution Exploration** 
**Goal: Decide WHAT to build**
- Understand the problem and motivation
- Light codebase exploration for context
- Discuss user's ideas + agent's ideas
- Evaluate solution alternatives
- **DECISION POINT:** Agree on solution approach before proceeding

### **Phase 2: Architecture Design & Planning**
**Goal: Decide HOW to build it**
- Deep codebase exploration
- Propose architecture options (2-3)
- Discuss implementation approaches and tradeoffs
- **DECISION POINT:** Agree on architecture before PRD generation

### **Phase 3: PRD Generation & Setup**
**Goal: Document and prepare for implementation**
- Generate comprehensive PRD documenting the journey
- Create feature branch and task structure
- Commit documentation to feature branch

---

## Phase 1: Problem Discovery & Solution Exploration

**Objective:** Understand the problem deeply and discover the best solution approach through collaborative exploration.

### Step 1.1: Problem Understanding

Ask the user to describe:
1. **The problem they're trying to solve** - What's not working or what's needed?
2. **Why it matters** - Who's affected? What's the impact?
3. **Their initial ideas** - What solutions are they considering?

### Step 1.2: Light Codebase Exploration

Before diving into solution discussion, do a quick scan to understand project context:

**Explore:**
- Project structure and technology stack
- Similar existing features or components
- Relevant patterns (state management, API patterns, validation, error handling)
- Integration points where solution might connect

**Purpose:** Inform your analysis of user's ideas and generate context-aware recommendations.

*Note: Save deep analysis (specific files, data models, test coverage) for Phase 2.*

### Step 1.3: Restate Understanding

Summarize back to the user:
- The problem as you understand it
- Why it's important (impact, users affected)
- Their proposed solution ideas
- Relevant context you found in the codebase

**Wait for confirmation** before proceeding.

### Step 1.4: Solution Exploration & Discussion

Now explore solution options together. For each of the user's ideas AND your own ideas:

**Analyze each solution option:**
- How it solves the stated problem
- How it fits (or conflicts with) existing codebase patterns
- Pros and cons in this specific context
- Complexity and effort estimate
- Edge cases and potential issues

**Present as structured options:**

```markdown
### Solution Options

#### Option 1: [User's Idea Name]
**Your proposed approach:** [Describe their idea]

**My analysis:**
- **How it solves the problem:** [Direct connection to problem statement]
- **Fit with codebase:** [How it aligns or conflicts with existing patterns]
- **Pros:**
  - [Pro 1 with context]
  - [Pro 2 with context]
- **Cons:**
  - [Con 1 with context]
  - [Con 2 with context]
- **Effort estimate:** [Small/Medium/Large with reasoning]
- **Potential issues:** [Edge cases, technical challenges]

**My recommendation:** [Should we pursue this? Modifications needed?]

#### Option 2: [Agent's Alternative Idea]
**Proposed approach:** [Describe your idea]

**Why I suggest this:**
- **How it solves the problem:** [Direct connection]
- **Codebase context:** [What patterns this leverages]
- **Pros:**
  - [Pro 1 with context]
  - [Pro 2 with context]
- **Cons:**
  - [Con 1 with context]
  - [Con 2 with context]
- **Effort estimate:** [Small/Medium/Large with reasoning]

#### Option 3: [Hybrid or Another Alternative]
[Same structure]

---

**My overall recommendation:** [Which option and why]
- **Best fit because:** [Reasoning from problem, codebase, best practices]
- **Trade-offs accepted:** [What we're trading for this choice]
- **Alternative choice:** [When to consider other options]

**What do you think? Should we go with this approach, or discuss further?**
```

### Step 1.5: Refine and Decide

Based on discussion, refine the chosen solution:
- Address concerns raised
- Clarify scope boundaries (what's in, what's out)
- Define success criteria
- Identify key user flows
- Document assumptions

**DECISION CHECKPOINT:** Get explicit agreement:
```
Agreed solution approach: [Name/description]
Key aspects:
- [Aspect 1]
- [Aspect 2]
- [Aspect 3]

Ready to proceed to architecture design? (yes/no)
```

**Only proceed to Phase 2 after explicit agreement.**

---

## Phase 2: Architecture Design & Planning

**Objective:** Design the technical architecture for implementing the agreed solution.

### Step 2.1: Deep Codebase Exploration

Now that we know WHAT to build, thoroughly explore HOW to build it:

**Analyze in detail:**
- Relevant existing patterns and their implementation
- Integration points and extension mechanisms
- Data models and schemas that need changes or additions
- API endpoints and contracts
- Similar components and their implementation approaches
- Test patterns and coverage expectations
- Error handling patterns
- Security considerations

**Document findings** - these will inform architecture proposals.

*Note: Configuration, environment, and deployment considerations are documented in PRD Technical Notes if relevant.*

### Step 2.2: Propose Architecture Options

Based on deep exploration, propose 2-3 architecture options with detailed context (or fewer if there's clearly one optimal approach with minor variations).

**For each option, provide:**
- Approach name and high-level description
- How it fits with existing architecture (patterns, structure, philosophy)
- **Specific files and integration points** (e.g., "Modify src/middleware/auth.js line 45")
- **Concrete implementation structure** (new files, modified files, patterns to use)
- Pros and cons with context from codebase
- Alignment with best practices
- Effort estimate and complexity
- When to choose this option

**Rank options** from most recommended to least recommended with clear reasoning.

**Example format:**
```markdown
### Architecture Options

#### Option 1: [Approach Name] (RECOMMENDED)

**Overview**
[1-2 sentence description]

**How It Fits Existing Architecture**
[Explain integration with current patterns from codebase analysis]

**Implementation Structure**
- **New files:**
  - `path/to/new/file.js` - [Purpose and what it contains]
  - `path/to/another/file.js` - [Purpose and what it contains]
- **Modified files:**
  - `path/to/existing/file.js` (line ~XX) - [What changes and why]
  - `path/to/another/existing.js` - [What changes and why]
- **Patterns to use:**
  - [Pattern name from codebase] for [purpose]
  - [Another pattern] for [purpose]

**Pros**
- [Pro 1 with context from codebase]
- [Pro 2 with context]

**Cons**
- [Con 1 with context]
- [Con 2 with context]

**Effort Estimate**
[Small/Medium/Large] - [Brief reasoning based on files and complexity]

**When to Use This Option**
[Scenarios where this is the right choice]

---

#### Option 2: [Alternative Approach] (ALTERNATIVE)
[Same structure]

#### Option 3: [Another Approach] (FALLBACK)
[Same structure]

---

**My recommendation:** Option [N] - [Name]
**Why:** [Reasoning considering problem, codebase fit, effort, and best practices]
**When to reconsider:** [Scenarios where alternative might be better]

**What do you think? Should we proceed with this architecture?**
```

### Step 2.3: Discuss Architecture

Walk through each option with the user:

**For each architecture option:**
- Explain the approach in detail
- Show specific integration points and how they work
- Walk through the implementation structure (files, patterns)
- Discuss tradeoffs in context of the problem
- Answer questions and address concerns

**Collaborative refinement:**
- Adjust based on user feedback
- Identify which aspects are flexible vs. fixed
- Confirm understanding of implementation complexity

### Step 2.4: Finalize Architecture

Based on discussion, confirm the architecture approach:

**Document key design decisions:**
```markdown
### Key Design Decisions

**[Decision Area 1]** (e.g., Validation Timing)
- **Decision:** [What we decided]
- **Why:** [Reasoning from context and requirements]
- **Alternative considered:** [Other option and why not chosen]
- **Implementation note:** [Specific guidance for implementation]

**[Decision Area 2]** (e.g., Error Handling Strategy)
- **Decision:** [What we decided]
- **Why:** [Reasoning]
- **Flexibility:** [Where implementation can adapt based on feedback]

[Continue for other key decisions]
```

**DECISION CHECKPOINT:** Get explicit agreement:
```
Agreed architecture: [Approach name]
Key decisions:
- [Decision 1]
- [Decision 2]
- [Decision 3]

Ready to generate PRD? (yes/no)
```

**Only proceed to Phase 3 after explicit agreement.**

---

## Phase 3: PRD Generation & Setup

**Objective:** Document the entire journey and prepare for implementation.

### Step 3.1: Generate PRD

Create a comprehensive PRD with this **exact structure**. All sections must always be present.

#### PRD Structure

**1. Feature Overview**
- Feature name (derived from agreed solution)
- Problem statement (the problem we explored in Phase 1)
- Solution summary (the approach we agreed on)
- Target users (who benefits)

**2. Goals & Success Metrics**
- Primary goals (2-3 max, from Phase 1 discussion)
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

**7. Solution Discovery Journey**

Document how we arrived at this solution:

```markdown
### Problem Explored
[The original problem statement from Phase 1]

### Solution Options Considered

#### Option 1: [Name] (CHOSEN)
- **Approach:** [Brief description]
- **Why chosen:** [Key reasons from Phase 1 discussion]
- **Trade-offs accepted:** [What we're giving up for this choice]

#### Option 2: [Name] (Not chosen)
- **Approach:** [Brief description]
- **Why not chosen:** [Key reasons]

[Additional options if explored]

### Key Decisions Made
- [Decision 1 and reasoning]
- [Decision 2 and reasoning]
```

**8. Architectural Approach**

This section documents the architecture decision from Phase 2.

**8.1 Codebase Analysis**
Document what you discovered during deep exploration:

```markdown
### Codebase Analysis

**[Relevant System Name]** (e.g., Authentication System, State Management)
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

**8.2 Architecture Options**

List all options discussed in Phase 2, ranked from most to least recommended.

For each option, use the same detailed structure from Step 2.2:
- Overview
- How it fits existing architecture
- Implementation structure (new files, modified files, patterns)
- Pros and cons
- Effort estimate
- When to use this option

**8.3 Key Design Decisions for Implementation**

List important decisions that guide implementation:

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

**9. Technical Notes**

If applicable, document:
- Data model changes or new schemas
- API endpoints (new or modified)
- Database migrations needed
- Third-party integrations or dependencies
- Environment variables or configuration
- Deployment considerations

**If none:** State "Not applicable - no additional technical notes"

**10. Open Questions**

Document any items requiring future decision or clarification:
- Known unknowns discovered during exploration
- Dependencies on other teams or systems
- Items deferred to later iterations
- Assumptions that need validation during implementation

**If none:** State "No open questions - ready for implementation"

### Step 3.2: Review PRD

Before saving, review the PRD:
1. All sections present (use N/A if not applicable)
2. Problem-to-solution journey is clear
3. All Functional Requirements are numbered (FR-N) and testable
4. Architecture decisions are clear and actionable
5. Implementation guidance is specific and detailed

Present the complete PRD to the user for final review and approval.

**Wait for approval** before proceeding to save.

### Step 3.3: Git Branch Setup

Create the feature branch:

```bash
git checkout main  # or develop, depending on project
git pull origin main
git checkout -b feature/[feature-name]
```

**Branch naming:** Use kebab-case matching the feature/solution name (e.g., `feature/user-profile-editing`)

### Step 3.4: Generate Task Folder ID

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

### Step 3.5: Update tasks.json

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

### Step 3.6: Save PRD

Save the PRD file:
- **Path:** `./docs/tasks/[FOLDER_ID]/prd-[feature-name].md`
- **Format:** `YYYYMMDD-NNN-[feature-name]/prd-[feature-name].md`
- Create directory if needed

**Example:**
- Branch: `feature/user-profile-editing`
- Folder ID: `20250122-002-user-profile-editing`
- PRD Path: `./docs/tasks/20250122-002-user-profile-editing/prd-user-profile-editing.md`

### Step 3.7: Commit PRD and Metadata

Commit the PRD and updated tasks.json to the feature branch:

```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add PRD for [feature-name]

Document problem discovery, solution exploration, and architectural
design through collaborative process. Includes codebase analysis,
solution alternatives evaluated, and implementation-ready guidance.

- Problem: [brief problem statement]
- Solution: [brief solution approach]
- [N] functional requirements defined
- [N] architecture options analyzed
- [Recommended approach] selected"
```

---

## Output

- Feature branch created: `feature/[feature-name]`
- Task folder created with unique ID: `./docs/tasks/[FOLDER_ID]/`
- PRD document saved to `./docs/tasks/[FOLDER_ID]/prd-[feature-name].md`
- tasks.json updated with new task entry (status: pending, priority assigned)
- PRD and metadata committed to feature branch
- Ready for implementation via `/feature-implement` command

## Success Criteria

- [ ] Problem thoroughly understood and documented
- [ ] User's initial ideas analyzed with codebase context
- [ ] Multiple solution options explored and evaluated
- [ ] Solution approach agreed upon with clear reasoning
- [ ] Light codebase exploration completed before solution discussion (Phase 1)
- [ ] Deep codebase exploration completed before architecture proposals (Phase 2)
- [ ] All questions asked with agent's recommended answers
- [ ] 2-3 architecture options proposed with detailed context
- [ ] Each architecture option discussed with user
- [ ] Architecture approach finalized with explicit agreement
- [ ] Feature branch created with consistent naming
- [ ] Unique task folder ID generated using YYYYMMDD-NNN format
- [ ] PRD contains all required sections (N/A if not applicable)
- [ ] Solution Discovery Journey section captures Phase 1 exploration
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
- [ ] Branch name matches feature name (not folder ID prefix)
- [ ] User has confirmed the PRD is complete and accurate
- [ ] Both decision checkpoints (Phase 1 and Phase 2) explicitly confirmed before proceeding

## Examples

### Example: Question Format

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

### Example: Analyzing User's Idea

```
You proposed: "Add a settings panel where users can toggle features on/off"

**My analysis:**
- **How it solves the problem:** Gives users control over their experience and reduces clutter
- **Fit with codebase:** Your app already has a UserPreferences model (src/models/UserPreferences.js) and settings UI pattern (src/components/Settings/)
- **Pros:**
  - Leverages existing settings infrastructure
  - Familiar UX pattern for users
  - Easy to extend with new toggles later
- **Cons:**
  - Settings panel is already crowded (15 items currently)
  - Another setting adds cognitive load
  - Requires backend changes to persist preferences
- **Effort estimate:** Medium - need to add preference model field, API endpoint, and UI toggle

**My recommendation:** Good approach, but I suggest we organize settings into categories first (your Settings component is getting unwieldy). We could add a "Features" category and put this toggle there. This solves the immediate need and improves the overall settings experience.

**Alternative idea:** Instead of a settings toggle, what about an inline control directly in the feature's context? For example, if this is about notifications, put the toggle in the notifications panel itself. This reduces the settings burden and makes the control more discoverable.

**What do you think?** Settings panel, inline control, or discuss further?
```
