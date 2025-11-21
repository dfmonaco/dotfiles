---
description: Run project tests and autonomously fix failing ones
---

# Test Fix

## Objective
Execute the project's test suite, identify failing tests, and autonomously fix them by analyzing errors, modifying code, and validating fixes. Continue until all tests pass.

## Input
Optional `$ARGUMENTS`:
- Empty: Run all tests
- Specific test path/pattern: Run subset of tests (e.g., "src/auth", "test/unit")

## Core Principles

### Autonomy
- **Execute autonomously:** Do NOT ask for permission to fix tests
- **Make decisions:** Choose appropriate fixes based on test errors and codebase patterns
- **Adapt dynamically:** Handle cascading failures and related issues
- **Only pause for:** Critical architectural decisions or ambiguous requirements

### Quality
- **Root cause analysis:** Fix the underlying issue, not just the symptom
- **Prevent regressions:** Ensure fixes don't break other tests
- **Complete verification:** Run full test suite after all fixes
- **Code quality:** Maintain project conventions and patterns

### Communication
- **Progress updates:** Report after fixing each test or batch of tests
- **Task tracking:** Use TodoWrite tool to maintain visible progress
- **Transparency:** Document reasoning for each fix

## Process

### Phase 1: Discovery & Setup

#### 1.1 Git Branch Setup
Check current branch and create fix branch if needed:

```bash
git branch --show-current
```

**Branch Decision Logic:**
- **If on `main`, `master`, or `develop`:** Create a new branch for test fixes
  ```bash
  git checkout -b fix/failing-tests
  ```
- **If on a feature branch:** Stay on current branch (tests likely related to feature work)
- **If on another fix branch:** Stay on current branch

**Branch naming:** Use `fix/failing-tests` or `fix/[specific-area]` (e.g., `fix/auth-tests`)

#### 1.2 Identify Test Command
Read AGENTS.md or package.json to determine the project's test command:

```bash
# Common patterns to look for:
npm test
npm run test
yarn test
pnpm test
pytest
cargo test
go test
mvn test
gradle test
```

If test command is unclear:
1. Check AGENTS.md for "test" or "testing" section
2. Check package.json scripts for "test" entry
3. Look for test framework config files (jest.config.js, pytest.ini, etc.)

#### 1.3 Run Initial Test Suite
Execute the test command and capture output:

```bash
[test command] 2>&1
```

**Important:** Capture full output including error messages, stack traces, and failure summaries.

#### 1.4 Analyze Results
Parse test output to identify:
- **Total tests:** How many tests exist
- **Passing tests:** Current success count
- **Failing tests:** List of failures with error messages
- **Test categories:** Unit, integration, e2e, etc.

#### 1.5 Create Task Plan
If tests are failing, use TodoWrite to create a task list:

**Task Structure:**
- Group related failures (e.g., "Fix auth tests", "Fix database connection issues")
- One task per distinct failure or logical group
- Include file paths and test names in task descriptions

**Task Naming Convention:**
```
- Fix: [TestName] - [brief error summary] (path/to/test.spec.ts)
- Fix: [Category] tests - [common issue across multiple tests]
- Verify: Run full test suite and confirm all passing
```

### Phase 2: Fix Tests

#### 2.1 Execute Fixes Sequentially
For each failing test or group:

1. **Mark as in_progress** using TodoWrite
2. **Analyze the error:**
   - Read the test file
   - Read the implementation file being tested
   - Understand what the test expects vs. what's happening
   - Identify root cause (bug in code, outdated test, missing dependency, etc.)

3. **Determine fix strategy:**
   - **Code bug:** Fix the implementation
   - **Outdated test:** Update test to match current behavior (only if behavior is intentional)
   - **Missing setup:** Add required mocks, fixtures, or configuration
   - **Breaking change:** Update both code and test appropriately

4. **Implement the fix:**
   - Modify necessary files (implementation or test)
   - Follow project conventions (check AGENTS.md)
   - Add explanatory comments if the fix is non-obvious

5. **Verify the fix:**
   - Run the specific test(s) to confirm they now pass
   - Check for new failures (regressions)

6. **Commit the fix:**
   ```bash
   git add [modified files]
   git commit -m "test: fix [test name] - [brief explanation]"
   ```

7. **Mark as completed** using TodoWrite
8. **Move to next failing test**

