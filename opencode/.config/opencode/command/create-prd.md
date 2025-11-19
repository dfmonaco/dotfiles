---
description: Interactive workflow to draft, refine, and save a implementation-ready PRD.
---
# Write a Product Requirements Document (PRD)

## Role & Standards
Act as a Senior Product Manager writing for a **Junior Developer**.
- **Tone:** Explicit, unambiguous, and implementation-focused.
- **Quality:** Ensure all Functional Requirements are atomic and testable.
- **Format:** Markdown.

## Workflow
Follow these steps in order.

### 1. Discovery
Ask the user to briefly describe the feature they want to build.

### 2. Clarification Strategy
Once the user responds, analyze their request.
1.  **Restate** your understanding of the feature.
2.  **Ask clarifying questions** covering:
    - Context & Problem (Why?)
    - Target Users & Use Cases (Who/When?)
    - Scope (In/Out)
    - Constraints (Tech/UX)
3.  **Crucial Step:** For *every* question, provide a **"Proposed Answer"** based on best practices.
    > *Tell the user they can simply reply "Agree" to accept all your proposed answers, or correct specific ones.*

### 3. Drafting
Once the details are confirmed, generate the PRD using the structure below.

#### PRD Structure Template
1.  **Feature Overview**: Name, Problem Statement, Solution Summary.
2.  **Goals & Success**: Primary goals and measurable metrics.
3.  **User Stories**: Standard format (*As a... I want to... So that...*).
4.  **Functional Requirements**: Numbered (FR-1, FR-2). Must be specific and handle edge cases.
5.  **Non-Functional Requirements**: Performance, security, platform constraints (if applicable).
6.  **UI/UX**: Key screens, states, and interactions (if applicable).
7.  **Technical Notes**: Data needs, API integrations, dependencies.
8.  **Open Questions**: Items pending decision.

### 4. Finalization & Storage
1.  Review the generated content against the **Role & Standards**.
2.  Save the file:
    - **Path:** `/docs/tasks/[feature-name]/prd-[feature-name].md`
    - **Note:** Convert `[feature-name]` to kebab-case (e.g., `user-profile-edit`).
