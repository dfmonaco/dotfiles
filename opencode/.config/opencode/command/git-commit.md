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

## Process

### 1. Check Status
Check the current git status for modified files:
```bash
git status --porcelain
```

### 2. Analyze Changes
Review all modified files to determine if changes should be split into multiple commits:
- Group related files by functionality, feature, or concern
- Consider separate commits for:
  - Different features or bug fixes
  - Configuration changes vs code changes
  - Documentation updates vs implementation
  - Different subsystems or modules
  - Refactoring vs new functionality

### 3. Create Atomic Commits
For each logical group of changes:
- Stage only the files related to that specific change
- Create a descriptive commit message that:
  - Starts with a conventional commit prefix (feat, fix, docs, refactor, test, etc.)
  - Is concise and clear
  - Explains what changed and why
- Commit the staged changes
- Repeat for remaining groups

**When to use a single commit:**
- All changes relate to the same feature/fix/task
- Changes are tightly coupled and don't make sense separately
- Splitting would create incomplete or non-functional states

**When to use multiple commits:**
- Changes span unrelated functionality
- Different types of changes (e.g., refactor + new feature)
- Changes to different subsystems that are independently meaningful
- Mix of fixes and features

## Output
One or more git commits, each containing a cohesive set of related changes with well-crafted commit messages.

## Success Criteria
- [ ] All modified files are committed
- [ ] Each commit contains a cohesive, atomic set of changes
- [ ] Commit messages follow conventional commit format
- [ ] Commit messages clearly explain what and why
- [ ] Commits are logically organized (multiple commits when appropriate)

## Notes

### Conventional Commit Format
```
<type>(<scope>): <subject>

<body>
```

**Common types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Maintenance tasks

**Examples:**
```
feat(auth): add JWT token validation
fix(api): resolve timeout on large payloads
docs(readme): update installation instructions
refactor(database): extract connection pool logic
```

### Best Practices
- **Be specific:** "fix login bug" → "fix: resolve session timeout on mobile"
- **Explain why:** Include context when the change isn't obvious
- **Keep subject under 72 chars:** First line should be scannable
- **Use imperative mood:** "add feature" not "added feature"
- **Reference issues:** Include "Closes #123" if applicable
- **Atomic commits:** Each commit should represent one logical change
- **Commit order:** Consider dependencies; commit foundational changes before dependent ones
