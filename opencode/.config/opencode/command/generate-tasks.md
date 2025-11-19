---
description: Generate a detailed, test-driven, and implementation-focused task list from a PRD.
---
# Generate a Test-Driven Task List

## Goal & Target Audience
Create a **clear, actionable, and test-driven** task list in Markdown. The output must serve as a complete, step-by-step guide for a **junior developer** to implement the feature described in the PRD, starting from setup and ending with final validation.

## Initial Step
**ASK** the user for the **exact file path** of the Product Requirements Document (PRD) to read and analyze.

## Workflow
Follow these steps in order.

### 1. Analysis (Internal)
Analyze the PRD content, focusing on:
* **Functional Requirements (FRs):** Break these down into logical, deliverable chunks.
* **User Stories:** Convert acceptance criteria into testing goals.
* **Technical Notes:** Identify necessary file creation/modification and dependencies.

### 2. Task Generation Strategy (TDD Focus)
Generate a sequence of **Parent Tasks** (high-level themes) and detailed **Sub-Tasks**.

**Rules for Sub-Tasks:**
1.  Every Parent Task must follow a logical, dependency-ordered flow (e.g., Setup ->  Logic -> UI -> Integration).
2.  Every implementation step must be paired with a corresponding **TEST** sub-task that validates the step against the PRD's functional requirements.

#### Parent Task Template (Must be used for all tasks)
All tasks must be formatted as checkboxes (`- [ ]`).

```markdown
- [ ] **X.0 Parent Task Title** (e.g., Core Business Logic Implementation)
  - [ ] X.1 Setup/Preparation step specific to this task
  - [ ] X.2 Implementation step (focus on a single function/component)
  - [ ] X.3 Implementation step (focus on validation/error handling)
  - [ ] X.4 **Test:** Write and run unit/integration tests to validate (FR-X)
  - [ ] X.5 **Acceptance:** Commit step (`feat([scope]): implement X.0`)

```

### 3. File Identification
Based on the PRD's scope and components, create two distinct lists of required files:
* **Files to Create:** New components, services, and their corresponding test files.
* **Files to Modify:** Existing routes, types, configurations, and their corresponding updated test files.
* Documentation Files: README updates, API docs

### 4. Output Generation
Generate the final output document.

The document must contain the following sections in this order. The `Tasks` section must use the Parent/Sub-Task template provided below, adapting the themes (1.0, 2.0, etc.) to the specific feature:

| Section | Content Requirement |
| :--- | :--- |
| **Header** | `# Task List: [Feature Name]` and `*Generated from: [PRD Filename]*` |
| **Git Workflow** | The provided `git checkout` and `git checkout -b` commands. |
| **Overview** | A brief summary and key components. |
| **Relevant Files** | Two sub-sections: `Files to Create` and `Files to Modify`. |
| **Implementation Notes** | A brief section for **Testing Strategy**, Dependencies, and key Technical/UX notes. |
| **Tasks** | The primary section, using the detailed structure below. |
| **Definition of Done** | The provided checklist of completion criteria. |



### 5. Saving
SAVE the final document:

Filename: tasks-[prd-file-name].md

Location: /docs/tasks/[feature-name]/ (where [feature-name] is the kebab-cased name derived from the PRD).
