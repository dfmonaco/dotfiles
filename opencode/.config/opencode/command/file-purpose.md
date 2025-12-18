---
description: Apply invariant, role-based file purpose headers to selected files
---

# Apply File Purpose Headers

Add or update a **file-level purpose header** that documents the file’s
**identity, scope, and invariants**, not behavior or implementation.

## Interaction

Ask the user:

> Which files should I apply the file-purpose header to?

Accept natural language file selection and confirm before applying changes.

## Rules

- Insert the header at the top of each file.
- Replace any existing file-level header entirely.
- Do not modify any code.

## Header principles (must be enforced)

- Describe **what the file is**, not what it does.
- Avoid verbs where possible.
- No behavior.
- Statements must remain valid across refactors.
- Header changes only when the file’s identity changes.

## Section principles (apply to ALL sections)

- Describe identity, not behavior.
- Use noun phrases, not actions.
- No implementation.
- No current state or conditional facts.
- Content must remain valid across refactors.
- If a statement could move to another file, it does not belong here.

## Section meanings (strict)

Role:
- What kind of file this is in the system.

Scope:
- The architectural layer or concern this file belongs to.

Consumers:
- System-level entities that rely on this file existing.

## Forbidden content

- Temporary or implementation-bound facts
- External references

## Self-check rules

- If a line could become false after a refactor, it does not belong.
- If a line describes behavior, rewrite it as identity or remove it.
- If a line fits better in another section, move it or remove it.

## Execution model (mandatory)

1. Draft the file-purpose header.
2. Validate each section against the section principles.
3. Revise until all checks pass.
4. Only then apply the header to the file.

## Header format (do not modify)

FILE PURPOSE
============

Role:
  <file identity>

Scope:
  <architectural or lifecycle scope>

Consumers:
  <system-level users>
