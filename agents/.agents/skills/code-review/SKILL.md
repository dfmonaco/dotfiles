---
name: code-review
description: Generate a code review with atomic views and remediation requirements for the current branch vs a base branch. Use this skill when the user wants a code review, branch review, diff review, change analysis, pre-merge review, or quality pass on their current work. Also use when the user asks to understand what changed on a branch, wants a narrative explanation of their changes, or needs a review document before merging.
---

# Code Review (Atomic Views)

Analyze the current branch relative to a base branch and produce a review document that tells the story of what changed and why, surfaces risks, and defines remediation requirements.

This skill generates a **document**. It does not implement fixes. It defines **what** should be reviewed or improved and **why** it matters, never **how** to implement the changes.

**Announce at start:** "I'm using the code-review skill to analyze this branch and generate a review document."

## When to Use

- before merging a feature branch, to understand and verify all changes
- for a quality pass or refactor review on in-progress work
- when the user wants a narrative explanation of branch changes (not a raw diff)
- when changes need to be reviewed for architecture, performance, security, or consistency concerns
- do not use for reviewing a single file or a quick spot-check; just answer inline instead

## Core Philosophy

- **Truthful atomicity over commit boundaries.** Commits are a starting reference, but split or merge them into Atomic Views so each view has exactly one WHY. A commit that mixes test additions with behavioral changes becomes two views. Adjacent commits that share a purpose merge into one.
- **Narrative order.** Always present oldest to newest so the reader follows the thread of reasoning from start to finish.
- **Critical thinking.** Call out architectural tradeoffs and recommend better patterns when appropriate. Do not rubber-stamp changes.
- **What, not how.** Remediation requirements describe outcomes, not implementations.
- **Ownership transfer.** The goal is for the reader to understand the internal map of decision-making well enough to verify the logic against their domain expertise and take full ownership of the code as if they had written it themselves.

## Core Rules

- Ground everything in the actual diff. Do not speculate about code you have not read.
- Include your recommendation whenever you present options or tradeoffs.
- Keep before/after snippets concise and functionally coherent. Always include the file path. Never use unified diff format or git diff format in the review document itself.
- Connect each Atomic View to the next so the reader can follow the decision-making thread.
- Note assumptions about business logic and any trade-offs the author should be aware of.
- If a change looks correct but fragile, say so. If it looks wrong, say so directly.

## Workflow

### 1) Discovery

Ask the user three questions to scope the review:

1. **Purpose** - What is this review for? (pre-merge, refactor, quality pass, something else?)
2. **Focus areas** - Any specific concerns? (tests, architecture, performance, security, consistency, or general)
3. **Aggressiveness** - How aggressive should remediation recommendations be? (low-risk only, or allow medium-risk refactors too?)

My recommendation: allow medium-risk refactors, but clearly label risk level and preserve existing behavior with tests.

If the user says "just review it" or gives a terse response, use sensible defaults (pre-merge, general focus, medium-risk allowed) and confirm briefly before proceeding.

### 2) Clarification (infer branch and base)

Infer the branch, base, and review range:

```bash
BRANCH=$(git branch --show-current)
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git config --get init.defaultBranch 2>/dev/null || echo "main")
BASE="${DEFAULT_BRANCH}"
REVIEW_NAME="${BRANCH}"
MERGE_BASE=$(git merge-base "$BASE" HEAD)
RANGE="${MERGE_BASE}..HEAD"
```

If `git merge-base` fails or the base branch does not exist, ask the user to provide the correct base branch.

Show the inferred values to the user:
- Branch: `$BRANCH`
- Base: `$BASE`
- Merge base: `$MERGE_BASE`
- Range: `$RANGE`

Ask the user to confirm or correct before proceeding.

### 3) Analyze changes

Collect the raw material for the review. Run these in parallel:

```bash
git log --reverse --oneline "$RANGE"
git diff --name-status "$RANGE"
git diff --stat "$RANGE"
```

Then read the actual diffs for each changed file to understand what happened. Use targeted reads rather than dumping the entire diff at once; focus on the files and hunks that matter.

For large branches with many files, prioritize:
1. Files with the most significant behavioral changes
2. New files (understand their purpose)
3. Deleted files (understand why they were removed)
4. Config and dependency changes

### 4) Build Atomic Views

This is the core analytical step. Group changes by purpose, not by commit or file.

**Process:**

1. Start with the commit list as the initial partition.
2. **Split** any commit that mixes multiple WHYs (e.g., tests mixed with behavior changes, refactoring mixed with new features, changes to unrelated subsystems).
3. **Merge** adjacent commits that share the same WHY into a single Atomic View.

