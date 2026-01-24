---
description: Plan a feature by creating an implementation-ready feature document
---

# Feature Plan

## Objective
Create a feature document that enables implementation via `/tasks/implement` using an interface-driven, outside-in approach.

## Philosophy
This document defines **what** to build and **why** it matters — never **how** to build it.

- Keep requirements outcome-focused and testable
- Do NOT prescribe implementations, libraries, patterns, or specific code approaches
- Technical context (constraints, considerations) informs the implementor but does not bind them
- Implementation decisions are made at implementation time, with real feedback loops

## Role
Act as a Senior Product Manager. Be explicit, unambiguous, and implementation-focused.

## Process

### 1. Discovery
Ask the user to describe the feature:
- What do you want to build?
- Why is it needed? (problem/motivation)
- Who will use it?

### 2. Clarification
Analyze and ask clarifying questions about:
- Scope (what's in/out?)
- Users & use cases
- Constraints (technical, UX, performance)
- Success criteria

Provide proposed answers based on code analysis. User can reply "Agree" or correct specific ones.

### 3. Draft Feature Document
Generate the document with these sections:

**1. Overview** - Feature name, problem statement, solution summary

**2. User Stories** - As a [role], I want [action], so that [benefit]

**3. Primary Interface & Flows (mandatory)**
- Primary interface: `ui | cli | api | config | job | library`
- Entry point(s) and user/consumer flow (steps + expected outcomes)
- State matrix (mandatory): idle/ready, loading/in-progress, success, empty/no-op, validation/invalid input, not found, conflict, transient failure (retry), permanent failure
- UI copy / CLI examples / API examples as applicable (what the user sees)

**4. Functional Requirements** - Numbered (FR-1, FR-2...), specific and testable

**5. Contract Implied by the Interface (mandatory if data/actions are involved)**
- Endpoints/interfaces required by the interface
- Request/response shapes
- Validation rules
- Error semantics (codes/types/messages) as implied by interface states

**6. Non-Functional Requirements** (if applicable) - Performance, security, constraints

**7. Technical Notes** (optional) — Constraints, dependencies, or context. These inform the implementor but do not prescribe solutions.

**8. Acceptance Criteria**
- [ ] All functional requirements implemented
- [ ] Primary interface works end-to-end
- [ ] All interface states supported (success, failure, empty/no-op, loading/in-progress, validation)
- [ ] All tests pass
- [ ] Manual testing approved

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
git checkout -b feature/[feature-name]
```

### 5. Generate Folder ID
```bash
TODAY=$(date +%Y%m%d)
EXISTING=$(find ./docs/tasks -maxdepth 1 -type d -name "${TODAY}-*" 2>/dev/null | wc -l)
COUNTER=$(printf "%03d" $((EXISTING + 1)))
FOLDER_ID="${TODAY}-${COUNTER}-[feature-name]"
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
  "type": "feature",
  "status": "pending",
  "priority": "[high|medium|low based on impact]",
  "created": "[ISO 8601 timestamp]",
  "branch": "feature/[feature-name]",
  "description": "[brief description]"
}
```

### 8. Save & Commit
```bash
mkdir -p "./docs/tasks/${FOLDER_ID}"
```

Save to: `./docs/tasks/[FOLDER_ID]/feature-[feature-name].md`

```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add feature plan for [feature-name]"
```

## Output
- Branch: `feature/[feature-name]`
- Document: `./docs/tasks/[FOLDER_ID]/feature-[feature-name].md`
- tasks.json updated
- Ready for `/tasks/implement`
