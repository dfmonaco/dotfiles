---
description: Plan a refactoring by creating an implementation-ready refactoring specification
---

# Refactor Plan

## Objective
Create a clear, implementation-focused refactoring specification that a junior developer can use to safely refactor code. The document serves as the source of truth for the current state, target state, migration strategy, and safety criteria.

## Role & Standards
Act as a Senior Software Engineer writing for a **Junior Developer**.
- **Tone:** Explicit, unambiguous, and implementation-focused
- **Quality:** Current state must be documented, target state must be clear, no breaking changes allowed
- **Format:** Markdown

## Process

### 1. Discovery
Ask the user to describe the refactoring they want to perform. Prompt them to provide:
- What code needs refactoring?
- Why does it need refactoring (technical debt, maintainability, performance)?
- What should the end result look like?
- Are there any constraints (no breaking changes, backward compatibility)?

### 2. Clarification
Once the user responds, analyze their request and:

1. **Restate** your understanding of the refactoring
2. **Ask clarifying questions** covering:
   - Scope & Boundaries (What's included? What's explicitly excluded?)
   - Motivation (Why now? What problems does this solve?)
   - Constraints (Backward compatibility? API stability? Performance requirements?)
   - Risk Tolerance (Can we break internal APIs? Must externals remain stable?)
   - Timeline (Is this incremental or big-bang?)
   - Success Metrics (How do we measure improvement?)

3. **Provide proposed answers** for every question based on best practices and code analysis
   - Tell the user: *"You can reply 'Agree' to accept all proposed answers, or correct specific ones"*

### 3. Draft Refactoring Specification
Once details are confirmed, generate the refactoring spec with this structure:

#### Required Sections

**1. Refactoring Overview**
- Refactoring name/title
- Type (Restructuring, Renaming, Pattern Implementation, Performance, Cleanup)
- Scope (files, modules, or components affected)
- Estimated effort (hours/days)

**2. Motivation**
- Why this refactoring is needed
- Current problems or pain points
- Technical debt being addressed
- Benefits of the refactoring (maintainability, performance, clarity)

**3. Current State Analysis**
Detailed analysis of code as it exists now:

**Structure:**
- Current file/module organization
- Current class/function structure
- Current dependencies and coupling
- Current patterns and anti-patterns

**Problems:**
- Code smells identified
- Complexity metrics (if relevant: cyclomatic complexity, LOC, etc.)
- Maintainability issues
- Performance bottlenecks (if applicable)

**Code References:**
- Specific files and line numbers
- Key functions/classes involved
- Dependencies to consider

Example:
```
Current Issues:
- src/auth/handler.ts:45-230 - 185-line function with deep nesting
- src/auth/validator.ts - Duplicated validation logic across 5 functions
- Tight coupling between auth module and database layer (12 direct imports)
```

**4. Target State**
Clear description of the desired end state:

**Structure:**
- New file/module organization
- New class/function structure
- New dependencies and coupling (reduced/reorganized)
- Design patterns to implement

**Improvements:**
- How complexity is reduced
- How maintainability is improved
- How performance is enhanced (if applicable)
- How testability is improved

**Code Examples:**
- Before/after code snippets (for key changes)
- New interfaces or abstractions
- New patterns being introduced

**5. Refactoring Strategy**
Step-by-step migration plan:

**Approach:** (Choose one or hybrid)
- **Incremental:** Gradual changes, each step is deployable
- **Big-bang:** Complete refactoring in one shot
- **Strangler Fig:** New code alongside old, gradually replace

**Steps:**
Numbered, sequential steps:
```
1. Extract [functionality] into [new module/function]
2. Update [callers] to use new [module/function]
3. Deprecate [old code] (or remove if internal)
4. Add tests for [new structure]
5. Remove [old code] after migration complete
```

**6. Refactoring Requirements**
- Numbered format (RR-1, RR-2, etc.)
- Must be specific, testable, and complete
- Emphasize no breaking changes and comprehensive testing

