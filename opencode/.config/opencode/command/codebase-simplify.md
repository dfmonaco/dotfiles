---
description: Analyze codebase for simplification opportunities and create refactor task documents
---

# Codebase Simplify

## Objective
Perform a comprehensive analysis of the entire codebase to identify opportunities for simplification and improvement. Present findings interactively for user approval, then automatically create implementation-ready refactor task documents for each approved simplification.

## Input
Optional `$ARGUMENTS`:
- Empty: Analyze entire codebase
- Specific path: Focus analysis on particular directory or module (e.g., "src/auth", "lib/database")

## Core Principles

### Thoroughness
- **Comprehensive coverage:** Examine all major codebase areas
- **Multiple perspectives:** Consider complexity from maintainability, readability, and performance angles
- **Trade-off analysis:** For each suggestion, evaluate pros and cons of both current and proposed approaches
- **Multiple approaches:** Explore 2-3 alternative simplification strategies for each complex area

### User Control
- **Interactive approval:** Present each finding for user review
- **Clear trade-offs:** User sees benefits and costs before approving
- **Selective implementation:** User chooses which simplifications to pursue
- **Transparent process:** User understands what will be created

### Actionability
- **Implementation-ready:** Each approved item becomes a complete refactor task document
- **Prioritized output:** Clear guidance on implementation order
- **Batch efficiency:** Multiple refactor tasks created in one session
- **Integrated workflow:** Output ready for `/task-implement` command

## Process

### Phase 1: Discovery & Analysis

#### 1.1 Understand Project Context
Read project documentation and configuration to understand:
- Project purpose and goals (@README.md, @AGENTS.md)
- Technology stack and dependencies (@package.json, @Cargo.toml, etc.)
- Build and test setup
- Current development patterns

#### 1.2 Examine Codebase Structure
Analyze the overall structure:
```bash
# Get directory structure
find . -type f -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.rs" | head -50

# Count lines of code by file type
find . -name "*.ts" -exec wc -l {} + | sort -rn | head -20
```

Identify:
- Main application entry points
- Core modules and their dependencies
- Configuration files and patterns
- Test coverage and structure

#### 1.3 Identify Complexity Hotspots
Look for indicators of high complexity:
- **Large files:** Files with excessive line counts (>500 lines)
- **Deep nesting:** Functions with multiple levels of conditionals
- **Tight coupling:** Modules with many interdependencies
- **Duplicate patterns:** Repeated code that could be abstracted
- **Complex abstractions:** Over-engineered solutions to simple problems
- **Feature bloat:** Features that add disproportionate complexity
- **Dead code:** Unused functions, components, or features

#### 1.4 Analyze Dependencies
Examine external and internal dependencies:
- Are all dependencies necessary?
- Can any be replaced with simpler alternatives?
- Are there version conflicts or maintenance issues?
- Can functionality be achieved with fewer dependencies?

### Phase 2: Generate & Present Recommendations

#### 2.1 Categorize Findings
Group complexity issues by type:
- **Code-level:** Function/class complexity, naming, organization
- **Architecture-level:** Module structure, coupling, cohesion
- **Feature-level:** Feature complexity vs value proposition
- **Technical debt:** Outdated patterns, deprecated APIs, TODO comments
- **Dead code:** Unused code that can be safely removed

#### 2.2 Prioritize Findings
Rank each finding by:
- **Impact:** High/Medium/Low (maintainability, performance, clarity improvement)
- **Effort:** Easy (<2 hours) / Medium (2-8 hours) / Hard (>8 hours)
- **Risk:** Low/Medium/High (chance of breaking something)

Create priority matrix:
- **Quick Wins:** High impact, Easy effort → Recommend first
- **Strategic:** High impact, Medium/Hard effort → Recommend second
- **Low Priority:** Medium/Low impact → Recommend last
- **Skip:** Low impact, High effort → Mention but don't recommend

#### 2.3 Interactive Review
For each recommendation (starting with highest priority):

**Present in this format:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Recommendation #X: [Short descriptive name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Priority: [Quick Win / Strategic / Low Priority]
Effort: [Easy / Medium / Hard] (~X hours)
Impact: [High / Medium / Low]
Risk: [Low / Medium / High]

CURRENT STATE:
- Location: [file paths with line numbers]
- Problem: [Clear description of complexity/issue]
- Metrics: [LOC, cyclomatic complexity, etc. if relevant]

