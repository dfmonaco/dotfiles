---
name: git-commit
description: Create one or more atomic git commits for the current worktree using Conventional Commits. Use this skill whenever the user asks to commit changes, make a git commit, write commit messages, split work into logical commits, or finalize staged or unstaged work into commits. Also use it when the user clearly wants commit creation even if they only say things like "commit this", "make atomic commits", or "save these changes in git".
---

# Git Commit

Create commits from the current repository state with strong boundaries, safe staging behavior, and Conventional Commit messages.

This skill performs the commit workflow. It does not just suggest a message unless the user explicitly asks for message help only.

**Announce at start:** "I'm using the git-commit skill to inspect the worktree, group changes into logical commits, and create Conventional Commits."

## When to Use

- when the user explicitly asks to create a commit or commits
- when the user wants staged work committed without touching unstaged changes
- when the user wants unstaged work grouped into atomic commits
- when the user asks for a Conventional Commit based on the current diff
- do not use when the user only wants an explanation of git or a hypothetical commit message without creating commits

## Core Philosophy

- **Explicit commit intent is authorization.** If the user asks to commit, proceed without asking for another permission prompt.
- **Atomicity over convenience.** Each commit should represent one logical change with a single reason to exist.
- **Staged changes are sacred.** If the index is non-empty, operate only on staged changes and leave unstaged work alone.
- **Message should reflect intent.** Commit messages should explain the change category and purpose, not dump implementation details.
- **Safety over eagerness.** Do not commit likely secrets, unrelated work, or changes the user did not ask to include.

## Core Rules

- If there are staged changes, commit only the staged changes.
- If there are no staged changes but the working tree has changes, analyze all relevant changes and stage only what belongs in the logical commit you are making.
- If there are no changes, report that there is nothing to commit and stop.
- Split unrelated features, fixes, refactors, docs, config changes, or subsystem changes into separate commits.
- Keep closely related code, tests, and docs together.
- Never stage or commit files that likely contain secrets such as `.env`, credential exports, or private key material.
- Follow repository safety rules for git operations. Do not use destructive commands, skip hooks, or amend unless explicitly requested and allowed.

## Workflow

### 1) Inspect the repository state

Start by understanding what can be committed.

Run these in parallel when possible:

```bash
git status --short
git diff --staged
git diff
git log -5 --oneline
```

Use them to determine:

- whether the index is empty or not
- which files are staged, unstaged, deleted, or untracked
- whether the changes are one logical unit or need to be split
- the repository's recent commit message style, while still preferring Conventional Commits

### 2) Choose the commit set

Apply this decision order exactly:

1. If the index is non-empty, commit only the staged changes.
2. If nothing is staged but there are working tree changes, group the changes into one or more atomic commits and stage only the files for the current logical unit.
3. If there are no changes, report that there is nothing to commit.

When grouping changes:

- separate unrelated concerns into different commits
- keep tests with the behavior they validate
- keep documentation with the change it explains when they are tightly coupled
- if the worktree mixes unrelated user work with the requested change, ignore the unrelated changes rather than sweeping them into the commit

### 3) Draft the commit message

Use Conventional Commits 1.0.0:

```text
<type>[optional scope][optional !]: <description>

[optional body]

[optional footer(s)]
```

Rules:

- `type` is required and should match the change intent
- use `feat` for new features
- use `fix` for bug fixes
- common types also include `docs`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `style`, and `revert`
- `scope` is optional and should be a short noun when it improves clarity
- `!` marks a breaking change
- keep the description short, lowercase when practical, and in the imperative mood
- add a body when extra rationale or context is useful
- add footers for things like `Refs: #123` or `BREAKING CHANGE: <description>` when needed

Prefer a message that reflects why the change exists, not a line-by-line summary of what changed.

### 4) Create the commit

If you need to stage files because nothing is already staged, add only the files for the current logical change.

Then create the commit normally:

```bash
git add <relevant-paths>
git commit -m "<type>(scope): <description>"
```

If a body is needed, use multiple `-m` flags rather than trying to compress rationale into the subject line.

If there are multiple logical changes, repeat the inspect, stage, and commit loop until all intended changes are committed.

### 5) Verify and report

After each commit, run:

```bash
git status --short
```

Report:

- the commit hash and subject line for each commit created
- whether any changes were intentionally left unstaged or uncommitted
- if nothing was committed, say so explicitly

## Breaking Changes

Breaking changes must be indicated by either:

- `!` before the colon, for example `feat(api)!: drop v1 endpoints`
- a `BREAKING CHANGE: <description>` footer

`BREAKING-CHANGE:` is also valid.

## Output Expectations

When the skill completes, provide a concise result that includes:

- how many commits were created
- the resulting commit hash or hashes and subject lines
- any intentionally excluded files or leftover changes

Example:

```text
Created 2 commits:
- a1b2c3d feat(nvim): add snacks dashboard overrides
- d4e5f6a docs(git): document worktree cleanup flow

Left unstaged: zsh/.zshrc
```

## Common Mistakes

- committing staged and unstaged changes together when the index is already non-empty
- bundling unrelated work into one convenience commit
- writing subject lines that describe files changed instead of intent
- staging the whole repo when only one logical unit should be committed
- committing secrets or environment files without explicitly checking them
- asking for extra permission even though the user already requested a commit
