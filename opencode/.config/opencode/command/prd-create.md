---
description: Draft and save an implementation-ready PRD for a new feature
---

# PRD Create

## Objective
Create a clear, implementation-focused PRD that a junior developer can use to build the feature. The PRD serves as the source of truth for requirements, scope, and acceptance criteria.

## Role & Standards
Act as a Senior Product Manager writing for a **Junior Developer**.
- **Tone:** Explicit, unambiguous, and implementation-focused
- **Quality:** All Functional Requirements must be atomic, testable, and handle edge cases
- **Format:** Markdown

## Process

### 1. Discovery
Ask the user to briefly describe the feature they want to build.

### 2. Clarification
Once the user responds, analyze their request and:

1. **Restate** your understanding of the feature
2. **Ask clarifying questions** covering:
   - Context & Problem (Why is this needed?)
   - Target Users & Use Cases (Who will use this? When?)
   - Scope Boundaries (What's in scope? What's explicitly out?)
   - Constraints (Technical limitations, UX requirements, performance needs)

3. **Provide proposed answers** for every question based on best practices
   - Tell the user: *"You can reply 'Agree' to accept all proposed answers, or correct specific ones"*

### 3. Draft PRD
Once details are confirmed, generate the PRD with this structure:

#### Required Sections

**1. Feature Overview**
- Feature name
- Problem statement (why this matters)
- Solution summary (what we're building)

**2. Goals & Success Metrics**
- Primary goals (2-3 max)
- Measurable success criteria

**3. User Stories**
- Format: *"As a [role], I want to [action], so that [benefit]"*
- Include primary and edge-case scenarios

**4. Functional Requirements**
- Numbered format (FR-1, FR-2, etc.)
- Must be specific, testable, and complete
- Cover happy path, edge cases, and error states

**5. Non-Functional Requirements** (if applicable)
- Performance expectations
- Security considerations
- Platform/browser constraints

**6. UI/UX Guidelines** (if applicable)
- Key screens and user flows
- Interactive states (loading, error, empty, success)
- Accessibility requirements

**7. Technical Notes**
- Data models or schema changes
- API endpoints or integrations needed
- Dependencies or prerequisite work

**8. Open Questions**
- Items requiring decision or future clarification
- Known unknowns

### 4. Review & Save
1. Review the PRD against the **Role & Standards**
2. Ensure all Functional Requirements are implementation-ready
3. Save the file:
   - **Path:** `/docs/tasks/[feature-name]/prd-[feature-name].md`
   - **Naming:** Use kebab-case (e.g., `user-profile-editing`)
   - Create directory if needed

## Output
A comprehensive PRD document saved to `/docs/tasks/[feature-name]/prd-[feature-name].md`

## Success Criteria
- [ ] PRD contains all required sections
- [ ] All Functional Requirements are atomic and testable
- [ ] Edge cases and error states are documented
- [ ] PRD is saved to correct location
- [ ] User has confirmed the PRD is complete and accurate
