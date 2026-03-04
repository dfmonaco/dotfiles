---
name: planning
description: "Turn a feature brief into a concrete implementation plan. Use after brainstorming (or when the user has a clear idea of what to build) and before implementation. Researches the codebase, makes technical design decisions, and produces an ordered task list that an implementation agent can follow. Triggers: 'plan this feature', 'how should I implement this', 'break this down into tasks', 'make a plan for this'."
---

# Planning

Turn a feature brief (or a well-defined idea) into an implementation plan grounded in the actual codebase. The output is a step-by-step plan that the implementation skill can execute.

This is NOT brainstorming - the "what and why" should already be decided. And this is NOT implementation - don't write production code, just figure out what needs to change and in what order.

## Rules

- Research the codebase before making technical decisions. Don't design against assumptions.
- Ask questions only when the codebase can't answer them. Prefer investigating over asking.
- When you do ask, include your recommendation based on what you've found.
- Keep the plan at the right altitude: specific enough to act on (name files, describe changes), but don't write the actual code.
- Identify the smallest set of changes that delivers the feature. Resist the urge to refactor things that aren't in the way.

## Input

This skill works best with a feature brief from the brainstorming skill, but also accepts any clear description that covers: what to build, why, and what's in/out of scope.

If the input is too vague to plan against, say so and suggest running the brainstorming skill first.

## Workflow

### 1) Research

Goal: understand the codebase and relevant libraries well enough to make real technical decisions.

**Codebase research (always):**

- Read the feature brief (or user's description) to identify what areas of the codebase are involved.
- Explore those areas: file structure, existing patterns, conventions, dependencies.
- Identify the specific files and modules that will need to change.
- Note existing patterns to follow (how similar things are already done).
- Resolve the open questions from the feature brief where possible through codebase investigation.

**External research (when the feature involves libraries, APIs, or tools):**

- Check current docs for any libraries or APIs the feature depends on. Use Context7 to look up accurate, up-to-date API signatures and usage patterns - don't rely on training data for this.
- If the feature introduces a new dependency, verify it's the right choice: check for active maintenance, breaking changes in recent versions, and whether it fits the existing stack.
- Use WebFetch for specific docs pages, changelogs, or migration guides when needed.

Skip external research when the feature is purely internal (config changes, refactoring, etc.) and doesn't touch third-party code.

Don't boil the ocean. Focus on the parts of the codebase and the specific libraries that the feature actually touches.

### 2) Design

Goal: make the technical decisions the implementer shouldn't have to figure out.

Based on what you found in research:

- Decide where new code lives (new files vs extending existing ones).
- Decide on the approach for each significant change (data structures, APIs, configuration, etc.).
- Identify the order of changes - what depends on what.
- Check if the project has testing infrastructure (test files, test framework, test scripts). If it does, the plan **must** include tasks to add or update tests for the changes being made. Follow the existing test patterns and framework. If the project has no tests, don't invent a test infrastructure - just note it.
- Flag anything risky or uncertain that the implementer should know about.

If there are meaningful design choices, present them to the user with your recommendation. For straightforward decisions, just make the call and explain briefly.

### 3) Plan

Goal: produce the handoff artifact.

Write the implementation plan using the template below. Each task should be:

- **Self-contained enough** to be done in one focused session.
- **Ordered** so that each task builds on the previous (no forward dependencies).
- **Specific** about what file(s) to touch and what the change is, without writing actual code.

## Output: Implementation Plan

```markdown
# Implementation Plan: <Feature Name>

## Context
<Brief summary of what's being built and the key decisions made during planning. 2-4 sentences. Reference the feature brief if one exists.>

## Research Notes
<What you found during research that's relevant to the implementer. Bullet points.>
- Codebase: existing patterns to follow, conventions to match, gotchas.
- Libraries/APIs: version-specific usage notes, relevant API signatures, deprecations. (omit if no external deps)

## Tasks

### 1. <Short description>
- **Files:** <files to create or modify>
- **What:** <describe the change - what to add, modify, or remove>
- **Why:** <brief rationale if not obvious>
- **Watch out:** <gotchas, edge cases, or things to verify> (optional)

### 2. <Short description>
...

## Verification
<How to confirm the feature works once implemented. Manual steps, commands to run, or behaviors to check. If the project has tests, a green test suite is the final verification step.>
```