PROPOSED SIMPLIFICATION:
- Approach: [What to do]
- Implementation: [High-level steps]
- Alternatives considered: [2-3 other approaches]

TRADE-OFF ANALYSIS:
✓ Benefits:
  - [Benefit 1]
  - [Benefit 2]
  
✗ Costs/Risks:
  - [Cost 1]
  - [Risk 1]

RECOMMENDATION: [Why this approach is best]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Ask user:**
```
Create refactor task for this? 
  Y - Yes, create task document
  n - No, skip this
  L - Later (save in report but don't create task)
  ? - More details
  Q - Quit review (stop presenting, proceed with approved items)

Your choice (Y/n/L/?/Q):
```

**Handle responses:**
- `Y` or empty: Add to approved list, continue
- `n`: Add to skipped list, continue
- `L`: Add to deferred list (will be in report), continue
- `?`: Provide additional details (code examples, more context), ask again
- `Q`: Stop review, proceed to task document creation with approved items

#### 2.4 Track Decisions
Maintain three lists:
- **Approved:** Will create refactor task documents
- **Skipped:** Won't create tasks, won't include in report
- **Deferred:** Won't create tasks, but include in report for future consideration

### Phase 3: Create Task Documents

#### 3.1 Summary Before Creation
Before creating any files, show summary:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
REVIEW COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Findings: X total
Approved: Y (will create refactor tasks)
Deferred: Z (saved for later)
Skipped: W (not included)

I will now create Y refactor task documents:
1. ./docs/tasks/[name-1]/refactor-[name-1].md
2. ./docs/tasks/[name-2]/refactor-[name-2].md
...

Proceed? (Y/n):
```

If user confirms, proceed. If not, ask what to adjust.

#### 3.2 Create Refactor Task Documents
For each approved recommendation:

**1. Generate task name:** 
- Convert recommendation title to kebab-case
- Example: "Extract Authentication Logic" → `extract-auth-logic`

**2. Create directory:**
```bash
mkdir -p ./docs/tasks/[task-name]
```

**3. Create `refactor-[task-name].md` with full specification:**

```markdown
---
created_by: /codebase-simplify
analysis_date: [YYYY-MM-DD]
priority: [Quick Win / Strategic / Low Priority]
estimated_effort: [X hours]
---

# Refactoring: [Name]

## Refactoring Overview
- **Type:** [Restructuring/Renaming/Pattern Implementation/Performance/Cleanup/Removal]
- **Scope:** [files, modules, or components affected]
- **Estimated Effort:** [X hours]
- **Priority:** [Quick Win / Strategic / Low Priority]
- **Impact:** [High / Medium / Low]
- **Risk:** [Low / Medium / High]

## Motivation
[Why this refactoring is needed - from analysis]

**Current Problems:**
- [Problem 1]
- [Problem 2]

**Benefits of Refactoring:**
- [Benefit 1]
- [Benefit 2]

## Current State Analysis

**Structure:**
[Current code organization]

**Problems:**
- [file.ext:line] - [Specific issue]
- [file.ext:line] - [Specific issue]

**Code Smells Identified:**
- [Code smell 1]
- [Code smell 2]

**Complexity Metrics:** (if applicable)
- LOC: [number]
- Cyclomatic Complexity: [number]
- Dependencies: [number]

## Target State

**Structure:**
[Desired code organization]

**Improvements:**
- [How complexity is reduced]
- [How maintainability is improved]
- [How testability is improved]

**Before/After Example:**
```[language]
// Before
[key code snippet showing current complexity]

// After
[key code snippet showing simplified version]
```

## Refactoring Strategy

**Approach:** [Incremental / Big-bang / Strangler Fig]

**Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]
...

**Alternative Approaches Considered:**
- **Option A:** [approach] - Rejected because [reason]
- **Option B:** [approach] - Rejected because [reason]

## Refactoring Requirements

RR-1: [Specific requirement]
RR-2: [Specific requirement]
RR-3: Maintain 100% backward compatibility with existing public APIs
RR-4: All existing tests must continue to pass without modification
RR-5: Add new tests for refactored modules
...

## Safety & Testing Strategy

**Pre-refactoring:**
- [ ] Run full test suite and record baseline
- [ ] Identify all usages of code to be refactored
- [ ] Document current behavior (inputs/outputs)

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

**Regression Prevention:**
- [Specific tests to add]
- [Documentation to update]

## Breaking Changes Assessment

**Public API Changes:** None

