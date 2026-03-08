---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing, before committing or creating PRs - requires running verification commands and confirming output before making any success claims; evidence before assertions always
---

# Verification Before Completion

Require fresh evidence before claiming work is complete, fixed, or passing.

This skill is a reporting gate, not a replacement for implementation, planning, or testing. Use it whenever you are about to make a success claim or take an action that assumes the work is verified.

**Core principle:** Evidence before claims, always.

**Announce at start:** "I'm using the verification-before-completion skill to verify the current claim before I report it."

## When to Use

- before saying code is complete, fixed, passing, ready, or successful
- before committing, creating a PR, merging, or presenting branch-finish options
- after delegated or subagent work, before trusting the result
- after a TDD cycle, major fix, or plan milestone when you need to report status
- do not use as a substitute for the actual implementation or test workflow that should produce the evidence

## Core Rules

- identify the exact command, checklist, or manual behavior that proves the claim
- run the freshest complete verification that fits the claim; do not rely on old output or partial checks
- read the actual output, exit status, and failure count before speaking
- if evidence is mixed or incomplete, report the real state instead of stretching the claim
- if no automated verification exists, say that explicitly and use the best available manual or scriptable evidence

## Workflow

### 1) Identify the Claim

Decide what you are about to claim, for example:

- tests pass
- build succeeds
- bug is fixed
- requirement is complete
- agent task finished successfully

### 2) Choose the Proving Step

Pick the proof that actually matches the claim.

| Claim | Required proof | Not enough |
|-------|----------------|------------|
| Tests pass | Fresh test command with passing result | Old run, partial suite, confidence |
| Linter clean | Fresh lint output with zero errors | Build output, code inspection |
| Build succeeds | Fresh build command exit `0` | Lint passing |
| Bug fixed | Reproduction or regression test now passes | Code changed |
| Requirements met | Checklist against requirements plus verification | Tests passing alone |
| Delegated task complete | Inspect diff and run relevant verification | Agent says "done" |

### 3) Run and Read It

For every claim:

1. run the full relevant command or manual checklist
2. read the output fully enough to know what passed and what failed
3. verify that the evidence really supports the exact wording you plan to use

### 4) Report Honestly

- If the proof passes, state the result and cite the evidence.
- If the proof fails, say what failed and what remains.
- If proof is partial, say exactly what is verified and what is still unverified.

## Key Patterns

**Tests**

```text
Good: Ran `<test command>` and it passed (`34/34`).
Bad: "Should pass now" or "Looks correct"
```

**Regression fix**

```text
Good: Reproduced the failure, added the regression test, and it now passes.
Bad: "I fixed it" without proving the original symptom changed
```

**Build**

```text
Good: Ran `<build command>` and it exited `0`.
Bad: "Lint passed" when the claim is about the build
```

**Delegated work**

```text
Good: Reviewed the diff, ran verification, and reported the actual result.
Bad: Trusting an agent's success message without checking
```

## Handoff

After verification:

- if verification failed, return to `test-driven-development`, `executing-plans`, or the active implementation workflow
- if verification passed but more implementation remains, continue that workflow instead of declaring full completion
- if the change is substantial and another opinion would help, use `requesting-code-review`
- if the work is fully verified and the user needs branch-level next steps, use `finishing-a-development-branch`

## Exit Criteria

Verification-before-completion is complete when:

- the claim being made is explicit
- matching evidence was gathered freshly enough for that claim
- the reported status matches the evidence exactly
- the next step is clear: continue implementation, request review, or finish the branch

## Common Mistakes

- using words like "should", "probably", or "seems" instead of evidence
- treating lint, build, tests, and manual checks as interchangeable proof
- relying on old output, partial verification, or subagent summaries
- claiming more than the evidence proves
- skipping verification because the code change feels obvious
