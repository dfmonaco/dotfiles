---
name: requesting-code-review
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements
---

# Requesting Code Review

Bring in a second pass on the current change before issues spread downstream.

This skill is for analysis and feedback, not for blindly outsourcing judgment. Use it when an extra review pass would reduce risk or improve quality.

**Core principle:** Review at meaningful checkpoints, not performatively and not too late.

**Announce at start:** "I'm using the requesting-code-review skill to get a focused review of the current change set."

## When to Use

- after a substantial feature, refactor, or bug fix reaches a stable checkpoint
- before merge or PR creation when another review pass would reduce risk
- during `executing-plans` at major checkpoints or when uncertainty remains
- when you are stuck and want an independent read on the diff or design
- do not force this for every tiny, low-risk edit unless the context is unusually sensitive

## Core Rules

- verify the current work first; do not ask for review on obviously broken or unverified code unless the point is to diagnose it
- give the reviewer the requirement, the diff scope, and the verification context
- use an analysis-only subagent via `task`; prefer `oracle`, or `general` if broader investigation is needed
- review a specific range or current diff, not a vague "please look around"
- treat review feedback as input to evaluate, not orders to obey blindly

## Workflow

### 1) Define the Review Scope

Gather the minimum context the reviewer needs:

- what changed
- what requirement or plan it should satisfy
- which commit range or working-tree diff to inspect
- what verification already ran
- any known risks or areas you especially want reviewed

### 2) Launch the Review

Use the `task` tool with `subagent_type: "oracle"` for a no-edits review. Use `subagent_type: "general"` only when the reviewer needs broader repository investigation.

The prompt should include:

- a concise summary of the change
- the requirement or plan reference
- the git range or files to review
- verification already performed
- the exact output format you want back

Use `requesting-code-review/code-reviewer.md` as the base template when helpful.

### 3) Triage the Feedback

- fix critical issues before moving on
- address important issues before branch finish unless you have a strong technical reason not to
- capture minor issues for later if they are truly non-blocking
- if feedback is unclear or questionable, switch to `receiving-code-review`

## Example Review Request

```text
Review the diff from {BASE_SHA}..{HEAD_SHA} against {PLAN_OR_REQUIREMENTS}.
Focus on correctness, missing edge cases, verification gaps, and scope drift.
Return:
1. strengths
2. critical issues
3. important issues
4. minor issues
5. merge readiness with reasoning
```

## Handoff

After the review returns:

- use `receiving-code-review` to evaluate and apply the feedback rigorously
- after fixes, use `verification-before-completion` before claiming the issues are resolved
- if the review is clean and the user wants branch-level next steps, use `finishing-a-development-branch`
- if the review exposes a plan or scope problem, return to `writing-plans` or `brainstorming` instead of patching blindly

## Exit Criteria

Requesting review is complete when:

- the review scope was explicit
- the reviewer had enough context to judge the change
- feedback was returned and triaged
- the next step is clear: apply feedback, verify, re-review, or finish the branch

## Common Mistakes

- requesting review with no clear diff or requirement
- asking for review before any relevant verification ran
- treating every nit as critical or every critical issue as optional
- outsourcing judgment instead of evaluating the feedback technically
- skipping follow-up verification after applying review feedback
