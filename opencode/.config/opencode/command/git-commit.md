---
description: Commit modified files to git
---

# Git Commit

## Objective
Commit all modified files to git with descriptive, conventional commit messages following best practices. Create multiple atomic commits when changes span different concerns or functionality.

## Input
Optional `$ARGUMENTS`:
- Empty: Analyze changes and create one or more commits with generated messages
- Message text: Use provided message for a single commit (must follow conventional commit format)

---

# 🚨 CRITICAL COMMIT RULES

These rules are non-negotiable. Violating them is unacceptable.

## Rule 1: Atomic Commits (One WHY = One Commit)

**Every commit must contain changes that belong together and serve a single purpose.**

**WHY THIS MATTERS:**
- Each commit can be reverted independently without side effects
- Project history tells a clear story of how features were built
- Easier to understand implementation progress
- Easier to debug (git bisect, blame, etc.)

❌ **WRONG - Multiple unrelated changes:**
```
commit: "add user validation and fix typo in README and update deps"
- src/user.js: add email validation
- README.md: fix typo
- package.json: update 3 dependencies
```
This has 3 different WHYs → should be 3 commits

✅ **CORRECT - Atomic commits:**
```
commit 1: "add email validation to prevent duplicate accounts"
- src/user.js: add email validation

commit 2: "fix typo in installation instructions"  
- README.md: fix typo

commit 3: "update dependencies to fix security vulnerabilities"
- package.json: update vulnerable deps
```

**When to SPLIT commits:**
- Different WHYs = different commits
- Feature + unrelated bug fix → 2 commits
- Multiple unrelated fixes → separate commits
- Large feature → break into logical steps with clear purpose for each

**When to COMBINE into one commit:**
- Same WHY = one commit
- Fix + test for that fix → one commit (WHY: fix the bug)
- Feature + documentation for that feature → one commit
- Refactoring that directly enables the feature → one commit

**BEFORE committing, I will:**
1. Analyze all current changes
2. Group changes by their WHY
3. Show you my proposed commit breakdown:
   ```
   I see 3 logical groups of changes:
   
   Commit 1: "add email validation to prevent duplicates"
   - user.js
   - user.test.js
   
   Commit 2: "refactor validation helpers for reusability"
   - validation.js
   
   Commit 3: "update docs to reflect new validation"
   - README.md
   
   Should I proceed with these 3 atomic commits?
   ```
4. Wait for your approval

---

## Rule 2: Commit Messages Must Explain WHY

**The code diff shows WHAT changed. The commit message must explain WHY the change was necessary.**

❌ **WRONG - Describes WHAT:**
- "add validation to user model"
- "update authentication logic"
- "refactor database queries"
- "fix bug in payment service"

✅ **CORRECT - Explains WHY:**
- "add validation to prevent duplicate emails in database"
- "fix authentication to handle expired tokens correctly"
- "refactor queries to improve page load performance"
- "fix payment service to handle concurrent transactions"

**Every commit message must answer:**
- Why was this change necessary?
- What problem does it solve?
- What was the motivation?

**Before committing, I will:**
1. Show you the proposed commit message emphasizing the WHY
2. List all files to be included
3. Explain the reasoning if multiple commits
4. Wait for your approval

**You should reject my commit if:**
- The message doesn't clearly explain WHY
- The message is generic or vague
- Multiple unrelated WHYs are in one commit (violates Rule 1)

---

# Process

## 1. Check Status
Check the current git status for modified files:
```bash
git status --porcelain
```

## 2. Analyze Changes
Review all modified files to determine if changes should be split into multiple commits:
- Group related files by functionality, feature, or concern
- Consider separate commits for:
  - Different features or bug fixes
  - Configuration changes vs code changes
  - Documentation updates vs implementation
  - Different subsystems or modules
  - Refactoring vs new functionality

## 3. Create Atomic Commits
For each logical group of changes:
- Stage only the files related to that specific change
- Create a descriptive commit message that:
  - Starts with a conventional commit prefix (feat, fix, docs, refactor, test, etc.)
  - Focuses on the WHY or the problem being solved
  - Is concise and clear
- Commit the staged changes
- Repeat for remaining groups

## Output
One or more git commits, each containing a cohesive set of related changes with well-crafted commit messages.

## Success Criteria
- [ ] All modified files are committed
- [ ] Each commit contains a cohesive, atomic set of changes (one WHY per commit)
- [ ] Commit messages follow conventional commit format
- [ ] Commit messages clearly explain WHY (not just WHAT)
- [ ] Commits are logically organized (multiple commits when appropriate)

---

# Commit Message Format

Use conventional commits format:
```
<type>(<scope>): <subject>

<body>

<footer>
```

## Subject Line (required)
- **Focus on the WHY** or the problem being solved
- Use imperative mood ("add" not "added" or "adds")
- Don't capitalize first letter
- Max 50 characters
- Be specific and meaningful

## Body (use when subject alone doesn't explain WHY)
- Explain the motivation and reasoning
- Describe the problem being solved
- Explain why this approach was chosen
- Include context that won't be obvious from code
- Wrap at 72 characters

## Footer (optional)
- Reference issues: `Fixes #123`, `Closes #456`
- Breaking changes: `BREAKING CHANGE: description`

## Types
- `feat`: New feature for the user
- `fix`: Bug fix for the user
- `docs`: Documentation changes
- `refactor`: Code restructuring without behavior change
- `perf`: Performance improvement
- `test`: Adding or updating tests
- `chore`: Maintenance (dependencies, tooling)
- `style`: Formatting only (no logic change)

## Example
```
fix(api): return 422 for missing required parameters

API was returning 500 errors for missing parameters, making it
impossible for clients to distinguish between client errors and
server errors. Now returns proper 422 with clear error messages.

Fixes #789
```

---

# Best Practices

- **Be specific:** "fix login bug" → "fix: resolve session timeout on mobile"
- **Explain why:** Include context when the change isn't obvious
- **Use imperative mood:** "add feature" not "added feature"
- **Reference issues:** Include "Closes #123" if applicable
- **Commit order:** Consider dependencies; commit foundational changes before dependent ones
