---
name: finishing-a-development-branch
description: Use when implementation is complete, all tests pass, and you need to decide how to integrate the work - guides completion of development work by presenting structured options for merge, PR, or cleanup
---

# Finishing a Development Branch

Decide how to integrate, preserve, or discard verified work once implementation is complete.

This skill is for branch-level closeout. It assumes the work itself is already implemented and verified, or that you are about to confirm that state before presenting options.

**Core principle:** Verify current state -> present structured options with a recommendation -> execute the chosen path safely.

**Announce at start:** "I'm using the finishing-a-development-branch skill to decide the safest next step for this branch."

## When to Use

- after implementation is complete and the user needs a merge, PR, hold, or discard decision
- after `executing-plans` or ad-hoc development when branch-level next steps are now the focus
- when a feature branch or worktree needs explicit disposition
- do not use before relevant verification is current
- do not force this skill when the user only asked for local edits and no integration decision is needed

## Core Rules

- use `verification-before-completion` first, or confirm equally fresh evidence already exists
- determine the real base branch and branch state from git instead of assuming `main`
- present a short list of concrete options and include a recommendation
- require explicit typed confirmation for destructive discard actions
- never force-push, hard-reset, or amend unless the user explicitly asked
- if the repo has no automated tests or build, say that clearly and use the best available verification evidence

## Workflow

### 1) Verify Readiness

Before presenting options, confirm:

- current branch name and worktree state
- working tree status
- latest verification evidence relevant to this change
- whether the branch tracks a remote branch already

If verification is stale, incomplete, or failing, stop and return to `verification-before-completion`, `test-driven-development`, or `executing-plans` as appropriate.

### 2) Determine the Integration Context

Identify:

- likely base branch
- whether the branch is already pushed
- whether there is an open PR already
- whether the current checkout is a linked worktree that needs special handling

### 3) Present Structured Options

Offer these branch-level options:

1. merge locally into the base branch
2. push and create or update a pull request
3. keep the branch as-is for later
4. discard the branch and its work

Always include a recommendation, for example:

```text
My recommendation: 2. Push and create a pull request, because the work is verified and still benefits from a final review before merge.
```

If there is no safe recommendation yet because verification is stale or the branch is dirty in the wrong way, say that and resolve it before asking.

### 4) Execute the Chosen Path

**Option 1: Merge locally**

- switch to the base branch
- update it safely if appropriate for the repo
- merge the feature branch
- rerun the relevant verification on the merged result
- delete the feature branch only after verification still passes

**Option 2: Push and create or update a PR**

- push with upstream tracking if needed
- create the PR with a concise summary and verification notes, or update the existing PR context
- preserve the branch and worktree unless the user explicitly asks for cleanup

**Option 3: Keep as-is**

- report the branch name, worktree path if relevant, and any useful resume context
- do not clean up the branch or worktree

**Option 4: Discard**

Before deleting anything, show exactly what will be removed and require the user to type `discard`.

### 5) Close Out Clearly

Report the resulting state:

- branch status
- remote/PR status if relevant
- whether the worktree was kept or cleaned up
- the most relevant next skill, if any

## Handoff

After branch finishing:

- if a PR was created and feedback arrives later, use `receiving-code-review`
- if more code changes are still needed, return to `executing-plans` or the active implementation flow
- if verification was missing or failed, return to `verification-before-completion` or `test-driven-development`
- if the branch is intentionally being kept as-is, stop after reporting the preserved state

## Exit Criteria

Finishing the branch is complete when:

- the branch state and verification status were checked
- the user chose an explicit path, or the work was safely paused pending clarification
- any git actions taken match that choice
- the resulting local/remote/worktree state was reported accurately

## Common Mistakes

- presenting merge or PR options before fresh verification exists
- asking open-ended "what next" questions without a recommendation
- assuming the base branch without checking
- cleaning up a branch or worktree the user expected to keep
- deleting work without explicit confirmation
