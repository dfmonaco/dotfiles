---
description: Commit modified files to git
---

# Git Commit

## Objective
Commit all modified files to git with a descriptive, conventional commit message following best practices.

## Process

### 1. Check Status
Check the current git status for modified files:
```bash
!`git status --porcelain`
```

### 2. Stage and Commit
If there are modified files:
- Add all changes to staging
- Create a descriptive commit message that:
  - Starts with a verb (e.g., Add, Fix, Update, Refactor, Remove)
  - Is concise and clear
  - Explains what changed and why

## Output
A single git commit with all staged changes and a well-crafted commit message.

## Success Criteria
- [ ] All modified files are committed
- [ ] Commit message follows conventional commit format
- [ ] Commit message clearly explains the changes
