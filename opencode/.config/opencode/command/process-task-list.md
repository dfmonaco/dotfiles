---
description: Process task lists systematically with TDD workflow
---

Read and process the task list at @$ARGUMENTS

## Goal

Guidelines for managing and executing task lists in markdown files to track progress on completing a PRD implementation. Ensures systematic, test-driven development with proper validation at each step.

## Prerequisites

- A completed task list exists (generated from `generate-tasks.mdc`)
- Development environment is set up
- Git repository is properly configured
- User is ready to begin implementation

## Core Principles

### 1. Sequential Execution
- **One sub-task at a time:** Never start the next sub-task until the current one is fully complete and validated
- **User approval required:** After completing each sub-task, ask for explicit permission to continue
- **No parallelization:** Maintain strict order to ensure dependencies are met

### 2. Test-Driven Development
- Write tests before or alongside implementation
- All tests must pass before marking tasks complete
- Maintain high test coverage throughout development
- Run full test suite before major commits

### 3. Continuous Validation
- Validate each sub-task completion against its acceptance criteria
- Ensure the application still functions after each change
- Check that new code integrates properly with existing codebase

## Task Execution Protocol

### Sub-Task Completion Flow

1. **Start Sub-Task:**
   - Read the sub-task description carefully
   - Understand the expected deliverable
   - Identify files that need to be created or modified
   - Check for any dependencies or prerequisites

2. **Implement Sub-Task:**
   - Follow the specific instructions in the sub-task
   - Write tests first when applicable (TDD approach)
   - Implement the required functionality
   - Ensure code follows project standards and conventions

3. **Validate Sub-Task:**
   - Run relevant tests to ensure functionality works
   - Test manually if needed to verify behavior
   - Check that the sub-task acceptance criteria are met
   - Ensure no regressions in existing functionality

4. **Mark Complete:**
   - Change `[ ]` to `[x]` for the completed sub-task
   - Update the task list file immediately
   - Document any important discoveries or decisions made

5. **Request Permission:**
   - Stop and wait for user approval before proceeding
   - Ask: "Sub-task [X.Y] is complete. Ready to proceed to sub-task [X.Y+1]? (y/n)"
   - Do not continue until user responds with "yes", "y", or equivalent

### Parent Task Completion Protocol

When **all** sub-tasks under a parent task are marked `[x]`, follow this sequence:

1. **Pre-Commit Validation:**
   - Run the complete test suite (`npm test`, `pytest`, `bin/rails test`, etc.)
   - Ensure all tests pass (0 failures, 0 errors)
   - If tests fail, fix issues before proceeding
   - Verify the application builds/compiles without errors

2. **Code Review & Cleanup:**
   - Review all code changes for quality and consistency
   - Remove any temporary files, debug code, or commented-out code
   - Ensure code follows project style guidelines
   - Optimize imports and clean up unused dependencies

3. **Stage Changes:**
   - Only after all tests pass: `git add .`
   - Review staged changes: `git diff --cached`
   - Ensure only intended files are staged

4. **Commit Changes:**
   - Use conventional commit format: `type(scope): description`
   - Commit types: `feat`, `fix`, `refactor`, `test`, `docs`, `style`, `chore`
   - Include comprehensive commit message:
     ```
     feat(user-profile): implement profile editing functionality
     
     - Add profile form with validation
     - Implement save/cancel functionality
     - Add unit tests for profile service
     - Update user interface components
     
     Implements tasks 2.1-2.4 from PRD user-profile-editing
     Closes: #123
     ```

5. **Mark Parent Task Complete:**
   - Change parent task `[ ]` to `[x]`
   - Update the task list file
   - Confirm all related sub-tasks are also marked complete

6. **Post-Commit Validation:**
   - Verify the commit was successful
   - Run tests one more time to ensure stability
   - Check application functionality manually if needed

## Task List Maintenance

### 1. Regular Updates
- Update the task list file after every significant change
- Keep the "Relevant Files" section current
- Add new tasks as they emerge during implementation
- Note any changes to original requirements or approach

### 2. Progress Tracking
- Maintain accurate completion status for all tasks and sub-tasks
- Add timestamps or notes for completed items if helpful
- Track any blockers or issues encountered
- Update estimated time remaining if needed

