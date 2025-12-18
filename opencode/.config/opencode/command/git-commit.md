---
description: Commit modified files to git
agent: build
model: github-copilot/gpt-4.1
subtask: true
---

# Git Commit

Commit modified files with atomic, conventional commits that explain WHY changes were made.

## Input
Optional `$ARGUMENTS`:
- Empty: Analyze changes and create one or more commits with generated messages
- Message text: Use provided message for a single commit

---

# 🚨 CRITICAL RULES

## Rule 0: Execute Commits Directly

**When invoked, execute commits immediately without asking for permission or review.**

Once this command is called, follow all rules below and create the commits directly. The user has already given permission by invoking this command.

---

## Rule 1: Atomic Commits (One WHY = One Commit)

**Every commit must serve a single purpose. Different WHYs = different commits.**

**Split when:**
- Multiple unrelated features/fixes
- Config changes vs code changes
- Different subsystems

**Combine when:**
- Same purpose (feature + its tests, fix + its docs)

**Before committing:**
1. Group changes by their WHY
2. Create commits directly following all rules (no approval needed)

❌ WRONG: `"add validation and fix README typo and update deps"`  
✅ CORRECT: 3 separate commits

---

## Rule 2: Explain WHY, Not WHAT

**The diff shows WHAT. The message explains WHY.**

❌ WRONG: `"add validation to user model"`  
✅ CORRECT: `"add validation to prevent duplicate emails"`

Every message must answer: Why was this necessary? What problem does it solve?

---

# Commit Message Format

```
<type>(<scope>): <subject explaining WHY>

[optional body with more context]

[optional footer: Fixes #123]
```

## Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `refactor`: Restructuring (no behavior change)
- `perf`: Performance improvement
- `test`: Tests
- `chore`: Maintenance (deps, tooling)

## Rules
- Focus on WHY/problem solved
- Imperative mood ("add" not "added")
- Lowercase, max 50 chars
- Body when subject doesn't explain WHY fully
