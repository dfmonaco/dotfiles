---
description: Generate a test-driven task list from a PRD
---

Read and analyze the PRD at @$ARGUMENTS.

## Goal

Create a clear, test-driven implementation task list in Markdown that guides a developer from setup to completion of the feature described in the PRD.

## Understanding the PRD

1. Skim the whole PRD to understand the feature.
2. Pay special attention to:
   - Functional requirements (FR-x).
   - User stories and acceptance criteria.
   - Non-goals / out-of-scope items.
   - Technical constraints and integrations.
3. Briefly restate your understanding of the feature and call out any major risks or unknowns.

## Two-phase planning

### Phase 1 – Parent tasks

1. Break the work into 4–8 high-level parent tasks that represent major milestones (e.g., setup, core logic, UI, integration, validation, polish).
2. Order parent tasks logically based on dependencies.
3. For each parent task, provide:
   - A short description.
   - The main outcome or value.
   - The key kinds of tests that will validate it.
4. Present the list as checkboxes, for example:
   - [ ] **1.0 Project setup & scaffolding** – …
   - [ ] **2.0 Core business logic** – …
5. Ask the user to confirm or adjust the plan before going into detailed sub-tasks.  
   Say something like:  
   "I’ve proposed the high-level tasks based on the PRD. Ready for detailed sub-tasks? Reply with `Go` to continue or suggest edits first."
6. Stop and wait for the user’s response.

### Phase 2 – Sub-tasks

Once the user replies with `Go` (or equivalent confirmation):

1. For each parent task, create 3–8 sub-tasks that are:
   - Small, concrete, and actionable.
   - Usually completable in 15–60 minutes.
   - Explicit about the expected outcome.
2. Follow a test-driven pattern wherever it makes sense:
   - Setup / preparation.
   - Implementation.
   - Tests (unit, integration, or e2e as appropriate).
   - Acceptance / commit step.
3. Ensure every parent task includes at least one testing-focused sub-task.
4. Use a consistent numbering and checkbox style, for example:
   - [ ] **2.0 Core business logic**
     - [ ] 2.1 Define domain models / types.
     - [ ] 2.2 Implement service logic for [X].
     - [ ] 2.3 Write and run unit tests for [X].
     - [ ] 2.4 Acceptance: all tests pass, behavior matches PRD.

## Relevant files

From the PRD, infer a rough list of files to create or modify (implementation, tests, configuration, docs). Include this as a short section near the top of the output, for example:

- Files to create – path + one-line purpose.
- Files to modify – path + one-line change summary.

Keep paths and filenames generic enough that they can be adapted to different project structures. If unsure, describe the kind of file instead of guessing an exact path.

## Output format

Produce a single Markdown document with sections like:

1. Title: `# Task List: [Feature Name]` and a reference to the PRD file.
2. A short overview / implementation notes.
3. **Relevant Files** section (to create / to modify / docs).
4. **Tasks** section with parent tasks and numbered sub-tasks as checklists.
5. **Definition of Done** – a concise list covering requirements implemented, tests passing, docs updated, and code ready for review.
6. **Next steps** – what to do after all tasks are complete (e.g., open PR, request review).

Do not assume a specific Git branching strategy or command set. If needed, suggest generic Git steps (like "create a feature branch" or "open a pull request") rather than project-specific commands.
