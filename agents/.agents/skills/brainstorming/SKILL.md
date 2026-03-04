---
name: brainstorming
description: "Interview-driven feature brainstorming and early scoping. Use at the start of any new feature or significant behavior change (before planning/PRD or implementation) to clarify problem, users, constraints, success criteria, and non-goals; explore 2-3 approaches with tradeoffs; surface edge cases/risks/open questions; output a concise feature brief to hand off to the planning skill."
---

# Brainstorming

Turn a vague idea into a testable, scoped feature concept by interviewing the user, exploring alternatives, and stress-testing the design with edge cases.

## Operating Rules

- Ask one question per turn until critical unknowns are resolved.
- Prefer multiple-choice questions when it reduces user effort.
- Always include a recommendation when presenting options or asking for a decision.
- Do not jump into implementation details; stay at product/system design level.
- Explicitly call out assumptions; label unknowns as `TBD`.
- Ruthlessly cut scope (YAGNI) until an MVP is clear.

## Workflow

### 0) Establish Context (fast)

If working in an existing product/codebase, do a short pass to avoid designing against a fantasy:

- Identify the product area and current behavior.
- Identify adjacent systems this feature will touch.
- State 2-4 bullets: "what exists today" and "what changes".

### 1) Interview: Define the Problem

Goal: make the "why" and "who" crisp.

Ask one question at a time until you can state:

- Problem statement (1-2 sentences)
- Primary user (and secondary users if any)
- Success criteria (observable, measurable)

Question areas:

- Users/personas
- Current pain + why now
- Desired outcome (what changes for the user)
- Constraints (tech, time, policy/compliance, platforms)

### 2) Scope: MVP + Non-Goals

Goal: prevent scope creep early.

- Define the minimum shippable slice that delivers value.
- Define explicit non-goals (what is NOT being built).
- Identify dependencies and required integrations.

### 3) Explore 2-3 Approaches

Propose 2-3 viable solution approaches. For each:

- Core idea in 1-2 sentences
- 3-6 tradeoffs (complexity, risk, cost, UX, operability)
- Unknowns and how to validate

Then recommend one approach and explain why.

### 4) Edge Case + Risk Sweep

Systematically look for failures and foot-guns. At minimum cover:

- Permissions/roles
- Data lifecycle (create/update/delete, audit, recovery)
- Concurrency/races, idempotency, retries
- Partial failure modes (and offline/poor network if relevant)
- Performance/scalability assumptions
- Security and abuse cases
- Observability and supportability
- Migration/rollout/backward compatibility

### 5) Produce the Feature Brief (handoff artifact)

When the user confirms the direction, produce a single Markdown brief using the template below.

Do not write a PRD here; the goal is a clear, bounded concept to hand to the planning skill.

## Output Template: Feature Brief

```markdown
# <Feature name>

## One-liner
<What is it, in 1 sentence>

## Problem
<Who is hurting and why now?>

## Users
- Primary: <persona>
- Secondary: <persona> (optional)

## Success Criteria
- <measurable outcome>
- <measurable outcome>

## Constraints
- <tech/stack/platform>
- <policy/compliance/security>
- <timeline/budget>

## Assumptions
- <assumption>

## Proposed Approach (Recommended)
<1-2 paragraphs describing the approach>

## Alternatives Considered
- A: <approach> - <why not>
- B: <approach> - <why not>

## MVP Scope
- In:
  - <capability>
  - <capability>
- Out:
  - <non-goal>
  - <non-goal>

## User Flows
- Happy path: <steps>
- Edge paths:
  - <edge path>
  - <edge path>

## Data + Permissions (High Level)
- Data created/updated: <what>
- Visibility/roles: <who can do what>

## Risks + Edge Cases
- <risk/edge case> - <mitigation or open question>
- <risk/edge case> - <mitigation or open question>

## Open Questions (for planning)
- <question>
- <question>

## Example Trigger Phrases

- "Let's brainstorm a new feature"
- "I have an idea but it's vague"
- "Help me think through edge cases"
- "What are different ways to solve this?"
- "Before we implement this, let's design it"
