---
description: Generate comprehensive Product Requirements Document (PRD)
---

Generate a comprehensive Product Requirements Document (PRD) for: $ARGUMENTS

## Goal

To guide an AI assistant in creating a detailed Product Requirements Document (PRD) in Markdown format, based on an initial user prompt. The PRD should be clear, actionable, and suitable for a junior developer to understand and implement the feature.

## Prerequisites

- User has provided an initial feature request or description
- AI has access to project structure and existing codebase (if applicable)

## Process

1. **Receive Initial Prompt:** The user provides a brief description or request for a new feature or functionality.

2. **Ask Clarifying Questions:** Before writing the PRD, the AI *must* ask clarifying questions to gather sufficient detail. The goal is to understand the "what" and "why" of the feature, not necessarily the "how" (which the developer will figure out). 
   - Provide options in lettered/numbered lists for easy user selection
   - Ask follow-up questions based on user responses
   - Continue until you have enough detail to write a comprehensive PRD

3. **Generate PRD:** Based on the initial prompt and the user's answers, generate a PRD using the structure outlined below.

4. **Save PRD:** Save the generated document as `prd-[feature-name].md` inside the `/docs/tasks/[feature-name]/` directory.

5. **Confirmation:** Ask the user to review the PRD and confirm it captures their requirements before proceeding to task generation.

## Clarifying Questions Framework

The AI should adapt questions based on the prompt. Cover these core areas systematically:

### Problem & Context
- "What specific problem does this feature solve for users?"
- "What triggered the need for this feature?"
- "How are users currently handling this without the feature?"

### Target Users & Use Cases
- "Who is the primary user of this feature? (e.g., end users, admins, developers)"
- "In what scenarios will this feature be used most?"
- "Are there different user types with different needs?"

### Core Functionality
- "What are the 3-5 most important things users should be able to do with this feature?"
- "Can you walk me through a typical user workflow?"
- "What actions should users be able to perform? Please prioritize them."

### User Stories & Acceptance Criteria
- "Can you provide specific user stories? Format: 'As a [user type], I want to [action] so that [benefit]'"
- "How will we know this feature is working correctly?"
- "What does 'done' look like for this feature?"

### Scope & Boundaries
- "What should this feature NOT do? (non-goals)"
- "Are there any similar features in the system we should integrate with or avoid duplicating?"
- "What's the minimum viable version vs. nice-to-have features?"

### Technical Context
- "Are there existing system components this should integrate with?"
- "Are there any technical constraints or requirements I should know about?"
- "What data does this feature need to work with?"

### Design & UX
- "Do you have any design mockups or UI preferences?"
- "Should this follow existing UI patterns in the application?"
- "Are there any specific user experience requirements?"

### Success Metrics
- "How will you measure if this feature is successful?"
- "What metrics or outcomes should improve after implementing this?"

## PRD Structure

Generate the PRD with these sections in order:

### 1. Feature Overview
- **Feature Name:** Clear, descriptive name
- **Problem Statement:** 2-3 sentences describing the problem being solved
- **Solution Summary:** Brief description of the proposed solution

### 2. Goals & Success Metrics
- **Primary Goals:** 3-5 specific, measurable objectives
- **Success Metrics:** How success will be measured (quantitative when possible)
- **Business Impact:** Expected benefits to users and business

### 3. User Stories
- **Primary User Stories:** Core functionality from user perspective
- **Secondary User Stories:** Additional features or edge cases
- Format: "As a [user type], I want to [action] so that [benefit]"

### 4. Functional Requirements
List specific functionalities the feature must have:
- Use clear, actionable language
- Number requirements (FR-1, FR-2, etc.)
- Include input/output specifications where relevant
- Specify validation rules and constraints

### 5. Non-Functional Requirements (if applicable)
- Performance requirements
- Security considerations
- Accessibility requirements
- Compatibility requirements

### 6. Non-Goals (Out of Scope)
- Explicitly state what this feature will NOT include
- Helps manage scope and expectations
- Reference future phases if applicable

### 7. User Interface Requirements
- Describe key UI elements and layout
- Reference existing design patterns or mockups
- Specify responsive design requirements
- Note accessibility considerations

### 8. Technical Considerations
- Integration points with existing systems
- Data requirements and storage needs
- API requirements (if applicable)
- Dependencies on other features or services

### 9. Edge Cases & Error Handling
- Identify potential error scenarios
- Specify expected behavior for edge cases
- Define user-facing error messages

### 10. Open Questions
- List remaining uncertainties
- Note areas needing further research
- Flag decisions requiring stakeholder input

## Quality Checklist

Before finalizing the PRD, ensure:
- [ ] All functional requirements are testable
- [ ] User stories follow the standard format
- [ ] Technical terms are explained or avoided
- [ ] Requirements are specific, not vague
- [ ] Success criteria are measurable
- [ ] Scope is clearly defined
- [ ] Edge cases are considered

## Target Audience

Write for a **junior developer** who will implement this feature:
- Use explicit, unambiguous language
- Avoid unnecessary jargon
- Provide context for business decisions
- Include enough detail for technical planning

## Output Specifications

- **Format:** Markdown (`.md`)
- **Location:** `/docs/tasks/[feature-name]/`
- **Filename:** `prd-[feature-name].md`
- **Naming Convention:** Use kebab-case for feature names (e.g., `user-profile-editing`)

## Critical Instructions

1. **DO NOT** start implementing the PRD
2. **ALWAYS** ask clarifying questions before writing
3. **WAIT** for user confirmation before proceeding to task generation
4. **ENSURE** all sections are complete and actionable
5. **SAVE** the file in the correct location with proper naming
