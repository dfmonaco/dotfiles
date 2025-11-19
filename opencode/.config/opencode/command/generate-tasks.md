---
description: Generate test-driven task list from PRD
---

Read and analyze the PRD at @$ARGUMENTS

## Goal

To guide an AI assistant in creating a detailed, step-by-step task list in Markdown format based on an existing Product Requirements Document (PRD). The task list should guide a developer through a test-driven implementation workflow with clear checkpoints and validation steps.

## Prerequisites

- A completed PRD exists in `/docs/tasks/[prd-feature-name]/prd-[feature-name].md`
- AI has analyzed the PRD thoroughly
- User has confirmed the PRD is accurate and complete

## Process Overview

1. **Receive PRD Reference:** User points to a specific PRD file
2. **Analyze PRD:** Read and break down functional requirements and user stories
3. **Phase 1: Generate Parent Tasks** (High-level planning)
4. **User Confirmation:** Wait for "Go" signal
5. **Phase 2: Generate Sub-Tasks** (Detailed implementation steps)
6. **Identify Relevant Files:** Map tasks to code files
7. **Generate Final Output:** Complete task list with all sections
8. **Save Task List:** Store in correct location

## Detailed Process

### Phase 1: Parent Task Generation

1. **Analyze PRD Structure:**
   - Read all functional requirements (FR-1, FR-2, etc.)
   - Review user stories and acceptance criteria
   - Identify major system components needed
   - Note technical considerations and dependencies

2. **Create High-Level Tasks:**
   - Break PRD into 4-8 major implementation areas
   - Follow logical dependency order
   - Ensure each parent task delivers user-visible value
   - Consider: Setup → Core Logic → UI → Integration → Testing → Polish

3. **Present to User:**
   - Show parent tasks in the specified format
   - Explain the overall approach and rationale
   - State: "I have generated the high-level tasks based on the PRD. Ready to generate the sub-tasks? Respond with 'Go' to proceed."

4. **Wait for Confirmation:** Do not proceed until user responds with "Go"

### Phase 2: Sub-Task Generation

1. **Break Down Each Parent Task:**
   - Create 3-8 actionable sub-tasks per parent
   - Follow test-driven development principles
   - Each sub-task should be completable in 15-60 minutes
   - Include setup, implementation, and validation steps

2. **Required Sub-Task Structure:**
   - **Setup/Preparation:** Environment, dependencies, scaffolding
   - **Core Implementation:** Main functionality
   - **Testing:** Unit tests, integration tests as needed
   - **Acceptance:** Validation and commit step

3. **Testing Requirements:**
   - Every parent task must include testing sub-tasks
   - Test sub-tasks should specify what to test and how
   - Include both unit and integration tests where appropriate
   - Tests should validate the functional requirements

### File Identification Strategy

Analyze the PRD to identify files that will need creation or modification:

- **Component Files:** UI components, services, utilities
- **Test Files:** Corresponding test files for each component
- **Configuration Files:** Routes, constants, types
- **Integration Files:** API endpoints, database models
- **Documentation Files:** README updates, API docs

## Output Format

The generated task list **must** follow this exact structure:

````markdown
# Task List: [Feature Name]

*Generated from: `prd-[feature-name].md`*

## Git Workflow

**Create a new branch** before starting:
```bash
git checkout develop
git pull origin develop
git checkout -b feature/[feature-name]
```

**Branch Naming:** Use kebab-case (e.g., `feature/user-profile-editing`)

## Overview

Brief summary of what will be implemented, key components, and estimated timeline.

## Relevant Files

### Files to Create
- `path/to/new/component.tsx` - Description of component purpose and functionality
- `path/to/new/component.test.tsx` - Unit tests for the new component
- `path/to/service.ts` - Business logic and data handling
- `path/to/service.test.ts` - Service layer tests

### Files to Modify
- `path/to/existing/file.ts` - Description of modifications needed
- `path/to/existing/file.test.ts` - Updated tests for modifications
- `path/to/routes.ts` - Add new routes for feature
- `path/to/types.ts` - Add type definitions

### Documentation Files
- `README.md` - Update with new feature documentation
- `docs/api.md` - Document new API endpoints (if applicable)

## Implementation Notes

- **Testing Strategy:** Describe the testing approach (unit, integration, e2e)
- **Dependencies:** List any new packages or external dependencies
- **Performance Considerations:** Note any performance implications
- **Accessibility:** Highlight accessibility requirements
- **Browser Support:** Specify browser compatibility needs

## Tasks

- [ ] **1.0 Project Setup & Infrastructure**
  - [ ] 1.1 Create feature branch and initial file structure
  - [ ] 1.2 Set up base components and type definitions
  - [ ] 1.3 Configure routing and navigation (if needed)
  - [ ] 1.4 Install and configure any new dependencies
  - [ ] 1.5 **Test:** Verify project builds and runs without errors
  - [ ] 1.6 **Acceptance:** Commit initial setup (`feat(setup): initialize [feature-name] structure`)