Example:
```
RR-1: Extract authentication logic from src/auth/handler.ts into separate service modules
RR-2: Maintain 100% backward compatibility with existing public APIs
RR-3: All existing tests must continue to pass without modification
RR-4: Add new tests for refactored modules (target 90%+ coverage)
RR-5: Update internal imports to use new module structure
RR-6: Remove deprecated code (or mark as deprecated if phased approach)
```

**7. Safety & Testing Strategy**
How to ensure the refactoring doesn't break anything:

**Pre-refactoring:**
- [ ] Run full test suite and record baseline
- [ ] Identify all usages of code to be refactored
- [ ] Document current behavior (inputs/outputs)
- [ ] Review dependencies and dependents

**During refactoring:**
- [ ] Make small, incremental changes
- [ ] Run tests after each change
- [ ] Use type system to catch breaking changes
- [ ] Keep commits atomic and reversible

**Post-refactoring:**
- [ ] All existing tests pass
- [ ] New tests added for refactored code
- [ ] Manual testing of critical paths
- [ ] Performance testing (if applicable)
- [ ] Code review by peer

**Regression Prevention:**
- Add tests that would have caught the original problem
- Document new patterns for future developers
- Update coding guidelines if needed

**8. Breaking Changes Assessment**
Explicit enumeration of any breaking changes:

**Public API Changes:** (must be empty for safe refactoring)
- None (or explicitly document and justify)

**Internal API Changes:**
- [List any internal API changes with migration path]

**Database/Schema Changes:**
- [Any schema migrations needed]

**Configuration Changes:**
- [Any config file or environment variable changes]

**9. Rollback Strategy**
Plan for reverting if issues arise:

**Rollback Steps:**
```
1. Revert commit [hash] (or merge revert PR)
2. [Any data migrations to reverse]
3. [Any config changes to revert]
4. Verify rollback with [test/check]
```

**Rollback Triggers:**
- Test failures post-deployment
- Performance degradation >X%
- Critical bugs discovered
- User-facing issues reported

**10. Acceptance Criteria**
What must be true for the refactoring to be considered complete:
- [ ] All refactoring requirements (RR-X) satisfied
- [ ] All existing tests pass
- [ ] New tests added and passing
- [ ] No breaking changes to public APIs
- [ ] Code review approved
- [ ] Documentation updated
- [ ] Performance benchmarks maintained or improved
- [ ] No increase in error rates post-deployment

**11. Technical Notes**
- Dependencies affected or to be removed
- Build or deployment changes
- Documentation to update
- Migration scripts needed (if any)
- Performance benchmarks (before/after)

**12. Related Information**
- GitHub issue or technical debt ticket (if applicable)
- Related refactorings or PRs
- Relevant ADRs (Architecture Decision Records)
- Reference documentation or RFCs

### 4. Git Branch Setup
Before saving the document, create a refactor branch for this work:

```bash
git checkout main  # or develop, depending on project
git pull origin main
git checkout -b refactor/[refactor-name]
```

**Branch naming:** Use kebab-case describing the refactoring (e.g., `refactor/auth-service-extraction`)

**Important:** The branch name should match the refactoring document filename for seamless integration with the `/task-implement` command.

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
FOLDER_ID="${TODAY}-${COUNTER}-[refactor-name]"
```

**Example:**
- Date: January 22, 2025
- Existing tasks today: 3
- New folder ID: `20250122-004-auth-service-extraction`

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
  "id": "20250122-004-auth-service-extraction",
  "type": "refactor",
  "status": "pending",
  "priority": null,
  "created": "2025-01-22T16:20:00Z",
  "branch": "refactor/auth-service-extraction",
  "description": "Extract authentication logic into separate service modules"
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
1. Review the document against the **Role & Standards**
2. Ensure current state is thoroughly documented
3. Ensure target state is clear and achievable
4. Ensure safety strategy is comprehensive
5. Save the file:
   - **Path:** `./docs/tasks/[FOLDER_ID]/refactor-[refactor-name].md`
   - **Format:** `YYYYMMDD-NNN-[refactor-name]/refactor-[refactor-name].md`
   - Create directory if needed

**Example:**
- Branch: `refactor/auth-service-extraction`
- Folder ID: `20250122-004-auth-service-extraction`
- Document Path: `./docs/tasks/20250122-004-auth-service-extraction/refactor-auth-service-extraction.md`
- tasks.json entry created with priority (if specified)

### 8. Commit Document and Metadata
Commit the refactoring spec and updated tasks.json to the refactor branch:

```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add refactoring spec for [refactor-name]

