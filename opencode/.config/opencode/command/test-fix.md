---
description: Run project tests and autonomously fix failing ones
---

# Test Fix

## Objective
Execute the project's test suite, identify failing tests, and autonomously fix them. Continue until all tests pass.

## Input
Optional `$ARGUMENTS`:
- Empty: Run all tests
- Specific test path/pattern: Run subset of tests (e.g., "src/auth", "test/unit")

## Core Principles
- **Autonomous:** Fix tests without asking permission, only pause for ambiguous requirements
- **Root cause:** Fix underlying issues, not just symptoms
- **No regressions:** Ensure fixes don't break other tests
- **Tracked:** Use TodoWrite to maintain visible progress

## Process

### Phase 1: Discovery

#### 1.1 Branch Setup
```bash
git branch --show-current
```

- **If on `main`/`master`/`develop`:** Create `fix/failing-tests` branch
- **If on feature/fix branch:** Stay on current branch

#### 1.2 Identify Test Command
Check AGENTS.md or package.json for test command (npm test, pytest, cargo test, etc.)

#### 1.3 Run Tests (Non-Verbose)
```bash
[test command] 2>&1
```

Run WITHOUT verbose flags first for quick feedback. Only use verbose mode when error details are insufficient.

#### 1.4 Analyze & Plan
Parse output to identify:
- Total tests, passing, failing
- Group related failures

Create TodoWrite tasks:
```
- Fix: [TestName] - [error summary] (path/to/test.spec.ts)
- Verify: Run full test suite
```

### Phase 2: Fix Tests

For each failing test:

1. **Mark as in_progress** (TodoWrite)
2. **Analyze error:**
   - Read test file and implementation
   - Identify root cause
   - Re-run with verbose only if needed
3. **Determine fix strategy:**
   - Code bug → Fix implementation
   - Outdated test → Update test (only if behavior change is intentional)
   - Missing setup → Add mocks/fixtures
4. **Implement fix** following project conventions
5. **Verify:** Run specific test to confirm fix
6. **Commit:**
   ```bash
   git commit -m "test: fix [test name] - [brief explanation]"
   ```
7. **Mark as completed** (TodoWrite)

**Handle cascading failures:** If multiple tests fail for same reason, fix root cause once, then verify all affected tests.

### Phase 3: Verification

Run full test suite (non-verbose):
```bash
[test command] 2>&1
```

Confirm:
- [ ] All tests pass
- [ ] No regressions introduced

If failures remain, add new tasks and continue fixing.

### Phase 4: Summary

```markdown
## Test Fix Summary

**Initial State:** X total, Y passing, Z failing
**Final State:** X total, X passing, 0 failing ✓

**Fixes Applied:**
1. [Test name]: [What was fixed]
...

**Commits:**
- [hash]: [message]
...
```

## Output
- All tests passing
- Clear commit history
- Summary report
- TodoWrite list completed

## Success Criteria
- [ ] All tests pass
- [ ] No regressions
- [ ] Fixes committed with clear messages
- [ ] Summary provided

## When to Pause
Only stop for:
- Ambiguous test intent (multiple valid interpretations)
- Breaking changes to public APIs
- Major architectural decisions required
