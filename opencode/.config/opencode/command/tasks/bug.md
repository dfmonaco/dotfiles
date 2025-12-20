---
description: Plan a bug fix by creating an implementation-ready bug analysis document
---

# Bug Plan

## Objective
Create a bug analysis document that enables implementation via `/tasks/implement`.

## Role
Act as a Senior Software Engineer. Be explicit, unambiguous, and implementation-focused.

## Process

### 1. Discovery
Ask the user to describe the bug:
- Expected vs actual behavior
- Reproduction steps
- Associated GitHub issue (if any)

### 2. Clarification
Analyze and ask clarifying questions about:
- Reproduction (consistent? exact steps?)
- Scope (users/features/environments affected)
- Severity (Critical/High/Medium/Low)
- Context (when started? recent changes? error logs?)

Provide proposed answers based on code analysis. User can reply "Agree" or correct specific ones.

### 3. Draft Bug Analysis
Generate the document with these sections:

**1. Overview** - Title, severity, affected scope, date

**2. Problem** - What's broken, expected vs actual, user impact

**3. Reproduction Steps**
```
1. [Action]
2. [Action]
3. [Expected result]
4. [Actual result]
```

**4. Root Cause** - Hypothesis, relevant code locations (files:lines), technical explanation

**5. Proposed Solution** - Approach, files to modify, risks

**6. Fix Requirements** - Numbered (FR-1, FR-2...), specific and testable

**7. Testing Strategy** - Unit tests, regression tests, manual verification

**8. Acceptance Criteria**
- [ ] Reproduction steps no longer produce error
- [ ] All tests pass
- [ ] Regression test added

### 4. Git Branch Setup
```bash
git checkout main && git pull origin main
git checkout -b fix/[bug-name]
```

### 5. Generate Folder ID
```bash
TODAY=$(date +%Y%m%d)
EXISTING=$(find ./docs/tasks -maxdepth 1 -type d -name "${TODAY}-*" 2>/dev/null | wc -l)
COUNTER=$(printf "%03d" $((EXISTING + 1)))
FOLDER_ID="${TODAY}-${COUNTER}-[bug-name]"
```

### 6. Update tasks.json
Add entry:
```json
{
  "id": "[FOLDER_ID]",
  "type": "bug",
  "status": "pending",
  "priority": "[high|medium|low based on severity/impact]",
  "created": "[ISO 8601 timestamp]",
  "branch": "fix/[bug-name]",
  "description": "[brief description]"
}
```

### 7. Save & Commit
Save to: `./docs/tasks/[FOLDER_ID]/bug-[bug-name].md`

```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add bug analysis for [bug-name]"
```

## Output
- Branch: `fix/[bug-name]`
- Document: `./docs/tasks/[FOLDER_ID]/bug-[bug-name].md`
- tasks.json updated
- Ready for `/tasks/implement`