**Each Atomic View must have:**

- A single explicit WHY (the purpose of this group of changes)
- A bounded set of files it touches
- A coherent set of recommendations that could be applied in one commit

**Ordering:** Always oldest to newest, following the narrative thread.

### 5) Generate the review document

Create the output directory if needed, then write the document.

```bash
mkdir -p ./docs/code-reviews
```

File: `./docs/code-reviews/YYYY-MM-DD-<review-name>-code-review.md`

Use the current date and the branch name (sanitized for filenames).

The document has two layers per Atomic View:

**Layer 1: Findings (narrative)**

For each Atomic View, write a narrative section that includes:

- **Bridge and rationale**: How this view connects to the previous one. What problem it solves and why it was necessary for the overall goal.
- **Contextual snippets**: Concise before/after code snippets with file path references. Show enough to see the logic, strip unnecessary boilerplate. Strictly avoid git diff or unified diff format; use clean code blocks labeled "Before" and "After" with the file path.
- **Domain impact**: Assumptions about business logic, trade-offs, and things the author should verify against their domain expertise.
- **Risks and tradeoffs**: What could go wrong, what was gained, what was lost.
- **Architectural notes**: How this aligns (or doesn't) with the patterns in the codebase.

**Layer 2: Remediation requirements (high-level)**

One remediation step per Atomic View. Each step describes:

| Field | Description |
|-------|-------------|
| **Intent** | The outcome we want |
| **Scope** | Areas and files involved, at a high level |
| **Success criteria** | How we know it is complete |
| **Suggested verification** | What to validate, without prescribing exact implementations |
| **Risk level** | Low, medium, or high |
| **Proposed commit message** | WHY-focused, following conventional commit style |

Not every Atomic View needs remediation. If the changes are solid, say so and skip the remediation step for that view. Only generate remediation requirements where there is genuinely something to improve.

## Output Template

```markdown
# Code Review: <branch-name>

> Reviewed: <current-date>
> Branch: `<branch>` vs `<base>` (range: `<merge-base>..HEAD`)
> Purpose: <review purpose from discovery>
> Focus: <focus areas from discovery>

## Summary

<2-4 sentences: what this branch does overall, the main risks, and the overall assessment>

## Atomic Views

### View 1: <Short descriptive title>

**WHY:** <single sentence explaining the purpose of this group of changes>

**Files:** `path/to/file1`, `path/to/file2`

#### Findings

<Bridge and rationale connecting to previous context>

<Before/after snippets with file path references>

<Domain impact, risks, tradeoffs, architectural notes>

#### Remediation

- **Intent:** <outcome we want>
- **Scope:** <areas involved>
- **Success criteria:** <how we know it is done>
- **Verification:** <what to validate>
- **Risk:** <low/medium/high>
- **Commit message:** `<type>(scope): <why-focused message>`

---

### View 2: <title>

...

## Overall Recommendations

<Cross-cutting concerns, patterns observed across multiple views, general suggestions>

## Open Questions

<Anything that needs the author's domain expertise to resolve>
```

## Handoff

After generating the review document, report what was produced and suggest the next step:

**"Review complete and saved to `docs/code-reviews/<filename>`. If you want to apply the remediation requirements, the next step is to use `executing-plans` to work through them."**

If the user only wanted the review, stop after saving and reporting. Do not force execution.

If the user wants to proceed with fixes:
- The remediation requirements in the review document serve as the plan.
- Use `executing-plans` to apply them one at a time.
- Use `test-driven-development` for behavioral changes when tests are practical.
- Use `verification-before-completion` before claiming any fix is complete.

## Exit Criteria

The review is complete when:

- all changes in the range have been analyzed and grouped into Atomic Views
- each view tells a coherent narrative with rationale and snippets
- risks, tradeoffs, and recommendations are explicit
- remediation requirements are defined where improvements are warranted
- the document is saved to the expected location
- the user knows where to find it and what the suggested next step is

## Common Mistakes

- Presenting changes file-by-file instead of by purpose
- Using git diff format or unified diff in the review document
- Writing vague recommendations ("consider improving this") instead of concrete remediation requirements with success criteria
- Rubber-stamping changes without critical analysis
- Mixing implementation guidance into what should be a what/why document
- Skipping the discovery step and assuming what the user wants reviewed
- Generating remediation requirements for changes that are already solid
- Losing the narrative thread between Atomic Views
