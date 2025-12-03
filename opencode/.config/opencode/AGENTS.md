# Global AI Agent Rules - Personal Preferences

These rules apply to all OpenCode sessions across all projects.

## Communication Style

- **Concise responses**: Be direct and to the point. Avoid unnecessary verbosity.
- **No emojis**: Unless explicitly requested, never use emojis in responses.
- **Technical accuracy**: Prioritize correctness over agreement. Challenge assumptions when necessary.
- **Structured output**: Use markdown formatting for clarity (code blocks, lists, headers).

## AI Agent Autonomy & Decision Making

### Understanding Verification (CRITICAL)

**For complex prompts (3+ steps, architectural changes, or ambiguous requests):**
1. **FIRST: Verify understanding** - Summarize what you're asking in plain language
2. **WAIT for confirmation** - Only proceed after you confirm we're aligned
3. **THEN: Show task plan** - Break down the approach (may use todo list)
4. **WAIT for approval** - Confirm the plan before starting work
5. **Finally: Execute** - Proceed through the steps

**For simple prompts (single straightforward task):**
- Proceed directly, explain as you go

**When in doubt about complexity:** Treat it as complex and verify understanding first.

### Two-Step Verification for Complex Tasks

**Step 1 - Understanding Check:**
- "Here's what I understand you're asking for..."
- State the goal and requirements in plain language
- Ask: "Is this correct?"
- ⚠️ DO NOT plan or start work yet

**Step 2 - Approach Confirmation (only after Step 1 confirmed):**
- "Here's how I plan to approach this..."
- Show breakdown (create todo list for multi-step work)
- Highlight any decisions or trade-offs
- Ask: "Should I proceed with this approach?"

### Proceed Automatically
- Running read-only operations (tests, builds, git status, searches)
- Adding/improving documentation and comments
- Fixing obvious typos, linting, formatting issues
- Refactoring within a single function (no signature changes)
- Fixing trivial issues in files already being edited

### Ask Before Acting
- Installing or updating dependencies
- Creating new files or major structural changes
- Modifying function/method signatures
- Database operations or migrations
- Changing configuration files
- Security or authentication-related changes
- **Always before committing**: Show commit message and file list

### Always Confirm & Explain
- Deleting code or files
- Any destructive operations
- Changes that could affect production
- When request is ambiguous (ask clarifying questions immediately)

### Error Handling
- Explain what failed and likely cause
- Suggest alternatives
- Try obvious, safe fixes automatically
- Ask before attempting risky recovery

### Communication Style
- **After changes**: Briefly explain what changed and why
- **Scope creep**: Mention related issues; fix only trivial ones automatically
- **Ambiguity**: Always ask clarifying questions rather than assume

## Git Commit Guidelines

### The Golden Rule: Always Explain WHY

**CRITICAL:** Every commit message must explain **WHY** the change was made, not WHAT changed.
- ❌ BAD: "add validation to user model"
- ❌ BAD: "update authentication logic"
- ✅ GOOD: "add validation to prevent duplicate emails in database"
- ✅ GOOD: "fix authentication to handle expired tokens correctly"

The code diff shows WHAT changed. The commit message must answer:
- Why was this change necessary?
- What problem does it solve?
- What was the motivation?

### Commit Message Format

Use conventional commits format:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Subject line (required):**
- Focus on the WHY or the problem being solved
- Use imperative mood ("add" not "added" or "adds")
- Don't capitalize first letter
- No period at the end
- Max 50 characters
- Be specific and meaningful

