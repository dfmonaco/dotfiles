---
description: Plan a refactoring by creating an implementation-ready refactor document
---

# Refactor Plan

## Objective
Create a refactor document that enables implementation via `/tasks/implement`.

## Role
Act as a Senior Software Engineer. Be explicit, unambiguous, and implementation-focused.

## Process

### 1. Discovery
Ask the user to describe the refactoring they want to do:
- What area/code do you want to refactor?
- What's the problem with the current approach?
- What improvement are you hoping to achieve?

### 2. Clarification
Analyze the codebase and ask clarifying questions about:
- Scope (which files/modules are affected?)
- Motivation (maintainability? performance? readability?)
- Constraints (backward compatibility? API stability?)
- Risk (what could break?)

Provide proposed answers based on code analysis. User can reply "Agree" or correct specific ones.

### 3. Draft Refactor Document
Generate the document with these sections:

**1. Overview** - Title, scope, estimated effort, risk level

**2. Motivation** - Why this refactoring is needed, current problems

**3. Current State** - How the code is structured now, specific files:lines

**4. Target State** - Desired structure, how it improves the codebase

**5. Refactoring Requirements** - Numbered (RR-1, RR-2...), specific and testable

**6. Testing Strategy** - Ensure no regressions, test refactored code

**7. Acceptance Criteria**
- [ ] All existing tests pass
- [ ] No breaking changes to public APIs
- [ ] New tests added for refactored code
- [ ] Code complexity reduced

### 4. Git Branch Setup
```bash
# Detect default branch
DEFAULT_BRANCH=$(
  git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || \
  git config --get init.defaultBranch 2>/dev/null || \
  echo "main"
)

git checkout "$DEFAULT_BRANCH"
git pull origin "$DEFAULT_BRANCH" 2>/dev/null || true
git checkout -b refactor/[refactor-name]
```

### 5. Generate Folder ID
```bash
TODAY=$(date +%Y%m%d)
EXISTING=$(find ./docs/tasks -maxdepth 1 -type d -name "${TODAY}-*" 2>/dev/null | wc -l)
COUNTER=$(printf "%03d" $((EXISTING + 1)))
FOLDER_ID="${TODAY}-${COUNTER}-[refactor-name]"
```

### 6. Ensure tasks.json Exists
```bash
mkdir -p ./docs/tasks
if [ ! -f ./docs/tasks/tasks.json ]; then
  echo '{"tasks": []}' > ./docs/tasks/tasks.json
  git add ./docs/tasks/tasks.json
fi
```

### 7. Update tasks.json
Add entry:
```json
{
  "id": "[FOLDER_ID]",
  "type": "refactor",
  "status": "pending",
  "priority": "[high|medium|low based on impact]",
  "created": "[ISO 8601 timestamp]",
  "branch": "refactor/[refactor-name]",
  "description": "[brief description]"
}
```

### 8. Save & Commit
```bash
mkdir -p "./docs/tasks/${FOLDER_ID}"
```

Save to: `./docs/tasks/[FOLDER_ID]/refactor-[refactor-name].md`

```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add refactor plan for [refactor-name]"
```

## Output
- Branch: `refactor/[refactor-name]`
- Document: `./docs/tasks/[FOLDER_ID]/refactor-[refactor-name].md`
- tasks.json updated
- Ready for `/tasks/implement`