**Internal API Changes:**
- [Change 1 with migration path]
- [Change 2 with migration path]

## Trade-off Analysis

**Current (Complex Approach):**
✓ Pros:
  - [Pro 1]
  - [Pro 2]

✗ Cons:
  - [Con 1]
  - [Con 2]

**Proposed (Simplified Approach):**
✓ Pros:
  - [Pro 1]
  - [Pro 2]

✗ Cons:
  - [Con 1]
  - [Con 2]

**Conclusion:** [Why the proposed approach is better]

## Rollback Strategy

**Rollback Steps:**
1. Revert commit [will be filled during implementation]
2. [Any data migrations to reverse]
3. Verify rollback with [test/check]

**Rollback Triggers:**
- Test failures post-deployment
- Performance degradation >X%
- Critical bugs discovered

## Acceptance Criteria
- [ ] All refactoring requirements (RR-X) satisfied
- [ ] All existing tests pass
- [ ] New tests added and passing
- [ ] No breaking changes to public APIs
- [ ] Code review approved
- [ ] Documentation updated
- [ ] Performance benchmarks maintained or improved

## Technical Notes
[Any additional technical considerations]

## Related Information
- Source Analysis: ./analyses/codebase-simplification-[date].md
- Related Refactorings: [if any]
```

**4. Save the file**

#### 3.3 Create Master Analysis Report
Save comprehensive analysis to: `./analyses/codebase-simplification-[YYYY-MM-DD].md`

**Structure:**
```markdown
# Codebase Simplification Analysis
**Date:** [YYYY-MM-DD]
**Scope:** [Entire codebase / Specific path]
**Findings:** X total recommendations

## Executive Summary

### Key Findings
- [Top finding 1]
- [Top finding 2]
- [Top finding 3]

### Overall Assessment
- Total complexity hotspots identified: X
- High-priority items: Y
- Quick wins available: Z
- Estimated total effort to address all: W hours

