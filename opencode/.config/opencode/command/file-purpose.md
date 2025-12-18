---
description: Apply invariant, role-based file purpose headers to selected files
---

# Apply File Purpose Headers

Add or update a **file-level purpose header** that documents the file’s
**identity, scope, and invariants**, not behavior or implementation.

## Interaction

Ask the user:

> Which files should I apply the file-purpose header to?

Accept natural language file selection. Once files are confirmed, proceed autonomously through drafting, validation, and application without requesting further permission.

## Rules

- Insert the header at the top of each file.
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

## Self-check rules (MANDATORY - always perform)

For EVERY drafted header, you MUST validate each line against these checks:

- If a line could become false after a refactor, it does not belong.
- If a line describes behavior, rewrite it as identity or remove it.
- If a line fits better in another section, move it or remove it.

Show your self-check validation results before applying changes.

## Execution model (mandatory)

For each file:

1. Draft the file-purpose header.
2. **ALWAYS validate** each section against:
   - Section principles (lines 31-38)
   - Self-check rules (above)
   - Forbidden content rules (lines 52-54)
3. Show validation results and revise until all checks pass.
4. **Automatically apply** the header without asking for permission.
5. Proceed to next file.

Work autonomously through all files once the file list is confirmed.

## Header format (do not modify)

FILE PURPOSE
============

Role:
  <file identity>

Scope:
  <architectural or lifecycle scope>

Consumers:
  <system-level users>
