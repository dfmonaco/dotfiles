---
description: Respond to PR review feedback with automated fixes
---

# PR Respond

## Objective
Respond to PR review feedback comprehensively and automatically. Analyze comments critically, implement agreed-upon fixes, run tests, commit changes, and respond to reviewers.

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

### 4. Implement Fixes (If Agreed)
For each comment you agree with:
- Make the necessary code changes using the Edit tool
- Ensure changes follow project conventions (check AGENTS.md or similar files)
- Write/update tests if needed
- Verify the fix actually addresses the concern

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

## Output
- Detailed analysis of each review comment
- Implemented fixes for agreed-upon issues
- All tests passing
- Commit with changes pushed to branch
- Summary comment posted to PR
- Individual replies to review comments

## Success Criteria
- [ ] PR number successfully identified from current branch
- [ ] All review comments fetched and analyzed
- [ ] Each comment has clear agree/disagree reasoning
- [ ] All agreed fixes implemented correctly
- [ ] All tests passing
- [ ] Changes committed and pushed
- [ ] Summary comment posted to PR
- [ ] Individual comments replied to
- [ ] Reviewer can easily verify all changes

## Notes

### Important Guidelines
1. **Be thorough** - Don't skip analysis even if you agree immediately
2. **Be honest** - If you disagree, explain why clearly
3. **Test everything** - Always run tests after making changes
4. **One commit** - Make a single, well-structured commit with all fixes
5. **Clear communication** - Make it easy for reviewers to see what was done
6. **Reference specifics** - Always cite line numbers, commit hashes, and comment IDs
