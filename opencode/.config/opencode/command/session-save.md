---
description: Save current session context by extracting key decisions and filtering noise
---

# Session Save

## Objective
Analyze the current OpenCode conversation, extract valuable context (decisions, solutions, changes), filter out noise and failed attempts, and generate a clean summary document for future session restoration. The saved session enables seamless continuation of work without losing critical context.

## Role & Standards
Act as a **Senior Technical Writer** creating documentation for your **Future Self**.
- **Tone:** Clear, concise, and context-rich
- **Quality:** Focus on decisions made, problems solved, and actionable next steps
- **Format:** Markdown with structured frontmatter

## Process

### 1. Conversation Analysis

Read the entire conversation history from the current OpenCode session and perform comprehensive analysis:

1. **Extract Key Elements:**
   - User requests and goals
   - Agent responses and recommendations
   - Tool calls made (files read, edits, bash commands, searches)
   - Decisions agreed upon and their rationale
   - Approaches discussed (accepted and rejected)
   - Problems encountered and solutions implemented
   - Code changes and commits made
   - Failed attempts and why they failed
   - Discoveries about the codebase or requirements
   - Open questions and unresolved issues

2. **Categorize Findings:**
   - **Critical Context:** Background, constraints, requirements discovered
   - **Decisions Made:** Agreed approaches, architectures, patterns chosen (with WHY)
   - **Changes Implemented:** Files modified, commits made, configurations changed
   - **Problems Solved:** Issues encountered and how they were resolved
   - **Failed Attempts:** What didn't work and why (important for avoiding repetition)
   - **Open Questions:** Unresolved issues, pending decisions, next steps
   - **Technical Details:** Code snippets, commands, configurations worth preserving

3. **Identify Noise to Filter:**
   - Intermediate steps that led nowhere
   - Repetitive explanations
   - Tangential discussions not relevant to main goal
   - Tool output that's no longer relevant
   - Debugging attempts that were superseded by better solutions

### 2. Present Analysis

Show the user your automatic analysis with proposed categorization:

**Format:**
```
Session Analysis Complete
========================

I've analyzed the conversation and extracted the following:

## Summary
[2-3 sentence overview of what we worked on]

## Critical Context (things we discovered/learned)
- [Context item 1]
- [Context item 2]
...

## Decisions Made (with rationale)
- [Decision 1: What we chose and why]
- [Decision 2: What we chose and why]
...

## Changes Implemented
- [Change 1: File/component and purpose]
- [Change 2: File/component and purpose]
...

## Problems Solved
- [Problem 1: Issue and solution]
- [Problem 2: Issue and solution]
...

## Failed Attempts (to avoid repeating)
- [Attempt 1: What we tried and why it didn't work]
- [Attempt 2: What we tried and why it didn't work]
...

## Open Questions / Next Steps
- [ ] [Todo 1]
- [ ] [Todo 2]
...

## Technical Details Worth Keeping
[Code snippets, configurations, commands]

========================

## My Recommendations:

**What I think is IMPORTANT to keep:**
- [Item 1 with reasoning]
- [Item 2 with reasoning]

**What I think is NOISE and should be removed:**
- [Item 1 with reasoning]
- [Item 2 with reasoning]

**Missing context I think we should add:**
- [Additional context item 1]
- [Additional context item 2]

========================
```

### 3. Interactive Review

After presenting the analysis, collaborate with the user:

1. **Ask for feedback:**
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

2. **Wait for user response**

3. **Incorporate feedback:**
   - Add missing items
   - Remove unnecessary items
   - Adjust categorization based on user input
   - Refine session title

### 4. Generate Session Document

Once the content is finalized, create the session document with this structure:

```markdown
---
date: [YYYY-MM-DD HH:MM]
project: [project name from git remote or directory name]
tags: [auto-detected tags: feature, bugfix, refactor, planning, etc.]
status: [in-progress | completed | paused]
related_files: [key files modified/discussed]
related_commits: [commit SHAs if any]
---

# Session: [Brief Title]

## Summary
[2-3 sentence overview of what was worked on and accomplished]

## Context
[Important background information, constraints, requirements discovered]
[Why this work was needed]
[What problem we're solving]

## Decisions Made
[Each decision with clear rationale]

**Decision 1: [Title]**
- **What:** [What was decided]
- **Why:** [Rationale and reasoning]
- **Alternatives considered:** [What we didn't choose and why]

**Decision 2: [Title]**
...

## Changes Implemented
[Files/components changed with purpose]

- **[file/path]**: [What changed and why]
- **[file/path]**: [What changed and why]

**Commits Made:**
```
[commit hash]: [commit message]
[commit hash]: [commit message]
```

## Problems Solved
[Issues encountered and solutions]

**Problem 1: [Title]**
- **Issue:** [What the problem was]
- **Solution:** [How we solved it]
- **Outcome:** [Result/validation]

**Problem 2: [Title]**
...

## Failed Attempts
[What didn't work - important to avoid repeating]

- **[Approach 1]**: [Why it failed, what we learned]
- **[Approach 2]**: [Why it failed, what we learned]

## Open Questions / Next Steps
[Unresolved issues and future work]

- [ ] [Todo/question 1]
- [ ] [Todo/question 2]
- [ ] [Todo/question 3]

## Technical Details
[Code snippets, configurations, commands worth preserving]

### [Section 1]
```[language]
[code or configuration]
```

### [Section 2]
```bash
[commands]
```

## Notes
[Any additional context, links, references, or thoughts]

---

## Restoration Guide
[Brief note on how to restore this session]

When continuing this session:
1. Read this document for context
2. Review open questions and next steps
3. Check if any related files have changed since this session
4. [Any other specific instructions]
```

### 5. Determine Save Location

