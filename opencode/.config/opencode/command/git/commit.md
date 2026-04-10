---
description: Commit modified files to git
agent: build
---

# Git Commit

Commit modified files with atomic Conventional Commits.

## Change Selection

1. If the index is non-empty, operate only on staged changes. Do not stage or modify unstaged files.
2. If nothing is staged but the working tree has changes, analyze modified, added, deleted, and untracked files, stage what is needed, and create one or more atomic commits.
3. If there are no changes, report that there is nothing to commit.

---

# Rules

## Execute

Execute commits immediately without asking for permission or review. Invoking this command is authorization to commit.

## Atomicity

IMPORTANT: Each commit must represent one logical change. Split unrelated features, fixes, refactors, or subsystem changes into separate commits. Keep closely related code, tests, and docs together.

## Message Format

Use Conventional Commits 1.0.0:

```text
<type>[optional scope][optional !]: <description>

[optional body]

[optional footer(s)]
```

Rules:
- `type` is required and should match the change intent. `feat` is required for new features. `fix` is required for bug fixes.
- `scope` is optional and should be a concise noun when useful.
- `!` marks a breaking change.
- `description` is required, short, and written in the imperative mood.
- Use a body when extra context or rationale is needed. Start it one blank line after the description.
- Use one or more footers for trailers such as `Refs: #123`, `Reviewed-by: Name`, or `BREAKING CHANGE: <description>`.

## Breaking Changes

Breaking changes must be indicated by either:
- `!` before the colon, for example `feat(api)!: drop v1 endpoints`
- a `BREAKING CHANGE: <description>` footer

`BREAKING-CHANGE:` is also valid.

## Common Types

Common types include `feat`, `fix`, `docs`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `style`, and `revert`. Other valid types may be used when they better describe the change.

## Style

Prefer lowercase for consistency. Put rationale in the body when needed rather than forcing it into the description.