### 3. File Management
- **Relevant Files Section:** Keep this section accurate and up-to-date
- Add new files as they are created
- Update descriptions when file purposes change
- Remove files that are no longer relevant

Example format:
```markdown
## Relevant Files

### Implementation Files
- `src/components/UserProfile.tsx` - Main profile editing component ✅
- `src/services/profileService.ts` - Profile data management ✅  
- `src/types/user.ts` - User-related type definitions ⏳
- `src/utils/validation.ts` - Input validation helpers ❌

### Test Files  
- `src/components/UserProfile.test.tsx` - Component unit tests ✅
- `src/services/profileService.test.ts` - Service layer tests ⏳

### Configuration Files
- `src/routes/index.ts` - Updated with profile routes ✅

Legend: ✅ Complete | ⏳ In Progress | ❌ Not Started
```

## Error Handling & Recovery

### When Tests Fail
1. **Stop immediately** - do not proceed to next sub-task
2. **Analyze the failure** - understand what broke and why  
3. **Fix the issue** - repair code or tests as needed
4. **Re-run tests** - ensure all tests pass
5. **Update task list** - note any issues resolved
6. **Resume normal flow** - continue with completion protocol

### When Sub-Tasks Need Modification
1. **Update the task description** - clarify what needs to be done
2. **Add new sub-tasks if needed** - break down complex issues
3. **Note the change** - document why the modification was necessary
4. **Continue with updated plan** - follow the revised sub-tasks

### When Dependencies Are Missing
1. **Identify the missing dependency** - what needs to be done first?
2. **Add prerequisite sub-tasks** - create necessary setup tasks
3. **Re-order tasks if needed** - ensure logical dependency flow
4. **Complete prerequisites first** - don't skip required setup

## Communication Protocol

### Status Updates
After each sub-task completion, provide:
- What was accomplished
- Any issues encountered and resolved
- Current status of the parent task
- Next step planned

Example:
```
✅ Sub-task 2.3 completed: Added input validation for profile form
- Implemented email format validation
- Added required field checks  
- Created custom validation hook
- All validation tests passing

Parent Task 2.0 Progress: 3/5 sub-tasks complete
Next: Sub-task 2.4 - Add error handling for save operations

Ready to proceed? (y/n)
```

### Decision Points
When encountering ambiguity or multiple implementation options:
1. **Stop and ask** - don't make assumptions
2. **Present options** - explain different approaches
3. **Wait for guidance** - get user input before proceeding
4. **Document decision** - note chosen approach and reasoning

## Quality Assurance Checklist

Before marking any parent task complete:
- [ ] All sub-tasks are marked complete (`[x]`)
- [ ] Full test suite passes with no failures
- [ ] Code follows project style guidelines
- [ ] No temporary or debug code remains
- [ ] Application builds without errors
- [ ] Manual testing confirms functionality works
- [ ] Relevant files list is up to date
- [ ] Commit message is descriptive and follows conventions
- [ ] All staged changes are intentional

## AI Assistant Instructions

When processing task lists:

### 1. Before Starting Work
- Review the entire task list to understand the scope
- Identify the next incomplete sub-task
- Check for any dependencies or prerequisites
- Confirm understanding of the sub-task requirements

### 2. During Implementation
- Focus only on the current sub-task
- Follow test-driven development practices
- Write clean, maintainable code
- Document any important decisions or discoveries

### 3. After Each Sub-Task
- Validate the work against acceptance criteria
- Update the task list file immediately
- Provide clear status update to user
- Wait for explicit permission to continue

### 4. During Parent Task Completion
- Follow the complete commit protocol
- Ensure all quality checks pass
- Write comprehensive commit messages
- Update progress tracking

### 5. Throughout the Process
- Maintain accurate task list status
- Ask for clarification when needed
- Suggest improvements to the process if applicable
- Keep the user informed of progress and any blockers

## Success Metrics

- **Task Completion Rate:** All tasks marked complete match actual implementation
- **Test Coverage:** Maintain high test coverage throughout development
- **Code Quality:** All code follows project standards and conventions
- **Git History:** Clean, meaningful commit history with proper messages
- **User Satisfaction:** Features work as expected and meet PRD requirements

## Continuous Improvement

After completing a feature:
- Review what worked well in the task execution
- Identify any process improvements needed
- Update task templates based on lessons learned
- Refine estimation accuracy for future tasks
