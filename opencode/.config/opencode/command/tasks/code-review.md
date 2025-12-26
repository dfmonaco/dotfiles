---
description: Generate a code review remediation task (atomic views) for the current branch vs a base branch
---

# Code Review Task (Atomic Views → Remediation Requirements)

## Objective
Analyze the current git branch relative to a base branch and generate a **task document** that:

1. Explains the changes as **Atomic Views** (single-purpose groups, narrative order)
2. Includes concrete **recommendations** and **risks**
3. Produces high-level **remediation requirements** so `/tasks/implement` can apply improvements step-by-step

This is intended to replicate `/github/pr-respond`, but for local branch review.

## Philosophy
This document defines **what** should be reviewed/improved and **why** it matters — never **how** to implement the changes.

- **Truthful atomicity over commit boundaries:** use commits as a reference, but split/merge into Atomic Views so each view has exactly one WHY.
- **Narrative order:** always present oldest → newest.
- **Non-prescriptive recommendations:** describe desired outcomes, tradeoffs, and success criteria; implementation details are decided during `/tasks/implement` with real feedback loops.
- **Critical thinking:** call out architectural tradeoffs; recommend better patterns when appropriate.

## Invocation
- `/tasks/code-review` — infer base branch
- `/tasks/code-review <base>`
- `/tasks/code-review <base> <review-name>`

Where:
- `$1` = base branch (optional)
- `$2` = review name slug (optional)

## Process

### 1) Discovery
Ask the user:
- What is this review for? (pre-merge? refactor? quality pass?)
- Any focus areas? (tests, architecture, performance, security, consistency)
- How aggressive should fixes be during implementation? (low-risk only vs allow medium-risk refactors)

My recommendation: allow medium-risk refactors, but clearly label risk and preserve behavior with tests.

### 2) Clarification (infer branch/base)
Infer:
```bash
BRANCH=$(git branch --show-current)
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git config --get init.defaultBranch 2>/dev/null || echo "main")
BASE="${1:-$DEFAULT_BRANCH}"
REVIEW_NAME="${2:-$BRANCH}"
MERGE_BASE=$(git merge-base "$BASE" HEAD)
RANGE="${MERGE_BASE}..HEAD"
```

If `git merge-base` fails or base branch doesn’t exist, ask user to provide correct base.

Show the inferred values and ask user to reply `Agree` or correct.

### 3) Analyze changes
Collect:
- Commit list in range (oldest→newest)
- Files changed (name-status + diffstat)
- Key diffs/snippets to support rationale

Suggested commands:
```bash
git log --reverse --oneline "$RANGE"
git diff --name-status "$RANGE"
git diff --stat "$RANGE"
```

### 4) Build Atomic Views (mandatory)
Create Atomic Views by PURPOSE:
- Start with commits as the initial partition.
- Split commits that mix multiple WHYs (tests vs behavior, refactor vs feature, unrelated subsystems).
- Merge adjacent commits that share the same WHY.

Each Atomic View must have:
- A single explicit WHY
- A bounded set of files
- A coherent set of recommendations that could be applied in one commit

### 5) Generate task document (review + remediation requirements)
Generate a document with two layers per Atomic View:

1) **Findings (narrative)**
- Context, files modified, small snippets, and rationale
- Risks and tradeoffs
- Architectural/code-structure notes (what good looks like in this repo)

2) **Remediation Requirements (high-level)**
- One remediation step per Atomic View
- Each step describes:
  - intent (the outcome we want)
  - scope (areas/files involved, at a high level)
  - success criteria (how we know it’s complete)
  - suggested tests/verification (what to validate), without prescribing exact implementations
  - risk level (low/medium/high)
  - proposed commit message (WHY-focused)

Implementation details are decided during `/tasks/implement` with real feedback loops.

### 6) Create task folder + tasks.json entry

#### Generate Folder ID
```bash
TODAY=$(date +%Y%m%d)
EXISTING=$(find ./docs/tasks -maxdepth 1 -type d -name "${TODAY}-*" 2>/dev/null | wc -l)
COUNTER=$(printf "%03d" $((EXISTING + 1)))
FOLDER_ID="${TODAY}-${COUNTER}-code-review-${REVIEW_NAME}"
```

#### Ensure tasks.json exists
```bash
mkdir -p ./docs/tasks
if [ ! -f ./docs/tasks/tasks.json ]; then
  echo '{"tasks": []}' > ./docs/tasks/tasks.json
  git add ./docs/tasks/tasks.json
fi
```

#### Update tasks.json
Add entry:
```json
{
  "id": "[FOLDER_ID]",
  "type": "code_review",
  "status": "pending",
  "priority": "[high|medium|low based on impact]",
  "created": "[ISO 8601 timestamp]",
  "branch": "[current branch]",
  "description": "Code review remediation: [review-name] (vs [base])"
}
```

### 7) Save & Commit
Create folder:
```bash
mkdir -p "./docs/tasks/${FOLDER_ID}"
```

Save document to:
- `./docs/tasks/[FOLDER_ID]/code-review-[review-name].md`

Commit:
```bash
git add docs/tasks/[FOLDER_ID]/ docs/tasks/tasks.json
git commit -m "docs: add code review remediation task for [review-name]"
```

## Output
- Task doc: `./docs/tasks/[FOLDER_ID]/code-review-[review-name].md`
- tasks.json entry with `type: code_review`
- Ready for `/tasks/implement` (guide/auto), which should implement remediation one Atomic View per step/commit