### Recommended Priority Actions
1. [Task name] - [Why it's top priority]
2. [Task name] - [Why it's second]
3. [Task name] - [Why it's third]

## Project Overview
- Technology Stack: [list]
- Codebase Metrics:
  - Total LOC: [number]
  - Files: [number]
  - Modules: [number]
- Complexity Indicators: [summary]

## Approved Recommendations (Y)

### 1. [Recommendation Name]
**Status:** ✅ Task document created

**Priority:** [Quick Win / Strategic / Low Priority]
**Effort:** [X hours]
**Impact:** [High / Medium / Low]

**Summary:** [Brief description]

**Task Document:** `./docs/tasks/[name]/refactor-[name].md`

**Next Steps:** Run `/task-implement` on `refactor/[name]` branch

---

[Repeat for each approved recommendation]

## Deferred Recommendations (Z)

### 1. [Recommendation Name]
**Priority:** [level]
**Effort:** [X hours]
**Why Deferred:** [Reason or user note]

[Full analysis as would appear in approved section]

---

[Repeat for each deferred recommendation]

## Complexity Metrics Summary
[Charts, tables, or summaries of codebase complexity]

## Implementation Roadmap

### Phase 1: Quick Wins (1-2 weeks)
1. [Task] - [effort] - [impact]
2. [Task] - [effort] - [impact]

### Phase 2: Strategic Improvements (1-2 months)
1. [Task] - [effort] - [impact]
2. [Task] - [effort] - [impact]

### Phase 3: Long-term Refactoring (2-6 months)
1. [Task] - [effort] - [impact]

## Success Metrics
After implementing all approved refactorings, expect:
- [Metric 1]: Improve from [current] to [target]
- [Metric 2]: Reduce from [current] to [target]
- [Metric 3]: Increase from [current] to [target]

## Appendix

### Complexity Indicators Found
- Large files (>500 LOC): [count] files
- Deep nesting (>3 levels): [count] functions
- Duplicate code: [count] instances
- Dead code: [count] unused items
- Over-abstraction: [count] instances

### Analysis Methodology
[Brief description of how analysis was performed]
```

### Phase 4: Output & Next Steps

#### 4.1 Present Summary to User
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ CODEBASE SIMPLIFICATION COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Analysis Summary:
- Examined: [scope description]
- Found: X complexity hotspots
- Approved: Y refactor tasks
- Deferred: Z recommendations (saved for later)

📁 Created Files:
- Master analysis: ./analyses/codebase-simplification-[date].md
- Refactor tasks:
  1. ./docs/tasks/[name-1]/refactor-[name-1].md
  2. ./docs/tasks/[name-2]/refactor-[name-2].md
  ...

🎯 Recommended Implementation Order:

**Quick Wins** (Start here - high impact, low effort):
1. [task-name-1] (~X hours)
   - Impact: [description]
   - Run: /task-implement (will auto-detect on refactor/[name-1] branch)

2. [task-name-2] (~X hours)
   - Impact: [description]
   - Run: /task-implement (will auto-detect on refactor/[name-2] branch)

**Strategic** (After quick wins - high impact, more effort):
3. [task-name-3] (~X hours)
   - Impact: [description]

**Low Priority** (Nice to have):
4. [task-name-4] (~X hours)
   - Impact: [description]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Next Steps:

Option 1 (Recommended): Implement highest priority refactor now
  $ /task-implement
  (This will auto-create refactor/[name-1] branch and start implementation)

Option 2: Review task documents first
  $ cat ./docs/tasks/[name-1]/refactor-[name-1].md

Option 3: Review full analysis report
  $ cat ./analyses/codebase-simplification-[date].md

Option 4: Implement multiple refactors (run sequentially, one at a time)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Success Criteria

### Analysis Complete When:
- [ ] Entire codebase (or specified path) has been examined
- [ ] At least 5-10 specific, actionable findings identified
- [ ] Each finding includes:
  - [ ] Clear description with file references
  - [ ] Proposed simplification approach
  - [ ] Trade-off analysis
  - [ ] Impact and effort estimates
  - [ ] Priority ranking
- [ ] All findings presented to user interactively
- [ ] User decisions recorded (approved/skipped/deferred)

### Task Documents Complete When:
- [ ] One refactor-*.md created for each approved recommendation
- [ ] Each document contains:
  - [ ] Complete refactoring specification
  - [ ] Current and target state
  - [ ] Step-by-step implementation plan
  - [ ] Safety and testing strategy
  - [ ] Trade-off analysis
  - [ ] Acceptance criteria
- [ ] Master analysis report created with all findings
- [ ] Clear implementation roadmap provided
- [ ] User knows exactly what to do next

### Quality Standards:
- [ ] Trade-off analyses are balanced and honest
- [ ] Recommendations don't break core functionality
- [ ] Multiple perspectives considered for each issue
- [ ] File references are accurate and specific
- [ ] Implementation guidance is clear and actionable
- [ ] User maintained control throughout process

## Notes

### Best Practices
- **Be thorough:** Don't rush the analysis; examine code carefully
- **Be specific:** Reference actual files and line numbers (e.g., src/auth.ts:145)
- **Be balanced:** Present honest trade-offs, not just benefits
- **Be practical:** Ensure recommendations are actually implementable
- **Respect user decisions:** Don't pressure user to approve everything
- **Think holistically:** Consider how changes affect the entire system

### Common Complexity Indicators
- Functions longer than 50 lines
- Classes with more than 10 methods
- Files with more than 500 lines
- Deep nesting (>3 levels of indentation)
- God objects (classes doing too much)
- Circular dependencies
- Excessive abstraction layers
- Premature optimization
- Feature creep (unused or rarely-used features)
- Copy-paste code duplication
- Dead code (unused functions, components)

### Analysis Depth Guidelines
- **Simple projects (<5k LOC):** Aim for 3-5 recommendations
- **Medium projects (5k-50k LOC):** Aim for 5-10 recommendations
- **Large projects (>50k LOC):** Aim for 10-15 recommendations, consider running multiple focused analyses

### Interactive Review Tips
- **Present highest priority items first:** User attention is highest at the start
- **Be patient:** Wait for user input, don't rush through
- **Provide context:** Help user understand why something is complex
- **Be honest about trade-offs:** Don't oversell simplifications
- **Accept "no":** Not every recommendation needs to be approved
- **Allow "?":** Give more details if user is uncertain

### Task Document Naming
- Use clear, action-oriented names
- Good: `extract-auth-logic`, `remove-csv-export`, `consolidate-validators`
- Bad: `refactor-1`, `simplify`, `cleanup`

### What NOT to Do
- Don't create task documents without user approval
- Don't pressure user to approve all recommendations
- Don't skip trade-off analysis (be honest about costs)
- Don't recommend changes that break core functionality
- Don't provide vague recommendations without specifics
- Don't forget to prioritize (everything can't be high priority)
- Don't analyze third-party code in detail (focus on your code)
