---
description: Respond to PR review feedback with automated fixes
---

# PR Respond

## Objective
Analyze PR review comments critically, implement fixes, run tests, commit changes, and reply to reviewers.

## Mode Selection

**Ask user immediately:**
```
Select mode:
1. Autonomous - Analyze, fix, and respond to all comments automatically
2. Guided - Present recommendations, then fix step-by-step with approval

Enter mode (1 or 2):
```

## Core Principles
- **Critical thinking:** Evaluate if feedback improves code; respectfully disagree when appropriate
- **Quality:** Fix root causes, not symptoms; follow project conventions
- **No regressions:** Test after each fix
- **Communication:** Be specific with file paths, line numbers, commit hashes

## Process

### 1. Identify PR
```bash
gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
```

If no PR found, inform user and exit.

### 2. Fetch Comments
```bash
gh api repos/OWNER/REPO/pulls/PR_NUMBER/comments
```

For large PRs, use pagination: `gh api --paginate repos/OWNER/REPO/pulls/PR_NUMBER/comments`

Extract: `id`, `path`, `line`, `body`, `in_reply_to_id`

### 3. Analyze Comments

For each comment:
1. Read the comment and examine the code
2. Evaluate if you **agree** (real issue vs style preference)
3. Categorize severity:
   - **CRITICAL:** Bugs, security issues, data corruption
   - **IMPORTANT:** Code quality, missing validations, maintainability
   - **IMPROVEMENT:** Style, minor optimizations, documentation

**Present analysis:**
```
### Comment #1: [Summary]
- **Location:** path/to/file:LINE
- **Assessment:** AGREE/DISAGREE
- **Severity:** CRITICAL/IMPORTANT/IMPROVEMENT
- **Reasoning:** [Your analysis]
- **Action:** [What to do]
```

**Guided Mode only:** After analysis, present action plan by phase and wait for approval:
```
Phase 1 - Critical: [list]
Phase 2 - Important: [list]
Phase 3 - Improvements: [list]
Comments I disagree with: [list with reasoning]

Approve this plan? (yes/no/modify)
```

### 4. Implement Fixes

**Autonomous Mode:** Implement all agreed fixes automatically.

**Guided Mode:** For each fix:
```
=== Task N/M: [Description] ===
File: path/to/file:LINE
Proposed fix: [Explanation]

Proceed? (yes/skip/abort)
```

For each fix (both modes):
1. Make the code change
2. Run tests to verify
3. Commit immediately (see step 6)
4. Push and reply to the comment (see step 7)

### 5. Test
After each fix:
```bash
[project test command]
```

If tests fail, fix and amend the commit before proceeding.

### 6. Commit
**One commit per fix:**
```bash
git add [files]
git commit -m "fix: [issue from Comment #N]

Addresses review comment #N: [summary]
- [change description]

Related to: path/to/file:LINE"
```

### 7. Push & Reply

Push after each fix:
```bash
git push
```

**Reply to individual comment:**
```bash
gh api -X POST repos/OWNER/REPO/pulls/PR_NUMBER/comments \
  -f body="✅ Fixed in commit [hash] - [explanation]" \
  -F in_reply_to=[COMMENT_ID]
```

**Post summary comment after all fixes:**
```bash
gh pr comment PR_NUMBER --body "## Review Feedback Addressed

Thanks for the review!

### ✅ Comment #1: [Issue]
Fixed in commit abc123 - [explanation]

### 💬 Comment #2: [Issue]
[Why you disagree / alternative approach]

### Testing
All tests passing ✅

Commits: abc123, def456"
```

## Output
- All comments analyzed with clear reasoning
- Fixes implemented and tested
- One commit per fix with descriptive messages
- Individual replies posted to each comment
- Summary comment posted to PR

## Success Criteria
- [ ] All comments fetched and analyzed
- [ ] Each comment has agree/disagree reasoning
- [ ] All agreed fixes implemented and tested
- [ ] One commit per fix, referencing comment number
- [ ] Each comment replied to
- [ ] Summary posted to PR