Before saving, determine the appropriate file path:

1. **Check for project-specific sessions directory:**
   ```bash
   # Check if .opencode/sessions/ exists
   if [ ! -d ".opencode/sessions" ]; then
     mkdir -p .opencode/sessions
   fi
   ```

2. **Generate filename:**
   ```bash
   # Format: session-YYYY-MM-DD-HHMM-brief-description.md
   TIMESTAMP=$(date +%Y-%m-%d-%H%M)
   TITLE_SLUG=$(echo "[title]" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
   FILENAME="session-${TIMESTAMP}-${TITLE_SLUG}.md"
   ```

3. **Full path:**
   `.opencode/sessions/session-YYYY-MM-DD-HHMM-[title].md`

**Example:**
- Session title: "Add User Profile Editing"
- Timestamp: 2025-01-22 14:30
- Filename: `session-2025-01-22-1430-add-user-profile-editing.md`
- Full path: `.opencode/sessions/session-2025-01-22-1430-add-user-profile-editing.md`

### 6. Save Session Document

1. **Write the file:**
   - Save to `.opencode/sessions/[filename].md`
   - Ensure directory exists (create if needed)

2. **Confirm to user:**
   ```
   ✓ Session saved successfully!
   
   **Location:** .opencode/sessions/[filename].md
   **Title:** [session title]
   **Status:** [status]
   **Date:** [date]
   
   ## Git Options
   
   This session document is saved locally. You have three options:
   
   1. **Commit to git** (share with team, track history):
      git add .opencode/sessions/[filename].md
      git commit -m "docs: save session context for [title]"
   
   2. **Add to .gitignore** (keep private):
      echo ".opencode/sessions/" >> .gitignore
   
   3. **Leave as-is** (local only, not tracked)
   
   ## Next Steps
   
   To restore this session later, use:
   /session-restore .opencode/sessions/[filename].md
   
   (Note: session-restore command needs to be created separately)
   
   ## Session Statistics
   - Total sections: [count]
   - Decisions captured: [count]
   - Problems solved: [count]
   - Changes documented: [count]
   - Open items: [count]
   ```

### 7. Auto-detect Metadata

When generating the document, automatically populate frontmatter:

**Date:**
```bash
date -u +"%Y-%m-%d %H:%M"
```

**Project Name:**
```bash
# Try git remote first
PROJECT=$(git remote get-url origin 2>/dev/null | sed 's/.*[:/]\([^/]*\)\/\([^.]*\).*/\2/' || basename $(pwd))
```

**Tags:**
Auto-detect based on conversation content:
- Look for keywords: "feature", "bug", "fix", "refactor", "planning", "architecture", "performance", "security", "testing", "documentation"
- Extract branch name patterns (feature/, fix/, refactor/)
- Analyze what files were changed (backend, frontend, database, etc.)

**Status:**
- `in-progress`: If there are open questions/next steps
- `completed`: If all work is done
- `paused`: If explicitly mentioned or contextually implied
- Default to `in-progress` if unclear

**Related Files:**
- List files that were read, edited, or discussed
- Use relative paths from project root
- Limit to most important files (max 10-15)

**Related Commits:**
```bash
# Get commits from current branch since session likely started
git log --oneline -n 10 --format="%H"
```

## Output
- Session document saved to `.opencode/sessions/session-YYYY-MM-DD-HHMM-[title].md`
- Clean, noise-free summary of conversation
- Structured sections with actionable context
- Rich metadata for future searchability
- User guidance on git options and restoration

## Success Criteria
- [ ] Entire conversation history analyzed
- [ ] Key decisions extracted with rationale
- [ ] Code changes documented with purpose
- [ ] Problems and solutions captured
- [ ] Failed attempts noted to avoid repetition
- [ ] Open questions and next steps clearly listed
- [ ] Noise and intermediate steps filtered out
- [ ] User reviewed and approved content
- [ ] Session title is descriptive and concise
- [ ] Frontmatter metadata complete and accurate
- [ ] Document saved to correct location
- [ ] User informed about git options and next steps

## Notes

### What Makes a Good Session Summary

**Include:**
- **Decisions with WHY:** Not just what, but why we chose it
- **Context discovered:** Things we learned about the codebase, requirements, constraints
- **Problems solved:** Not just "fixed bug" but what the bug was and how we solved it
- **Failed attempts:** What we tried that didn't work (prevents future repetition)
- **Next steps:** Clear actionable items for future session

**Exclude:**
- Intermediate debugging steps that were superseded
- Repetitive explanations of the same concept
- Tool output that's no longer relevant (unless it contains insights)
- Tangential discussions that didn't lead anywhere
- Step-by-step implementation details (keep high-level decisions instead)

### Session Restoration (Future Command)

This command is designed to work with a future `/session-restore` command that will:
1. List available session files in `.opencode/sessions/`
2. Load selected session and inject context
3. Summarize the previous session for the user
4. Ask "Ready to continue? Any changes to the plan?"
5. Resume work seamlessly

The structured format with frontmatter and clear sections enables easy parsing and context injection.

### Tips for Users

**When to save a session:**
- At the end of a work session before closing OpenCode
- After completing a major milestone or decision point
- Before switching to a different task or project
- When pausing work that you'll resume later

**How to use saved sessions:**
- Review before resuming work to refresh context
- Share with team members to transfer knowledge
- Reference during PR reviews or documentation writing
- Use as a project journal for tracking decisions over time

### Future Enhancements

Potential improvements for this command:
- **Auto-save:** Automatically save sessions on exit or periodically
- **Session search:** Command to search across all saved sessions
- **Session diff:** Compare two sessions to see progress
- **Session merge:** Combine multiple related sessions
- **Export formats:** Support JSON, HTML, or other formats
