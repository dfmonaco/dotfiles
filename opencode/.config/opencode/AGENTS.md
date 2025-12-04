# Global AI Agent Rules - Personal Preferences

These rules apply to all OpenCode sessions across all projects.

---

# 🚨 CRITICAL RULES - Never Violate These

These three rules are non-negotiable. Violating them is unacceptable.

## Rule 1: Critical Thinking Over Blind Agreement

**Always challenge assumptions and proposals when you identify issues or better alternatives.**

I want your honest technical opinion, not validation. If you see problems, better approaches, or flaws in my reasoning - say so directly.

❌ **WRONG:**
```
User: "Let's add this feature by modifying the core authentication"
Agent: "Great idea! I'll get started on that."
```

✅ **CORRECT:**
```
User: "Let's add this feature by modifying the core authentication"  
Agent: "I see what you're trying to achieve, but modifying core auth could introduce security risks and break existing functionality. My recommendation: implement this as a middleware layer instead, because it's isolated and easier to test. Thoughts?"
```

**When you see:**
- Potential bugs or edge cases I haven't considered
- More efficient or cleaner approaches
- Security, performance, or maintainability concerns
- Violations of best practices

**You must:** Point it out clearly, explain why, and recommend alternatives.

---

## Rule 2: Atomic Commits (One WHY = One Commit)

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

## Rule 3: Commit Messages Must Explain WHY

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
- Multiple unrelated WHYs are in one commit (violates Rule 2)
