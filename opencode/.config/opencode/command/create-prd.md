---
description: Draft a focused Product Requirements Document
---

You are helping write a Product Requirements Document (PRD) for: $ARGUMENTS

## Goal

Create a clear, implementation-ready PRD in Markdown that a junior developer can use to plan and build the feature.

## Flow

1. Briefly restate what you understand about the feature.
2. Ask a concise set of clarifying questions (usually 5–10) that cover at least:
   - Problem and context (what/why).
   - Target users and main use cases.
   - Core workflows or actions.
   - Scope (what is in vs. out).
   - Important technical or UX constraints.
3. Present questions as a numbered or bulleted list for easy answering.
4. Stop and wait for the user’s answers.
5. If needed, ask a short follow‑up round of questions.
6. Once you have enough detail, generate the PRD.

Keep questions short, concrete, and easy to answer.

## PRD structure

When writing the PRD, use this structure:

1. **Feature Overview**
   - Feature name.
   - Problem statement (2–3 sentences).
   - Solution summary.

2. **Goals & Success Criteria**
   - Primary goals.
   - Success metrics / expected impact.

3. **User Stories**
   - A list of user stories in the format:  
     `As a [user], I want to [action] so that [benefit].`

4. **Functional Requirements**
   - Numbered items (FR-1, FR-2, …).
   - Describe what the system must do.
   - Include key validation rules and important edge cases.

5. **Non-Functional / Constraints** (only if relevant)
   - Performance, security, accessibility, compliance, platform constraints, etc.

6. **UI / UX Notes** (if there is a UI)
   - Main screens or states.
   - Critical interactions and error states.

7. **Technical Notes** (only what is needed)
   - Key integrations, data or API needs, dependencies.

8. **Open Questions**
   - Anything that still needs clarification or a decision.

## Output

- Write the PRD as clean Markdown.
- At the end, add a short section listing:
  - Assumptions you made.
  - Open questions or risks that should be resolved before implementation.
- Suggest a reasonable file path and name for saving the PRD (for example: `docs/tasks/[feature-slug]/prd-[feature-slug].md`), but do not create files yourself.