- [ ] **2.0 Core Business Logic Implementation**
  - [ ] 2.1 Implement core data models and types
  - [ ] 2.2 Create service layer functions
  - [ ] 2.3 Add input validation and error handling
  - [ ] 2.4 **Test:** Write and run unit tests for business logic (aim for 80%+ coverage)
  - [ ] 2.5 **Acceptance:** Commit core logic (`feat(core): implement [feature-name] business logic`)

- [ ] **3.0 User Interface Components**
  - [ ] 3.1 Create base UI components
  - [ ] 3.2 Implement form handling and user interactions
  - [ ] 3.3 Add responsive design and accessibility features
  - [ ] 3.4 Style components according to design system
  - [ ] 3.5 **Test:** Write component tests and visual regression tests
  - [ ] 3.6 **Acceptance:** Commit UI implementation (`feat(ui): create [feature-name] interface`)

- [ ] **4.0 Integration & Data Flow**
  - [ ] 4.1 Connect UI components to business logic
  - [ ] 4.2 Implement API integration (if applicable)
  - [ ] 4.3 Add state management and data persistence
  - [ ] 4.4 Handle loading states and error scenarios
  - [ ] 4.5 **Test:** Integration tests covering user workflows
  - [ ] 4.6 **Acceptance:** Commit integration (`feat(integration): connect [feature-name] data flow`)

- [ ] **5.0 Validation & Error Handling**
  - [ ] 5.1 Implement comprehensive input validation
  - [ ] 5.2 Create user-friendly error messages
  - [ ] 5.3 Add fallback states and error boundaries
  - [ ] 5.4 **Test:** Test all error scenarios and edge cases
  - [ ] 5.5 **Acceptance:** Commit error handling (`feat(validation): add [feature-name] error handling`)

- [ ] **6.0 Final Testing & Polish**
  - [ ] 6.1 Run full test suite and achieve target coverage
  - [ ] 6.2 Perform manual testing of all user stories
  - [ ] 6.3 Test accessibility compliance (WCAG 2.1 AA)
  - [ ] 6.4 Cross-browser and responsive testing
  - [ ] 6.5 Performance testing and optimization
  - [ ] 6.6 **Test:** End-to-end testing covering complete user journeys
  - [ ] 6.7 **Acceptance:** Final commit and prepare for code review (`feat(final): complete [feature-name] implementation`)

## Definition of Done

- [ ] All functional requirements from PRD are implemented
- [ ] All user stories have been validated
- [ ] Test coverage is above 80%
- [ ] No failing tests in the test suite
- [ ] Code follows project style guidelines
- [ ] Accessibility requirements are met
- [ ] Performance benchmarks are satisfied
- [ ] Documentation is updated
- [ ] Feature is ready for code review

## Next Steps

After completing all tasks:
1. Push feature branch to remote repository
2. Create pull request with detailed description
3. Request code review from team members
4. Address review feedback
5. Merge to develop branch after approval
````

## Task Quality Guidelines

### Parent Tasks Should:
- Represent major milestones in the implementation
- Follow logical dependency order
- Each deliver demonstrable value
- Take 2-8 hours to complete (including sub-tasks)

### Sub-Tasks Should:
- Be atomic and actionable
- Include specific deliverables
- Be completable in 15-60 minutes
- Have clear success criteria
- Follow the pattern: Setup → Implement → Test → Validate

### Testing Requirements:
- Every parent task must include testing
- Specify what to test and expected outcomes
- Include both positive and negative test cases
- Cover edge cases identified in the PRD

## File Organization Standards

- Use consistent naming conventions (kebab-case for files)
- Group related files logically
- Include both implementation and test files
- Consider file size and modularity
- Follow project structure conventions

## Interaction Model

**Critical:** The process requires explicit user confirmation ("Go") after generating parent tasks before proceeding to detailed sub-tasks. This ensures alignment on the high-level approach before diving into implementation details.

## Target Audience

Assume the implementer is a **junior developer** who needs:
- Clear, unambiguous instructions
- Logical step-by-step progression
- Context for why each step is necessary
- Specific success criteria for each task
- Built-in checkpoints and validation

## Output Specifications

- **Format:** Markdown (`.md`)
- **Location:** `/docs/tasks/[prd-feature-name]/`
- **Filename:** `tasks-[prd-file-name].md`
- **Example:** `tasks-prd-user-profile-editing.md`

## Final Checklist

Before presenting the task list:
- [ ] All PRD requirements are covered by tasks
- [ ] Tasks follow logical dependency order
- [ ] Each task has clear acceptance criteria
- [ ] Testing is integrated throughout
- [ ] File list is comprehensive and accurate
- [ ] Commit messages follow conventional format
- [ ] Timeline is realistic for junior developer

