---
description: Apply invariant, role-based file purpose headers to selected files
---

# Apply File Purpose Headers

Add or update a **file-level purpose header** that documents the file's
**identity, scope, and invariants**, not behavior or implementation.

## Interaction

Ask the user:

> Which files should I apply the file-purpose header to?

Accept natural language file selection. Once files are confirmed, proceed autonomously through drafting, validation, and application without requesting further permission.

## Rules

- Insert the header at the top of each file.
- Do not modify any code.

## Header Principles

- Describe **what the file is**, not what it does.
- Avoid verbs; use noun phrases.
- No behavior or implementation details.
- No current state or conditional facts.
- Statements must remain valid across refactors.
- If a statement could move to another file, it does not belong here.
- Header changes only when the file's identity changes.

## Section Meanings

- **Role:** What kind of file this is in the system.
- **Scope:** The architectural layer or concern this file belongs to.
- **Consumers:** System-level entities that rely on this file existing.

## Forbidden Content

- Temporary or implementation-bound facts
- External references

## Self-Check (MANDATORY)

For EVERY drafted header, validate each line:

- If it could become false after a refactor → remove it
- If it describes behavior → rewrite as identity or remove
- If it fits better in another section → move or remove

Show validation results before applying.

## Execution

For each file:

1. Draft the file-purpose header
2. Validate against header principles and self-check rules
3. Show validation results, revise until all checks pass
4. Apply the header (no permission needed)
5. Proceed to next file

## Header Format

```
FILE PURPOSE
============

Role:
  <file identity>

Scope:
  <architectural or lifecycle scope>

Consumers:
  <system-level users>
```