- Document current state and target improvements
- Define refactoring requirements and safety strategy
- Outline acceptance criteria and rollback plan
- Add task tracking entry"
```

## Output
- Refactor branch created: `refactor/[refactor-name]`
- Task folder created with unique ID: `./docs/tasks/[FOLDER_ID]/`
- Refactoring specification saved to `./docs/tasks/[FOLDER_ID]/refactor-[refactor-name].md`
- tasks.json updated with new task entry (status: pending, priority: user-specified or null)
- Document and metadata committed to refactor branch
- Ready for implementation via `/task-implement` command

## Success Criteria
- [ ] Refactor branch created with consistent naming
- [ ] Unique task folder ID generated using YYYYMMDD-NNN format
- [ ] Refactoring spec contains all required sections
- [ ] Current state is thoroughly analyzed with file references
- [ ] Target state is clear and well-defined
- [ ] Refactoring requirements are atomic and testable
- [ ] Safety strategy includes comprehensive testing plan
- [ ] Breaking changes are explicitly documented (preferably none)
- [ ] Rollback strategy is defined
- [ ] Acceptance criteria are measurable
- [ ] Document is saved to correct location with unique folder ID
- [ ] tasks.json created (if needed) and updated with new task entry
- [ ] Task entry includes: id, type, status, priority, created timestamp, branch, description
- [ ] Document and tasks.json committed to the refactor branch
- [ ] Branch name matches task name (not folder ID prefix)
- [ ] User has confirmed the specification is complete and accurate

## Notes

### Tips for Safe Refactoring
- **Small steps:** Make incremental changes, test frequently
- **Tests first:** Ensure good test coverage before refactoring
- **Type system:** Use types to catch breaking changes at compile time
- **Feature flags:** Use flags for large refactorings to enable gradual rollout
- **Pair programming:** Complex refactorings benefit from collaboration
- **Code review:** Get peer review before merging
- **Monitor metrics:** Watch error rates and performance after deployment

### Common Refactoring Types
- **Extract Function/Class:** Break down large functions/classes
- **Rename:** Improve naming for clarity
- **Move:** Reorganize code into better locations
- **Inline:** Remove unnecessary abstractions
- **Replace Algorithm:** Improve implementation while keeping interface
- **Introduce Parameter Object:** Group related parameters
- **Replace Conditional with Polymorphism:** Simplify complex conditionals
- **Extract Interface:** Define clear contracts
- **Consolidate Duplicate Code:** Remove duplication via abstraction

### Code Smells to Address
- **Long Method:** Functions >50 lines
- **Large Class:** Classes with too many responsibilities
- **Long Parameter List:** Functions with >5 parameters
- **Divergent Change:** Class changes for multiple reasons
- **Shotgun Surgery:** Single change requires many small edits across codebase
- **Feature Envy:** Method uses data from another class more than its own
- **Data Clumps:** Same group of data items appear together repeatedly
- **Primitive Obsession:** Overuse of primitives instead of small objects
- **Duplicate Code:** Same code structure in multiple places

### When NOT to Refactor
- Don't refactor just before a deadline
- Don't refactor without tests
- Don't refactor code you don't understand
- Don't refactor and add features in same PR
- Don't refactor external APIs without deprecation plan
- Don't refactor if business value is unclear