#### 2.2 Error Pattern Recognition
Look for common patterns:
- **Import/module errors:** Missing dependencies, incorrect paths
- **Assertion failures:** Expected vs. actual value mismatches
- **Timeout errors:** Async issues, missing awaits
- **Mock failures:** Incorrect mock setup or outdated mocks
- **Setup/teardown issues:** Test environment not properly initialized

#### 2.3 Handle Cascading Failures
If multiple tests fail for the same reason:
- Fix the root cause once
- Re-run all affected tests
- Update TodoWrite to mark multiple tests as completed

#### 2.4 Code Quality Standards
When fixing code (not tests):
- Maintain existing code style
- Don't introduce new dependencies without justification
- Add type safety if project uses TypeScript
- Consider edge cases beyond just the failing test

### Phase 3: Verification

#### 3.1 Run Complete Test Suite
After all individual fixes, run the full test suite:

```bash
[test command] 2>&1
```

#### 3.2 Validate Results
Confirm:
- [ ] All tests pass
- [ ] No new failures introduced
- [ ] Test execution completes without errors
- [ ] Test coverage maintained or improved (if tracked)

#### 3.3 Handle Remaining Failures
If tests still fail:
- Analyze new or persistent failures
- Add new tasks to TodoWrite
- Continue fixing autonomously

### Phase 4: Finalization

#### 4.1 Summary Report
Provide a comprehensive summary:

```
## Test Fix Summary

**Initial State:**
- Total tests: X
- Passing: Y
- Failing: Z

**Final State:**
- Total tests: X
- Passing: X
- Failing: 0 ✓

**Fixes Applied:**
1. [Test name 1]: [What was fixed and why]
2. [Test name 2]: [What was fixed and why]
...

**Commits:**
- [commit hash 1]: [commit message]
- [commit hash 2]: [commit message]
...

**Changed Files:**
- path/to/file1.ts
- path/to/file2.spec.ts
...
```

#### 4.2 Commit Strategy
Use conventional commits for each fix or logical group:

```
test: fix [test name] - [issue resolved]
fix: resolve [bug] causing test failures
test: update [test] for new behavior
refactor: improve [component] to pass tests
```

**Commit frequency:** Commit after each successful fix or related group of fixes

## Output
- All tests passing
- Clear commit history showing each fix
- Summary report of what was fixed and why
- TodoWrite list fully completed

## Success Criteria

### Fix Complete When:
- [ ] All tests in the suite pass
- [ ] No regressions introduced
- [ ] All fixes committed with clear messages
- [ ] TodoWrite list shows all tasks completed
- [ ] Summary report provided to user

### Each Fix Should:
- [ ] Address the root cause, not just the symptom
- [ ] Follow project conventions and style
- [ ] Include appropriate test updates if needed
- [ ] Not break other passing tests
- [ ] Be committed with a descriptive message

## Notes

### Best Practices
- **Read before fixing:** Always examine both test and implementation files
- **Test isolation:** Run individual tests when possible to isolate issues
- **Think holistically:** Consider how changes affect the entire codebase
- **Preserve intent:** Understand why a test exists before modifying it
- **Document decisions:** If a fix is non-obvious, add comments

### Common Pitfalls to Avoid
- **Don't just update tests to pass:** Fix the underlying code issue if it's a real bug
- **Don't ignore warnings:** They often indicate deeper issues
- **Don't batch all fixes into one commit:** Separate logical fixes for clarity
- **Don't skip verification:** Always re-run tests after each fix
- **Don't assume:** Read error messages carefully and understand them fully

### When to Ask for Help
Only pause autonomous execution for:
- **Ambiguous requirements:** When a test's intent is unclear and multiple interpretations exist
- **Breaking changes:** When fixing a test requires changing public APIs or contracts
- **Test philosophy:** When unsure whether to fix code or update test expectations
- **Major refactoring:** When fixes would require significant architectural changes

### Framework-Specific Notes
- **Jest/Vitest:** Check for snapshot mismatches, mock issues, async timing
- **Pytest:** Look for fixture issues, parametrize problems, marker configuration
- **RSpec:** Check for shared examples, let bindings, before/after hooks
- **Go:** Look for table-driven test issues, interface mocks, goroutine leaks
- **Rust:** Check for lifetime issues, trait implementations, panic handling
