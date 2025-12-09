---
description: Restore a saved session to continue work with full context
---

# Session Restore

## Objective
Load a previously saved session document, parse and inject its context into the current conversation, summarize the previous work, validate current status, and enable seamless continuation of work without losing critical context or decisions.

## Input
- **Optional argument:** `` - Direct path to session file
- **No argument:** Interactive selection from available sessions

## Process

### 1. Session Discovery

Determine which session to restore:

**If path argument provided:**
```bash
# Validate the provided path
SESSION_FILE=""

if [ ! -f "$SESSION_FILE" ]; then
  echo "Error: Session file not found at $SESSION_FILE"
  exit 1
fi
```

**If no argument provided:**
1. Search for available session files:
   ```bash
   # Look in project-specific sessions directory
   if [ -d ".opencode/sessions" ]; then
     find .opencode/sessions -name "session-*.md" -type f | sort -r
   fi
   ```

2. Present available sessions to user:
   ```
   Available Sessions
   ==================
   
   I found [N] saved sessions in this project:
   
   [For each session file, extract and display:]
   
   [1] [YYYY-MM-DD HH:MM] - [Session Title]
       Status: [status]
       Tags: [tags]
       Files: [count] files modified
       Path: [relative path]
   
   [2] [YYYY-MM-DD HH:MM] - [Session Title]
       Status: [status]
       Tags: [tags]
       Files: [count] files modified
       Path: [relative path]
   
   ...
   
   ==================
   
   Please select a session to restore:
   - Reply with the number (e.g., "1", "2")
   - Or provide the full path to a session file
   - Or reply "Cancel" to exit
   ```

3. Wait for user selection

4. Validate selection and load the chosen session file

**If no sessions found:**
```
No saved sessions found in this project.

Searched location: .opencode/sessions/

To create a session save, use:
/session-save

Would you like to:
1. Check a different location?
2. Create a new session?
3. Cancel?
```

### 2. Parse Session Document

Once session file is identified, parse its contents:

1. **Extract YAML frontmatter:**
   - `date`: When session was saved
   - `project`: Project name
   - `tags`: Session tags
   - `status`: in-progress, completed, or paused
   - `related_files`: Files that were modified/discussed
   - `related_commits`: Commit SHAs from that session

2. **Parse markdown sections:**
   - Summary
   - Context
   - Decisions Made
   - Changes Implemented
   - Problems Solved
   - Failed Attempts
   - Open Questions / Next Steps
   - Technical Details
   - Notes

3. **Build structured context object** in memory with all extracted information

### 3. Validate Current State

Before injecting context, check if the environment has changed:

1. **Check if related files still exist and have been modified:**
   ```bash
   # For each file in related_files:
   for file in "${related_files[@]}"; do
     if [ ! -f "$file" ]; then
       echo "⚠ Warning: $file no longer exists"
     else
       # Check if modified since session date
       FILE_MTIME=$(stat -c %Y "$file" 2>/dev/null || stat -f %m "$file" 2>/dev/null)
       SESSION_TIME=$(date -d "$session_date" +%s 2>/dev/null || date -j -f "%Y-%m-%d %H:%M" "$session_date" +%s 2>/dev/null)
       
       if [ "$FILE_MTIME" -gt "$SESSION_TIME" ]; then
         echo "⚠ Warning: $file has been modified since session was saved"
       fi
     fi
   done
   ```

2. **Check git status (if related_commits exist):**
   ```bash
   # Check current branch
   CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
   
   # Check if commits still exist in history
   for commit in "${related_commits[@]}"; do
     if ! git cat-file -e "$commit" 2>/dev/null; then
       echo "⚠ Warning: Commit $commit not found in current repository"
     fi
   done
   ```

3. **Collect warnings** to present to user

### 4. Present Session Summary

Display a comprehensive summary of the session being restored:

```
Session Restore: [Session Title]
================================

## Session Info
- **Saved:** [date]
- **Project:** [project]
- **Status:** [status]
- **Tags:** [tags]

## Summary
[Display the session summary section verbatim]

## Context Highlights
[Display key points from Context section - 3-5 bullet points max]

## Key Decisions (made during that session)
[List each decision title with brief what/why]

1. **[Decision 1 Title]**
   - What: [brief what]
   - Why: [brief why]

2. **[Decision 2 Title]**
   - What: [brief what]
   - Why: [brief why]

...

## Changes Implemented
[List files/components that were changed]

- [file/path]: [purpose]
- [file/path]: [purpose]
...

**Commits Made:**
[List commit hashes and messages if available]

## Problems Solved
[List problem titles with brief solution]

- **[Problem 1]**: [solution summary]
- **[Problem 2]**: [solution summary]
...

## Failed Attempts (to avoid repeating)
[List what didn't work]

- [Attempt 1]: [why it failed]
- [Attempt 2]: [why it failed]
...

## Open Questions / Next Steps
[Display the todo list from the session]

- [ ] [Todo 1]
- [ ] [Todo 2]
...

## Technical Details
[Show any code snippets or configurations that were preserved]

================================

## Environment Check

[If warnings found:]
⚠️ **Warnings Detected:**

- [Warning 1: e.g., "File X has been modified since session was saved"]
- [Warning 2: e.g., "Commit Y not found in current branch"]
...

These changes may affect the session context. Review carefully.

[If no warnings:]
✓ All related files and commits are present and unchanged since session was saved.

================================
```

### 5. Interactive Continuation

After presenting the summary, engage with the user:

