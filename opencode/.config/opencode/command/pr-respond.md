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

**⚠️ CRITICAL: Data Truncation Risk**

GitHub API responses can be truncated when there are many comments. **YOU MUST VALIDATE COMPLETENESS BEFORE PROCEEDING.**

#### Step 2.1: Validate Comment Count

First, count the total number of comments and verify completeness:

```bash
# 1. Get comment count from API
COMMENT_COUNT=$(gh api repos/OWNER/REPO/pulls/PR_NUMBER/comments | jq 'length')
echo "📊 API returned $COMMENT_COUNT review comments"

# 2. Check for truncation warning in bash output
# If you see "(Output was truncated due to length limit)" - DATA IS INCOMPLETE!

# 3. Get comment summaries to verify completeness
echo ""
echo "📝 Review comment summaries:"
gh api repos/OWNER/REPO/pulls/PR_NUMBER/comments | jq -r '.[] | "Comment #\(.id) - \(.path):\(.line) - \(.body[0:80])..."'
```

**⚠️ TRUNCATION CHECK:**
- If bash output shows `(Output was truncated due to length limit)` → **STOP AND USE ALTERNATIVE METHOD**
- If the summaries list looks incomplete or cut off → **STOP AND USE ALTERNATIVE METHOD**
- If you're unsure about completeness → **ASK USER TO VERIFY**

#### Step 2.2: Alternative Method for Large Comment Threads

If data appears truncated, use paginated fetching:

```bash
# Fetch with pagination (100 comments per page)
gh api --paginate repos/OWNER/REPO/pulls/PR_NUMBER/comments > /tmp/pr_comments_full.json

# Count total comments from paginated response
TOTAL_COMMENTS=$(jq 'length' /tmp/pr_comments_full.json)
echo "📊 Total comments (paginated): $TOTAL_COMMENTS"

# Verify file is complete (check if it ends with valid JSON)
tail -1 /tmp/pr_comments_full.json | jq . > /dev/null && echo "✅ JSON is valid and complete" || echo "❌ JSON is truncated or invalid"
```

#### Step 2.3: User Verification

**BEFORE PROCEEDING, ALWAYS ASK:**

```
Found $COMMENT_COUNT review comments on PR #$PR_NUMBER

Please verify this matches what you see on GitHub:
- Open: https://github.com/OWNER/REPO/pull/PR_NUMBER/files
- Check the "Conversations" tab for total comment count

Does the count match? (yes/no/unsure)
```

**Wait for user confirmation before proceeding.** If user says "no" or "unsure", use the alternative paginated method.

#### Step 2.4: Parse Comments

Once data completeness is verified, use the following command to fetch all review comments from the PR:

```bash
gh api repos/OWNER/REPO/pulls/PR_NUMBER/comments
# OR if using paginated method:
cat /tmp/pr_comments_full.json
```

Parse the JSON response to extract:
- `id` - Comment ID for later reference
- `line` - The line number being commented on
- `path` - The file path
- `body` - The review comment text
- `in_reply_to_id` - If this is a reply (usually null for original comments)

**⚠️ VALIDATION CHECKPOINT:**
After parsing, verify:
- Total comments parsed matches the count from Step 2.1
- All comment IDs are present in your analysis
- No comment bodies are incomplete or cut off mid-sentence

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
- **Create one git commit per fix** (see step 6 for commit format)
- Run tests after each commit to ensure no regressions
- **Push and reply to each comment** (see step 9 for reply format):
  - Push the commit to remote: `git push`
  - Reply to the specific comment explaining what was fixed and how
- Proceed to step 5 (Run Tests) after all fixes are committed

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
   - **skip**: Skip this task and reply to the comment explaining why we're skipping it (see step 9 for reply format)
   - **abort**: Stop the entire process

3. After implementing each fix, show:
   ```
   ✅ Fixed: [Task description]
   Changes made:
   - [List of specific changes]
   ```

4. **Commit the fix immediately** (see step 6 for commit format):
   ```
   Create commit for this fix? (yes/skip)
   ```

   If yes, create one git commit for this specific fix, then run tests to verify.

5. **Reply to the comment** (see step 9 for reply format):
   - Push the commit to remote: `git push`
   - Reply to the specific comment explaining what was fixed and how

6. Repeat until all tasks are processed or user aborts

6. After all fixes are complete:
   ```
   All approved fixes completed and committed. Ready to push? (yes/no)
   ```

Wait for final approval before proceeding to step 7 (Push Changes).

### 5. Run Tests
After each fix is implemented and committed:
```bash
# Use the project's test command (check AGENTS.md)
[test command from project]
```

Verify all tests pass before proceeding to the next fix. If tests fail, fix the issue and amend the commit.

### 6. Commit Changes
**IMPORTANT: Create one git commit per fixed issue/comment.**

For each fix implemented, create a focused commit:
```bash
git add [files related to this specific fix]
git commit -m "fix: [specific issue from Comment #N] - [brief summary]

Addresses review comment #N: [comment summary]
- [what was changed in this file]
- [what was changed in that file]

Related to: [file paths and line numbers]"
```

**Commit message guidelines:**
- Reference the specific comment number being addressed
- Keep the subject line focused on the single issue being fixed
- Include file paths and line numbers in the body
- Use conventional commit format (fix/refactor/test/etc.)

**Example commits:**
```bash
# Commit 1 - Fix for comment #1
git commit -m "fix: correct user → self bug in user model

Addresses review comment #1: undefined method error
- Changed user.something to self.something in user.rb:357

Related to: app/models/user.rb:357"

# Commit 2 - Fix for comment #2
git commit -m "fix: add missing && operator in auth policy

Addresses review comment #2: logic error in authorization
- Added && between conditions in auth_policy.rb:88-89

Related to: app/policies/auth_policy.rb:88-89"
```

