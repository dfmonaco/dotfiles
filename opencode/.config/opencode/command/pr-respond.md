---
description: Respond to PR review feedback with automated fixes
---

# PR Respond

## Objective
Respond to PR review feedback comprehensively. Analyze comments critically, implement agreed-upon fixes, run tests, commit changes, and respond to reviewers.

## Mode Selection

**IMMEDIATELY after command execution, ask the user to select a mode:**

```
Select operation mode:
1. Autonomous Mode - Automatically analyze, fix, and respond to all comments
2. Guided Mode - Analyze comments, provide recommendations, then fix issues step-by-step with user approval

Enter mode (1 or 2):
```

Wait for user input before proceeding.

### Autonomous Mode
Execute all steps automatically: analyze → fix → test → commit → respond

### Guided Mode
1. Analyze all comments and categorize by priority
2. Present recommended action plan with phases
3. Execute fixes one-by-one with user approval before each step
4. Commit and respond after all approved fixes are complete

## Core Principles

### Critical Thinking
- **Independent analysis:** Think critically about each review comment
- **Evaluate merit:** Determine if feedback improves code quality, correctness, or maintainability
- **Challenge when needed:** Respectfully disagree if feedback isn't appropriate
- **Consider trade-offs:** Weigh benefits vs costs of proposed changes

### Quality
- **Root cause fixes:** Address underlying issues, not just symptoms
- **Test coverage:** Ensure all changes are properly tested
- **Follow conventions:** Adhere to project patterns and standards (check AGENTS.md)
- **No regressions:** Verify fixes don't break existing functionality

### Communication
- **Be thorough:** Analyze all comments before implementing
- **Be respectful:** Thank reviewers and explain reasoning clearly
- **Be specific:** Reference file paths, line numbers, and commit hashes
- **Be transparent:** Document what was fixed and why

## Process

### 1. Identify PR Number
First, identify the PR number associated with the current branch:

1. Get the current branch name:
```bash
git branch --show-current
```

2. Find the PR number for this branch using:
```bash
gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
```

This will return the PR number for the current branch. Store this as the PR number to use throughout.

**Note:** If no PR is found for the current branch, inform the user and exit. The command requires an active PR for the current branch.

### 2. Fetch Review Comments
Use the following command to fetch all review comments from the PR (replace PR_NUMBER with the number identified above):
```bash
gh api repos/OWNER/REPO/pulls/PR_NUMBER/comments
```

Parse the JSON response to extract:
- `id` - Comment ID for later reference
- `line` - The line number being commented on
- `path` - The file path
- `body` - The review comment text
- `in_reply_to_id` - If this is a reply (usually null for original comments)

### 3. Analyze Each Comment
For each review comment:

**Think critically and independently:**
- Read the comment carefully and understand the concern
- Examine the code being commented on
- Evaluate if you **agree** with the feedback
  - Is this a real bug or just a style preference?
  - Does it improve code quality, correctness, or maintainability?
  - Are there trade-offs to consider?
- Explain your reasoning for agreeing or disagreeing
- If you disagree, explain why and suggest alternatives
- Categorize by severity: CRITICAL (blocks merge), IMPORTANT (should complete before merge), IMPROVEMENT (can address post-merge)

**Present your analysis:**

#### For Autonomous Mode:
Use a clear format like:
```
## Comment Analysis

### Comment #1: [Summary of concern]
- **Issue**: [What the reviewer pointed out]
- **Code Location**: path/to/file.ext:LINE
- **My Assessment**: AGREE/DISAGREE
- **Severity**: CRITICAL/IMPORTANT/IMPROVEMENT
- **Reasoning**: [Your detailed analysis]
- **Recommendation**: [What should be done]
```

#### For Guided Mode:
After analyzing all comments, present a comprehensive action plan:

