---
name: code-review
description: "Conduct thorough code reviews on branches or pull requests using atomic view analysis. Use when reviewing PRs, auditing code quality or security, doing pre-merge reviews, or running quality passes. Triggers: 'review this PR', 'review this branch', 'code review', 'check this code', 'review changes'."
---

# Code Review

Analyze a git branch (or PR) relative to a base and produce a structured review organized as **Atomic Views** -- single-purpose change groups presented in narrative (oldest-to-newest) order.

## Philosophy

- **Truthful atomicity over commit boundaries.** Use commits as a starting point, but split/merge into Atomic Views so each view has exactly one WHY.
- **Narrative order.** Always present oldest to newest.
- **Critical thinking.** Call out architectural tradeoffs; recommend better patterns when appropriate.
- **Constructive and specific.** Every issue must include rationale and a suggested direction. Never just say "this is wrong."
- **Prioritize by impact.** Flag severity: critical (security, data loss, major bugs), important (performance, maintainability), or minor (style, nits).

## Workflow

### 1) Discovery

Ask the user:
- What is this review for? (pre-merge, refactor, quality pass, security audit)
- Any focus areas? (tests, architecture, performance, security, consistency)
- How aggressive should suggested fixes be? (low-risk only vs medium-risk refactors)

Recommend: medium-risk refactors are fine if clearly labeled and behavior is preserved with tests.

### 2) Determine Scope

Infer branch and base:
```bash
BRANCH=$(git branch --show-current)
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")
BASE="${1:-$DEFAULT_BRANCH}"
MERGE_BASE=$(git merge-base "$BASE" HEAD)
RANGE="${MERGE_BASE}..HEAD"
```

If `git merge-base` fails, ask the user for the correct base. Show inferred values and confirm before proceeding.

### 3) Collect Changes

```bash
git log --reverse --oneline "$RANGE"
git diff --name-status "$RANGE"
git diff --stat "$RANGE"
```

Read key diffs and surrounding context to understand the changes deeply. Don't review blindly from diffstat alone.

### 4) Build Atomic Views

Partition changes by PURPOSE, not by commit:
- **Split** commits that mix multiple concerns (tests vs behavior, refactor vs feature, unrelated subsystems).
- **Merge** adjacent commits that share the same purpose.

Each Atomic View must have:
- A single explicit WHY
- A bounded set of files
- A coherent set of findings that could be addressed in one commit

### 5) Review Each Atomic View

For each view, evaluate against these areas (skip what's irrelevant):

**Correctness and Logic**
- Does the code do what it claims?
- Edge cases handled? Error paths covered?
- No silent failures or swallowed errors?

**Design and Architecture**
- Consistent with existing codebase patterns?
- Appropriate abstraction level? Code in the right place?
- Single responsibility maintained? Simpler alternatives exist?

**Naming and Clarity**
- Descriptive variable, function, and type names?
- No abbreviations unless widely understood?
- Code is self-documenting without excessive comments?

**Security**
- User inputs validated (type, range, format)?
- No hardcoded secrets or credentials?
- Injection risks addressed (SQL, XSS, command injection)?
- Auth/authz checks in place for sensitive operations?
- Dependencies free of known vulnerabilities?

**Performance**
- Appropriate algorithm/data structure choices?
- No unnecessary loops, allocations, or blocking calls?
- Database queries efficient (no N+1, proper indexing)?
- Resources properly acquired and released?

**Testing**
- New/changed code has corresponding tests?
- Edge cases and error paths tested?
- Tests are deterministic, readable, and independent?

**Code Hygiene**
- No dead code, commented-out code, or magic values?
- DRY principle followed without over-abstraction?
- Consistent with project formatting and style?

### 6) Present Findings

Structure the review as:

**Per Atomic View:**
1. **Summary** -- what changed and why (1-2 sentences)
2. **Findings** -- specific issues with file/line references, severity, rationale, and suggested direction
3. **What works well** -- acknowledge good decisions (pattern choices, test coverage, clean abstractions)

**Feedback format:**
```
[CRITICAL|IMPORTANT|MINOR] file:line -- Description of the issue.
Why it matters: <rationale>
Suggestion: <concrete direction without prescribing exact implementation>
```

**Overall:**
- A brief summary of the branch's overall quality and readiness
- Top risks or blockers (if any)
- Recommended next steps

### Feedback Principles

- **Be specific.** Reference files, lines, and concrete behavior -- not vague impressions.
- **Explain why.** Every suggestion needs a reason (bug risk, maintainability, performance, etc.).
- **Suggest direction, not dictation.** Describe the desired outcome; let the author choose the implementation.
- **Acknowledge good work.** Positive feedback on good decisions reinforces quality.
- **Pick your battles.** Focus review energy on critical and important issues. Batch minor nits separately.