### 7. Push Changes
After all fixes are committed:
```bash
git push
```

This will push all individual commits for each fix to the remote branch.

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
- Reference the commit hash(es) - one per fix

Example format:
```markdown
## Review Feedback Addressed

Thanks for the thorough review!

### ✅ Comment #1: [Issue]
**Fixed in commit abc123** - [Brief explanation of the fix]

### ✅ Comment #2: [Issue]  
**Fixed in commit def456** - [Brief explanation of the fix]

### 💬 Comment #3: [Issue]
**Discussion** - [Why you disagree and proposed alternative]

### Testing
- [Test command ran]
- **All X tests passing** ✅

Commits: abc123, def456, ghi789
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
2. **Validate comment count and check for truncation** (Step 2.1-2.3)
3. Fetch comments: `gh api repos/owner/repo/pulls/PR_NUMBER/comments` (or paginated if needed)
4. **Wait for user confirmation that count matches GitHub UI**
5. Analyze all comments and present assessment
6. For each agreed-upon fix:
   - Implement the fix
   - Run tests to verify
   - Create one commit for this specific fix
   - Push commit and reply to the specific comment
7. Post summary: `gh pr comment PR_NUMBER --body "..."`
8. Reply to each comment: `gh api -X POST repos/owner/repo/pulls/PR_NUMBER/comments ...`

### Guided Mode
1. Identify PR: `gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'`
2. **Validate comment count and check for truncation** (Step 2.1-2.3)
3. Fetch comments: `gh api repos/owner/repo/pulls/PR_NUMBER/comments` (or paginated if needed)
4. **Wait for user confirmation that count matches GitHub UI**
5. Analyze all comments and categorize by severity
6. Present comprehensive action plan with phases
7. Wait for user approval of action plan
8. For each task in approved plan:
   - Present task details
   - Wait for user approval (yes/skip/abort)
   - If approved: implement fix, show changes, run tests, create commit, push and reply to comment
   - If skipped: reply to comment explaining why we're skipping it
   - Ask to continue to next task
9. After all tasks complete, ask for final approval to push remaining commits
10. Push any remaining commits: `git push`
11. Post summary: `gh pr comment PR_NUMBER --body "..."`
12. Reply to each comment: `gh api -X POST repos/owner/repo/pulls/PR_NUMBER/comments ...`

## Output
- Detailed analysis of each review comment
- Implemented fixes for agreed-upon issues
- All tests passing
- **One commit per fix** with changes pushed to branch
- Summary comment posted to PR with all commit hashes
- Individual replies to review comments

## Success Criteria
- [ ] User selected operation mode (Autonomous or Guided)
- [ ] PR number successfully identified from current branch
- [ ] **Comment data completeness validated (no truncation)**
- [ ] **User confirmed comment count matches GitHub UI**
- [ ] All review comments fetched and analyzed
- [ ] Each comment has clear agree/disagree reasoning
- [ ] Comments categorized by severity (CRITICAL/IMPORTANT/IMPROVEMENT)
- [ ] **Guided Mode Only**: Action plan presented and approved by user
- [ ] **Guided Mode Only**: Each fix approved individually before implementation
- [ ] All agreed fixes implemented correctly
- [ ] All tests passing after each fix
- [ ] **One commit created per fixed issue/comment**
- [ ] Each commit message references the specific comment addressed
- [ ] **Each fixed comment replied to with explanation of fix**
- [ ] **Each skipped comment replied to with explanation of skip**
- [ ] Changes committed and pushed
- [ ] Summary comment posted to PR
- [ ] Individual comments replied to
- [ ] Reviewer can easily verify all changes

## Notes

### Important Guidelines
1. **Mode selection first** - Always ask for mode immediately after command execution
2. **Validate data completeness** - ALWAYS check for truncation before processing comments (see Step 2.1-2.3)
3. **Be thorough** - Don't skip analysis even if you agree immediately
4. **Be honest** - If you disagree, explain why clearly
5. **Categorize properly** - Distinguish between CRITICAL, IMPORTANT, and IMPROVEMENT severity levels
6. **Guided mode patience** - Wait for user approval at each checkpoint before proceeding
7. **Test everything** - Always run tests after making changes
8. **One commit per fix** - Create a separate, focused commit for each issue/comment addressed
9. **Commit message quality** - Each commit must reference the specific comment number and issue
10. **Reply to each comment** - After fixing or skipping, reply to the specific comment explaining what was done
11. **Clear communication** - Make it easy for reviewers to see what was done
12. **Reference specifics** - Always cite line numbers, commit hashes, and comment IDs

### Truncation Risk Management

**⚠️ CRITICAL: API responses can be truncated with large comment threads.**

**Always validate before processing:**
1. Check bash output for `(Output was truncated due to length limit)` warning
2. Count comments and verify with user
3. Use paginated fetching (`--paginate`) for large responses
4. Validate JSON completeness (proper closing brackets, valid parse)
5. Verify parsed comment count matches API count

**Signs of truncation:**
- Bash output shows truncation warning
- Comment summaries cut off mid-list
- JSON parsing errors
- Comment bodies end abruptly
- Missing expected comments user mentions

**If truncation detected:**
1. STOP processing immediately
2. Switch to paginated method (Step 2.2)
3. Save to temp file for validation
4. Re-verify completeness before continuing

### Severity Guidelines
- **CRITICAL**: Bugs that cause errors, crashes, or incorrect behavior; security issues; data corruption
- **IMPORTANT**: Code quality issues, missing validations, performance problems, maintainability concerns
- **IMPROVEMENT**: Style preferences, minor optimizations, documentation, refactoring suggestions