```
## Recommended Action Plan:

Phase 1 - Critical Fixes (Block merge):
1. [Fix description] (path/to/file.ext:LINE)
2. [Fix description] (path/to/file.ext:LINE)
...

Phase 2 - Important Fixes (Should complete before merge):
5. [Fix description] (path/to/file.ext:LINE)
6. [Fix description] (path/to/file.ext:LINE)
...

Phase 3 - Improvements (Can address post-merge):
11. [Fix description] (path/to/file.ext:LINE)
12. [Fix description] (path/to/file.ext:LINE)
...

Comments I disagree with:
- Comment #X: [Summary] - [Reason for disagreement]

Do you approve this action plan? (yes/no/modify)
```

Wait for user approval before proceeding. If "modify", ask what changes they want.

### 4. Implement Fixes

#### For Autonomous Mode:
Implement all agreed-upon fixes automatically:
- Make the necessary code changes using the Edit tool
- Ensure changes follow project conventions (check AGENTS.md or similar files)
- Write/update tests if needed
- Verify the fix actually addresses the concern
- Proceed to step 5 (Run Tests)

#### For Guided Mode:
Execute fixes one-by-one with user approval:

For each task in the approved action plan:
1. Present the task:
   ```
   === Task N/M: [Fix description] ===
   File: path/to/file.ext:LINE
   Issue: [Brief explanation of the problem]
   Proposed fix: [How you will fix it]
   
   Proceed with this fix? (yes/skip/abort)
   ```

2. Wait for user input:
   - **yes**: Implement the fix and show the changes made
   - **skip**: Skip this task and move to the next
   - **abort**: Stop the entire process

3. After implementing each fix, show:
   ```
   ✅ Fixed: [Task description]
   Changes made:
   - [List of specific changes]
   
   Continue to next task? (yes/no)
   ```

4. Repeat until all tasks are processed or user aborts

5. After all fixes are complete, ask:
   ```
   All approved fixes completed. Ready to run tests and commit? (yes/no)
   ```

Wait for final approval before proceeding to step 5.

### 5. Run Tests
After all fixes are implemented:
```bash
# Use the project's test command (check AGENTS.md)
[test command from project]
```

Verify all tests pass before proceeding.

### 6. Commit Changes
Create a well-structured commit:
```bash
git add -A
git commit -m "fix: address PR review feedback - [brief summary]

- [Comment #1]: [what was fixed]
- [Comment #2]: [what was fixed]
- [Comment #3]: [what was fixed]
- Added/updated N tests
- All tests passing"
```

### 7. Push Changes
```bash
git push
```

### 8. Post Summary Comment
Use the following command to post a summary comment on the PR (using the PR number identified earlier):
```bash
gh pr comment PR_NUMBER --body "[your markdown formatted summary]"
```

Your summary should:
- Thank the reviewer
- List each comment with a ✅ or 💬 indicator
- Explain what was fixed or why you disagree
- Include test results
- Reference the commit hash

Example format:
```markdown
## Review Feedback Addressed

Thanks for the thorough review!

### ✅ Comment #1: [Issue]
**Fixed** - [Brief explanation of the fix]

### ✅ Comment #2: [Issue]  
**Fixed** - [Brief explanation of the fix]

### 💬 Comment #3: [Issue]
**Discussion** - [Why you disagree and proposed alternative]

### Testing
- [Test command ran]
- **All X tests passing** ✅

Commit: [hash]
```

### 9. Reply to Individual Comments
For each review comment you addressed, post a reply (using the PR number identified earlier):
```bash
gh api -X POST repos/OWNER/REPO/pulls/PR_NUMBER/comments \
  -f body="✅ Fixed in commit [hash] - [brief explanation]" \
  -F in_reply_to=[COMMENT_ID]
```

**Important:** Use `-F in_reply_to=` (uppercase F) for the integer comment ID, not `-f` (lowercase).

Example:
```bash
gh api -X POST repos/some_user/nvim-plugin-x/pulls/7/comments \
  -f body="✅ Fixed in commit 9dcbe5c - Added parameters (_, _) to the callback." \
  -F in_reply_to=2544084439
```

