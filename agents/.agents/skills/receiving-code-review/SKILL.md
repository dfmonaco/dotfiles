---
name: receiving-code-review
description: Use when receiving code review feedback, before implementing suggestions, especially if feedback seems unclear or technically questionable - requires technical rigor and verification, not performative agreement or blind implementation
---

# Receiving Code Review

Evaluate review feedback technically before changing code or agreeing with it.

This skill is for handling incoming review comments from a human partner, GitHub reviewer, or subagent review. It is not a script for performative agreement.

**Core principle:** Verify before implementing. Ask before assuming. Technical correctness over social comfort.

**Announce at start:** "I'm using the receiving-code-review skill to evaluate this feedback before I act on it."

## When to Use

- when review feedback arrives from a human partner, GitHub reviewer, or internal review pass
- before implementing requested fixes that may affect behavior, scope, or architecture
- when feedback is unclear, partially correct, or conflicts with the current plan
- after `requesting-code-review` returns findings

## Core Rules

- read the full feedback before changing anything
- restate or clarify the technical requirement before implementing
- verify each suggestion against the actual codebase and requirements
- push back with reasoning when a suggestion is incorrect, risky, or out of scope
- do not use gratitude or agreement as a substitute for technical understanding

## Workflow

### 1) Understand the Feedback

For each item, determine:

- what is being requested
- whether the request is clear enough to implement
- whether it is blocking, important, or minor

If any item is unclear in a way that could affect the rest, pause and clarify first instead of implementing a partial interpretation.

### 2) Verify Against Reality

Check whether the suggestion:

- is technically correct for this codebase
- breaks existing functionality or compatibility
- conflicts with the approved plan or your human partner's prior direction
- adds unnecessary scope or violates YAGNI

For external reviewers, be especially careful about context they may not have.

### 3) Decide How to Respond

- if the feedback is correct, fix it directly and state what changed
- if the feedback is partly right, implement the valid part and explain the adjustment
- if the feedback is wrong or harmful, push back with technical reasoning
- if the feedback changes scope or design materially, return to `brainstorming` or `writing-plans`

### 4) Implement Safely

When applying feedback:

- use `test-driven-development` for bug fixes or behavior changes when tests are practical
- apply changes one item at a time or in tightly related batches
- verify each fix before claiming it is resolved

## Response Patterns

**Good**

```text
Fixed. The nil-check was missing in `server.ts` and the regression test now covers it.
```

```text
I checked this against the current compatibility target and we still need the fallback path. I can fix the bundle identifier issue without dropping legacy support.
```

```text
I understand items 1, 2, 3, and 6. I need clarification on 4 and 5 before implementing because they may affect the same code path.
```

**Bad**

```text
You're absolutely right!
Great point!
Let me implement that now.
```

## GitHub Thread Replies

When replying to inline review comments on GitHub, reply in the same thread (`gh api repos/{owner}/{repo}/pulls/{pr}/comments/{id}/replies`) rather than posting a top-level PR comment.

## Handoff

After processing the feedback:

- if code changes were made, use `verification-before-completion` before saying the review item is fixed
- if the fixes are substantial or the reviewer asked for follow-up validation, use `requesting-code-review` again
- if the feedback exposes a design or scope problem, return to `writing-plans` or `brainstorming`
- if everything is resolved and the branch is ready for the next decision, use `finishing-a-development-branch`

## Exit Criteria

Receiving review is complete when:

- every review item is understood, clarified, or explicitly challenged
- accepted fixes were implemented and verified, or the reason for not implementing them is documented
- the next step is clear: more implementation, re-review, or branch finish

## Common Mistakes

- agreeing before verifying
- implementing only the parts you understand while leaving related unclear items unresolved
- assuming external reviewers have full context
- avoiding justified pushback because it feels uncomfortable
- claiming a comment is fixed before verification ran
