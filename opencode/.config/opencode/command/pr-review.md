---
description: Address PR review feedback with automated fixes
---

# PR Review Feedback Handler

You are tasked with addressing PR review feedback comprehensively and automatically.

## Identify PR Number

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

## Your Tasks

### 1. Fetch Review Comments
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

### 2. Analyze Each Comment
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

**Present your analysis:**
Use a clear format like:
```
## Comment Analysis

### Comment #1: [Summary of concern]
- **Issue**: [What the reviewer pointed out]
- **Code Location**: path/to/file.ext:LINE
- **My Assessment**: AGREE/DISAGREE
- **Reasoning**: [Your detailed analysis]
- **Recommendation**: [What should be done]
```

### 3. Implement Fixes (If Agreed)
For each comment you agree with:
- Make the necessary code changes using the Edit tool
- Ensure changes follow project conventions (check AGENTS.md or similar files)
- Write/update tests if needed
- Verify the fix actually addresses the concern

### 4. Run Tests
After all fixes are implemented:
```bash
# Use the project's test command (check AGENTS.md)
[test command from project]
```

Verify all tests pass before proceeding.

### 5. Commit Changes
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

### 6. Push Changes
```bash
git push
```

### 7. Post Summary Comment
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

### 8. Reply to Individual Comments
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

### 9. Resolve Conversations (Optional)
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

## Important Guidelines

1. **Be thorough** - Don't skip analysis even if you agree immediately
2. **Be honest** - If you disagree, explain why clearly
3. **Test everything** - Always run tests after making changes
4. **One commit** - Make a single, well-structured commit with all fixes
5. **Clear communication** - Make it easy for reviewers to see what was done
6. **Reference specifics** - Always cite line numbers, commit hashes, and comment IDs

## Repository Context
Current repo details:
```bash
!`git remote get-url origin`
```

Current branch:
```bash
!`git branch --show-current`
```

## Example Workflow

1. Identify PR: `gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'`
2. Fetch comments: `gh api repos/owner/repo/pulls/PR_NUMBER/comments`
3. Analyze all comments and present your assessment
4. Wait for user confirmation before proceeding (optional)
5. Implement fixes for agreed-upon issues
6. Run tests: `[project test command]`
7. Commit: `git commit -m "fix: address PR review feedback"`
8. Push: `git push`
9. Post summary: `gh pr comment PR_NUMBER --body "..."`
10. Reply to each comment: `gh api -X POST repos/owner/repo/pulls/PR_NUMBER/comments ...`

## Success Criteria
✅ PR number successfully identified from current branch
✅ All review comments fetched and analyzed
✅ Each comment has clear agree/disagree reasoning
✅ All agreed fixes implemented correctly
✅ All tests passing
✅ Changes committed and pushed
✅ Summary comment posted to PR
✅ Individual comments replied to
✅ Reviewer can easily verify all changes
