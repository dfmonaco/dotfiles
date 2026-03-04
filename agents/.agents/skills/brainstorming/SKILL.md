---
name: brainstorming
description: "Interview-driven brainstorming for new features or significant changes. Use before planning/implementation to clarify the problem, explore approaches with tradeoffs, define MVP scope, and produce a feature brief that hands off to the planning skill."
---

# Brainstorming

Turn a vague idea into a scoped feature concept through conversation. The output is a feature brief that the planning skill uses as input.

This is NOT planning. Stay at the "what and why" level. Don't design APIs, schemas, or file structures - that's the planning skill's job.

## Rules

- One question at a time. Prefer multiple-choice when it reduces effort.
- Always include your recommendation when asking questions or presenting options.
- Call out assumptions explicitly. Mark unknowns as `TBD`.
- Cut scope aggressively. Default to the smallest useful version (YAGNI).
- Stay conversational. This should feel like thinking out loud with a collaborator, not filling out a form.

## Workflow

### 1) Understand

Goal: get clear on the problem and constraints.

If there's an existing codebase, do a quick scan first to ground the conversation in reality (what exists today, what would change).

Then ask questions until you can confidently state:

- **The problem** - What's broken or missing, and why does it matter now?
- **Who benefits** - Who hits this problem? (Often just "me" for a solo dev, and that's fine.)
- **Done when** - How will we know this works? Concrete conditions, not metrics.
- **Hard constraints** - Tech stack, compatibility requirements, time budget, anything non-negotiable.

Don't over-interview. If the user's initial description already covers some of these, acknowledge it and move on.

### 2) Explore

Goal: consider options before committing.

Propose 2-3 viable approaches. For each:

- Core idea (1-2 sentences)
- Key tradeoffs (complexity, risk, UX, maintenance)
- What could go wrong (the big risks, not an exhaustive audit)

Recommend one and explain why. If one approach is obviously right, say so - don't invent alternatives just to fill a template.

### 3) Capture

Goal: produce the handoff artifact.

When the user confirms the direction, generate the feature brief using the template below. Only include sections that are relevant - skip empty ones rather than filling them with placeholder text.

## Output: Feature Brief

```markdown
# <Feature Name>

## Problem
<What's broken or missing, who it affects, why it matters now. 2-3 sentences.>

## Done When
- <concrete condition>
- <concrete condition>

## Constraints
- <non-negotiable limitation>

## Approach
<1-2 paragraphs: what we're building and the key design decisions>

## Alternatives Considered
- <approach> - <why not chosen>

## Scope
- **In:** <what's included in MVP>
- **Out:** <what we're explicitly not doing>

## Risks
- <risk> - <mitigation or TBD>

## Open Questions
- <anything unresolved that the planning skill needs to address>
```