**Body (use when subject alone doesn't explain WHY):**
- Explain the motivation and reasoning
- Describe the problem being solved
- Explain why this approach was chosen
- Include context that won't be obvious from code
- Wrap at 72 characters

**Types:**
- `feat`: New feature for the user
- `fix`: Bug fix for the user
- `docs`: Documentation changes
- `refactor`: Code restructuring without behavior change
- `perf`: Performance improvement
- `test`: Adding or updating tests
- `chore`: Maintenance (dependencies, tooling)
- `style`: Formatting only (no logic change)

### Commit Strategy

**Atomic commits:**
- Each commit = one logical change with one clear WHY
- Should be independently revertable
- Should pass tests (don't break the build)

**When to split commits:**
- Different WHYs = different commits
- Feature + unrelated refactoring → 2 commits (refactor first, then feature)
- Multiple unrelated fixes → separate commits (each has its own WHY)
- Large feature → break into logical steps with clear purpose for each

**When to combine:**
- Same WHY = one commit
- Fix + test for that fix → one commit (WHY: fix the bug)
- Feature + documentation for that feature → one commit
- Refactoring that directly enables the feature → one commit

### Commit Approval Process

**Before committing, I will always:**
1. Show the proposed commit message (emphasizing the WHY)
2. List all files to be included
3. Explain the reasoning for commit boundaries (if multiple commits)
4. Wait for your approval or modifications

**I will be rejected if:**
- The message doesn't clearly explain WHY
- The message is generic or vague
- Multiple unrelated WHYs are in one commit

### Examples - Focus on WHY

```
feat(auth): add password reset functionality

Users were locked out when forgetting passwords, requiring admin
intervention. This implements self-service password reset via
email tokens that expire after 1 hour for security.

Closes #123
```

```
refactor(users): extract validation logic to concern

Validation logic was duplicated across User and AdminUser models.
Extracting to a concern enables sharing validation rules and
maintains consistency across user types.
```

```
fix(api): return 422 for missing required parameters

API was returning 500 errors for missing parameters, making it
impossible for clients to distinguish between client errors and
server errors. Now returns proper 422 with clear error messages.
```

```
perf(dashboard): add database indexes for user queries

Dashboard page was timing out for users with many records (5+ seconds).
Adding composite index on (user_id, created_at) reduces query time
to under 100ms.
```

**Notice:** Every example clearly states the problem or motivation, not just what changed.

## Testing Philosophy & Practices

### Core Principles

**TDD Preferred:**
- Write tests first when possible (especially for new features and bug fixes)
- Red → Green → Refactor cycle
- Tests define the contract and expected behavior

**Pragmatic Testing:**
- Always add tests when the opportunity arises
- Existing code without tests → add them when touching that code
- If fixing a bug → write a failing test first, then fix

### Test Coverage Expectations

**Must have tests:**
- New features and functionality
- Bug fixes (regression tests)
- Public APIs and interfaces
- Business logic and critical paths
- Complex algorithms or calculations

**Lower priority for tests:**
- Simple getters/setters
- Configuration files
- View/presentation logic (unless complex)

### Test Types & When to Use

**Unit Tests:**
- Test individual methods/functions in isolation
- Fast, focused, no external dependencies
- Primary test type for business logic

**Integration Tests:**
- Test interaction between components
- Database interactions, API calls
- Critical user flows

**System/E2E Tests:**
- Test complete user workflows
- Use sparingly (slow, brittle)
- Focus on critical happy paths

### Testing Workflow

**For new features:**
1. Discuss the feature requirements
2. Write failing tests that define expected behavior
3. Implement the feature to make tests pass
4. Refactor with confidence (tests protect you)

**For bug fixes:**
1. Write a failing test that reproduces the bug
2. Fix the bug
3. Verify the test now passes
4. Prevents regression

**For refactoring:**
1. Ensure existing tests pass first
2. Refactor code
3. Tests should still pass (behavior unchanged)
4. Add tests if coverage gaps discovered

### Test Quality

**Good tests are:**
- **Readable:** Clear setup, action, assertion (Arrange-Act-Assert)
- **Fast:** Run quickly, enable rapid feedback
- **Independent:** Can run in any order, no shared state
- **Deterministic:** Same input always produces same result
- **Focused:** Test one thing, clear failure messages

**Avoid:**
- Testing implementation details
- Brittle tests that break on refactoring
- Tests that depend on external state
- Overly complex test setup

## Code Style & Conventions

### General
- **Clean code**: Prioritize readability and maintainability over cleverness.
- **Documentation**: Add comments for complex logic, but let code be self-documenting where possible.
- **Naming**: Use descriptive names; avoid abbreviations unless widely understood.

### Language-Specific

**Ruby / Rails:**
- Follow RuboCop guidelines and project's .rubocop.yml
- Use Ruby 3+ features appropriately (pattern matching, endless methods when clear)
- Prefer explicit over implicit (clear code over clever code)
- Use `frozen_string_literal: true`
- Rails conventions: fat models, skinny controllers → but prefer service objects for complex logic
- Use strong parameters in controllers
- Prefer ActiveRecord query interface over raw SQL (unless performance requires it)
- Name things clearly: `User.active` not `User.a`, `calculate_total` not `calc_tot`
- Use RSpec for tests (describe/context/it structure)
- Avoid n+1 queries (use includes/joins appropriately)

**Lua (Neovim):**
- Follow Neovim plugin conventions and style
- Use snake_case for functions and variables
- Prefer local variables (limit scope, better performance)
- Use `vim.api.*` for Neovim API calls
- Modular structure: separate concerns into logical files
- Use lazy loading for plugins when appropriate (lazy.nvim)
- Document non-obvious behavior with comments
- Return early pattern for guard clauses
- Prefer `vim.keymap.set` over legacy key mapping APIs

**Shell/Bash:**
- Use shellcheck-compliant code; quote variables; use `set -euo pipefail`
- Prefer modern tools (rg over grep, fd over find, bat over cat)

**Configuration files:**
- Maintain consistent formatting; add comments explaining non-obvious settings
- Validate syntax before writing (JSON, YAML, TOML, etc.)

## Workflow Preferences

### Before Making Changes
- **Ask first for critical files**: Configuration files, scripts that run on startup/boot
- **Show diffs**: When modifying existing files, explain what's changing and why
- **Verify context**: Read existing files to understand current implementation before suggesting changes

### Safety & Backups
- **Test commands**: When suggesting shell commands, explain what they do and potential side effects
- **Destructive operations**: Always warn before operations that delete/overwrite data
- **Symlink awareness**: Be careful with symlinked files (dotfiles managed by stow)

### Tool Preferences
- **Editor**: Primary: Neovim
- **Package managers**: Use appropriate manager for context (bun, npm, cargo, pacman, bundle, etc.)

## Learning & Adaptation

- **Ask for feedback**: When unsure about preferences, ask rather than assume
- **Update rules**: These rules should evolve; suggest updates when patterns emerge
- **Context retention**: Remember decisions made in the current session to maintain consistency

## Restrictions

- **No automatic pushes**: Never push to remote repositories without explicit instruction
- **No config corruption**: Validate syntax before writing config files
- **No breaking changes**: For system configs, verify changes won't break boot/login/display

## Personal Notes

- User: Diego
- System: Linux (Arch-based)
- Primary workflows: Ruby/Rails development, Neovim/Lua configuration