### 10. Resolve Conversations (Optional)
Note: Resolving review threads via API requires the thread ID (not comment ID) and proper permissions. This is typically done through the GitHub UI.

If you have the thread IDs, you can try:
```bash
gh api graphql -f query='
mutation {
  resolveReviewThread(input: {threadId: "THREAD_ID"}) {
    thread {
      id
      isResolved
    }
  }
}'
```

However, it's often easier to let the reviewer resolve threads after verifying fixes.

## Context Information

Current repo details:
```bash
!`git remote get-url origin`
```

Current branch:
```bash
!`git branch --show-current`
```

## Example Workflow

### Autonomous Mode
1. Identify PR: `gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'`
2. Fetch comments: `gh api repos/owner/repo/pulls/PR_NUMBER/comments`
3. Analyze all comments and present assessment
4. Implement all agreed-upon fixes automatically
5. Run tests: `[project test command]`
6. Commit: `git commit -m "fix: address PR review feedback"`
7. Push: `git push`
8. Post summary: `gh pr comment PR_NUMBER --body "..."`
9. Reply to each comment: `gh api -X POST repos/owner/repo/pulls/PR_NUMBER/comments ...`

### Guided Mode
1. Identify PR: `gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'`
2. Fetch comments: `gh api repos/owner/repo/pulls/PR_NUMBER/comments`
3. Analyze all comments and categorize by severity
4. Present comprehensive action plan with phases
5. Wait for user approval of action plan
6. For each task in approved plan:
   - Present task details
   - Wait for user approval (yes/skip/abort)
   - If approved, implement fix and show changes
   - Ask to continue to next task
7. After all tasks complete, ask for final approval
8. Run tests: `[project test command]`
9. Commit: `git commit -m "fix: address PR review feedback"`
10. Push: `git push`
11. Post summary: `gh pr comment PR_NUMBER --body "..."`
12. Reply to each comment: `gh api -X POST repos/owner/repo/pulls/PR_NUMBER/comments ...`

## Output
- Detailed analysis of each review comment
- Implemented fixes for agreed-upon issues
- All tests passing
- Commit with changes pushed to branch
- Summary comment posted to PR
- Individual replies to review comments

## Success Criteria
- [ ] User selected operation mode (Autonomous or Guided)
- [ ] PR number successfully identified from current branch
- [ ] All review comments fetched and analyzed
- [ ] Each comment has clear agree/disagree reasoning
- [ ] Comments categorized by severity (CRITICAL/IMPORTANT/IMPROVEMENT)
- [ ] **Guided Mode Only**: Action plan presented and approved by user
- [ ] **Guided Mode Only**: Each fix approved individually before implementation
- [ ] All agreed fixes implemented correctly
- [ ] All tests passing
- [ ] Changes committed and pushed
- [ ] Summary comment posted to PR
- [ ] Individual comments replied to
- [ ] Reviewer can easily verify all changes

## Notes

### Important Guidelines
1. **Mode selection first** - Always ask for mode immediately after command execution
2. **Be thorough** - Don't skip analysis even if you agree immediately
3. **Be honest** - If you disagree, explain why clearly
4. **Categorize properly** - Distinguish between CRITICAL, IMPORTANT, and IMPROVEMENT severity levels
5. **Guided mode patience** - Wait for user approval at each checkpoint before proceeding
6. **Test everything** - Always run tests after making changes
7. **One commit** - Make a single, well-structured commit with all fixes
8. **Clear communication** - Make it easy for reviewers to see what was done
9. **Reference specifics** - Always cite line numbers, commit hashes, and comment IDs

### Severity Guidelines
- **CRITICAL**: Bugs that cause errors, crashes, or incorrect behavior; security issues; data corruption
- **IMPORTANT**: Code quality issues, missing validations, performance problems, maintainability concerns
- **IMPROVEMENT**: Style preferences, minor optimizations, documentation, refactoring suggestions
