---
description: Commit modified files to git
---

# Git Commit

## Objective
Commit all modified files to git with a descriptive, conventional commit message following best practices.

## Input
Optional `$ARGUMENTS`:
- Empty: Commit all modified files with generated message
- Message text: Use provided message (must follow conventional commit format)

## Process

### 1. Check Status
Check the current git status for modified files:
```bash
git status --porcelain
```

### 2. Stage and Commit
If there are modified files:
- Add all changes to staging
- Create a descriptive commit message that:
  - Starts with a conventional commit prefix (feat, fix, docs, refactor, test, etc.)
  - Is concise and clear
  - Explains what changed and why

## Output
A single git commit with all staged changes and a well-crafted commit message.

## Success Criteria
- [ ] All modified files are committed
- [ ] Commit message follows conventional commit format
- [ ] Commit message clearly explains the changes

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
