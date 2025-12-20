---
description: Save current session context by extracting key decisions and filtering noise
---

# Session Save

## Objective
Analyze the current conversation, extract valuable context (decisions, solutions, changes), filter out noise, and generate a clean summary document for future session restoration.

## Role & Standards
Act as a **Senior Technical Writer** creating documentation for your **Future Self**.
- **Tone:** Clear, concise, and context-rich
- **Focus:** Decisions made, problems solved, and actionable next steps

## Process

### 1. Conversation Analysis

Read the entire conversation and extract:

**Key Elements:**
- User requests and goals
- Decisions agreed upon and their rationale
- Approaches discussed (accepted and rejected)
- Problems encountered and solutions implemented
- Code changes and commits made
- Failed attempts and why they failed
- Discoveries about the codebase or requirements
- Open questions and unresolved issues

**Categorize Into:**
- **Critical Context:** Background, constraints, requirements discovered
- **Decisions Made:** Approaches, architectures, patterns chosen (with WHY)
- **Changes Implemented:** Files modified, commits made
- **Problems Solved:** Issues encountered and resolutions
- **Failed Attempts:** What didn't work and why (to avoid repetition)
- **Open Questions:** Unresolved issues, pending decisions, next steps
- **Technical Details:** Code snippets, commands worth preserving

**Filter Out (Noise):**
- Intermediate steps that led nowhere
- Repetitive explanations
- Tangential discussions not relevant to main goal
- Debugging attempts superseded by better solutions

### 2. Present Analysis

Show the user your analysis with proposed categorization:

```
Session Analysis Complete
=========================

## Summary
[2-3 sentence overview]

## Critical Context
- [Context items discovered/learned]

## Decisions Made
- [Decision: What we chose and why]

## Changes Implemented
- [File/component and purpose]

## Problems Solved
- [Issue and solution]

## Failed Attempts
- [What we tried and why it didn't work]

## Open Questions / Next Steps
- [ ] [Todo items]

## Technical Details Worth Keeping
[Code snippets, configurations, commands]

=========================

## My Recommendations:

**IMPORTANT to keep:**
- [Item with reasoning]

**NOISE to remove:**
- [Item with reasoning]

**Missing context to add:**
- [Additional context]
```

### 3. Interactive Review

After presenting the analysis, ask for feedback:

```
Please review the analysis above and let me know:

1. Do you AGREE with my recommendations on what to keep/remove?
   - Reply "Agree" to accept all recommendations
   - Or specify what to change

2. Is anything MISSING that should be included?
   - Any context I overlooked?
   - Any decisions not captured?

3. Is anything INCLUDED that should be removed?
   - Any items that aren't relevant for future sessions?

4. What should be the SESSION TITLE?
   - Suggest: [auto-generated brief title]
   - Or provide your own title
```

Wait for user response, then incorporate feedback.

### 4. Generate Session Document

Create the document with this structure:

```markdown
---
date: [YYYY-MM-DD HH:MM]
project: [project name]
tags: [feature, bugfix, refactor, etc.]
status: [in-progress | completed | paused]
related_files: [key files modified/discussed]
related_commits: [commit SHAs if any]
---

# Session: [Brief Title]

## Summary
[2-3 sentence overview of what was worked on]

## Context
[Important background, constraints, why this work was needed]

## Decisions Made

**Decision 1: [Title]**
- **What:** [What was decided]
- **Why:** [Rationale]
- **Alternatives considered:** [What we didn't choose]

## Changes Implemented

- **[file/path]**: [What changed and why]

**Commits Made:**
- `[hash]`: [message]

## Problems Solved

**Problem 1: [Title]**
- **Issue:** [What the problem was]
- **Solution:** [How we solved it]

## Failed Attempts

- **[Approach]**: [Why it failed, what we learned]

## Open Questions / Next Steps

- [ ] [Todo item]

## Technical Details

### [Section]
```[language]
[code or configuration]
```

## Notes
[Additional context, links, references]
```

### 5. Save Session

**Directory:** `.opencode/sessions/` (create if needed)

**Filename format:** `session-YYYY-MM-DD-HHMM-[title-slug].md`

Example: `session-2025-01-22-1430-add-user-profile-editing.md`

**After saving, confirm:**

```
✓ Session saved successfully!

**Location:** .opencode/sessions/[filename].md
**Title:** [session title]
**Status:** [status]

## Git Options

1. **Commit to git** (share with team):
   git add .opencode/sessions/[filename].md && git commit -m "docs: save session - [title]"

2. **Add to .gitignore** (keep private):
   echo ".opencode/sessions/" >> .gitignore

3. **Leave as-is** (local only)

## Session Statistics
- Decisions captured: [count]
- Problems solved: [count]
- Open items: [count]
```

### 6. Auto-detect Metadata

**Project:** From `git remote get-url origin` or directory name

**Tags:** Auto-detect from conversation keywords and branch name patterns:
- feature/, fix/, refactor/ branches
- Keywords: bug, feature, refactor, performance, security, testing, docs

**Status:**
- `in-progress`: Has open questions/next steps
- `completed`: All work done
- `paused`: Explicitly mentioned
- Default: `in-progress`

**Related Files:** Files read, edited, or discussed (max 10-15, relative paths)

**Related Commits:** Recent commits from current branch