```
## Ready to Continue?

I've loaded the context from this session. Before we proceed:

1. **Review the summary above** - Does it match your recollection?

2. **Check the warnings** [if any] - Do we need to account for changes?

3. **Validate next steps** - Are the open questions/todos still relevant?

Please respond with one of the following:

- **"Continue"** or **"Yes"** - Proceed with the next steps as outlined
- **"Modify"** - You want to adjust the plan or next steps
- **"Review [file]"** - You want to review specific files that changed
- **"Cancel"** - Exit without restoring context

You can also ask questions about the session or request clarification on any decisions or changes.

What would you like to do?
```

### 6. Handle User Response

Based on user input:

**If "Continue" or "Yes":**
1. Confirm context restoration:
   ```
   ✓ Context restored successfully!
   
   ## Current State
   - Session: [title]
   - Status: [status]
   - Next step: [first open todo or next action]
   
   I'm now fully aware of:
   - All decisions made and their rationale
   - Changes implemented and why
   - Problems solved and approaches that didn't work
   - The current task list
   
   Let me proceed with: [first open todo]
   
   [Begin work automatically on first open item]
   ```

2. Start working on the first open todo/question autonomously

**If "Modify":**
1. Ask which aspects to modify:
   ```
   What would you like to modify?
   
   1. Next steps / todo list
   2. Approach or decisions
   3. Add new context or information
   4. Other
   
   Please describe what needs to change.
   ```

2. Wait for user input
3. Update the working context accordingly
4. Summarize changes and confirm before proceeding

**If "Review [file]":**
1. Read the requested file
2. Show current contents
3. Highlight changes since session (if possible via git diff)
4. Ask if ready to continue

**If "Cancel":**
```
Session restoration cancelled.

The session file remains at: [path]

You can restore it later with:
/session-restore [path]
```

### 7. Context Injection

Once user confirms continuation, the full session context is now active in the conversation. This means:

1. **All decisions are remembered:** You won't ask about things already decided
2. **Failed attempts are avoided:** You won't suggest approaches that already failed
3. **Next steps are clear:** You proceed with the documented todo list
4. **Problems are understood:** You know what issues were encountered and solved

**Working mode:**
- Execute the open questions/next steps autonomously
- Reference previous decisions when making new ones
- Build upon the existing work without redoing completed tasks
- Make new commits following the established patterns

## Output
- Session context fully loaded and active in conversation
- User has clear understanding of previous work
- Next steps are validated and ready for execution
- Work continues seamlessly from where it left off
- Any environment changes are acknowledged and handled

## Success Criteria
- [ ] Session file successfully located (via argument or selection)
- [ ] YAML frontmatter parsed correctly
- [ ] All markdown sections extracted and structured
- [ ] Environment validation completed (files, commits, branch)
- [ ] Warnings presented to user (if any)
- [ ] Session summary displayed clearly and comprehensively
- [ ] User reviewed and confirmed readiness to continue
- [ ] Context injected into conversation (all decisions, changes, problems, next steps)
- [ ] First open todo/question identified and work begun (if user agreed)
- [ ] No repetition of already-completed work
- [ ] No suggestion of already-failed approaches

## Notes

### Session Selection Tips

When multiple sessions exist:
- **Most recent first:** Sessions sorted by date (newest first)
- **Filter by status:** Consider showing in-progress sessions first
- **Pattern matching:** Allow user to filter by keyword or tag
- **Branch correlation:** Highlight sessions related to current branch

### Handling Edge Cases

**Session file is corrupted or invalid:**
```
Error: Unable to parse session file.

The file may be corrupted or not in the expected format.

File: [path]
Issue: [parse error details]

Would you like to:
1. View the raw file contents?
2. Try another session?
3. Cancel?
```

**Session is from a different project:**
```
⚠️ Warning: Project Mismatch

This session appears to be from a different project:
- Session project: [project name from frontmatter]
- Current project: [current project name]

Are you sure you want to restore this session?
- Reply "Yes" to proceed anyway
- Reply "No" to select a different session
```

**Session is marked as "completed":**
```
Note: This session is marked as "completed".

This usually means the work was finished. Possible reasons to restore:
- Review what was done
- Build upon completed work
- Reference decisions for new work
- Resume related work

Do you want to restore this completed session?
```

### Best Practices for Users

**When to restore a session:**
- At the start of a new work session to continue previous work
- When returning to a paused or interrupted task
- When you need to recall decisions or context from previous work
- Before reviewing or refactoring completed work

**What to check after restoration:**
- Review the warnings about file/commit changes
- Validate that next steps are still relevant
- Check if any decisions need to be revisited
- Confirm the current branch is correct

### Integration with Session Save

This command is designed to work seamlessly with `/session-save`:

**Workflow:**
1. Work on a task in OpenCode
2. Use `/session-save` to capture context before ending session
3. Close OpenCode and do other work
4. Reopen OpenCode days/weeks later
5. Use `/session-restore` to load context and continue
6. Work continues without losing decisions or repeating work
7. Use `/session-save` again to update the session or save new milestones

**Session evolution:**
- Sessions can be restored, continued, and re-saved
- Each save creates a new timestamped file (preserves history)
- Old sessions serve as a project journal
- Sessions can be branched (restore one, work on variation, save as new)

### Future Enhancements

Potential improvements:
- **Session diff:** Show what changed between session save and current state
- **Partial restore:** Restore only specific sections (e.g., just decisions, not todos)
- **Session merge:** Combine multiple related sessions
- **Auto-suggest:** Automatically suggest relevant sessions based on current files/branch
- **Session templates:** Create sessions from templates for common workflows
- **Session search:** Full-text search across all saved sessions
- **Session export:** Export session to other formats (PDF, HTML, JSON)
- **Session sharing:** Easy sharing format for team members
