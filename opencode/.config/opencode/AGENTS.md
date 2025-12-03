# Global AI Agent Rules - Personal Preferences

These rules apply to all OpenCode sessions across all projects.

## Communication Style

- **Concise responses**: Be direct and to the point. Avoid unnecessary verbosity.
- **Technical accuracy**: Prioritize correctness over agreement. Freely challenge assumptions, proposals, and approaches when you identify better alternatives or potential issues.
- **No blind agreement**: Avoid phrases like "great idea" or "you're right" without critical evaluation. If you see problems or better alternatives, say so directly.
- **Structured output**: Use markdown formatting for clarity (code blocks, lists, headers).

## AI Agent Autonomy & Decision Making

### Understanding Verification (CRITICAL)

**For complex prompts (3+ steps, architectural changes, or ambiguous requests):**

**Step 1 - Understanding Check:**
- Say: "Here's what I understand you're asking for..."
- Summarize the goal and requirements in plain language
- Ask: "Is this correct?"
- ⚠️ DO NOT plan or start work yet

**Step 2 - Approach Confirmation (only after Step 1 confirmed):**
- Say: "Here's how I plan to approach this..."
- Show task breakdown (create todo list for multi-step work)
- Highlight any decisions or trade-offs
- Ask: "Should I proceed with this approach?"

**For simple prompts (single straightforward task):**
- Proceed directly, explain as you go

**When in doubt about complexity:** Treat it as complex and verify understanding first.

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
- Deleting code or files
- Any destructive operations
- Changes that could affect production
- When request is ambiguous (ask clarifying questions immediately)
- **Always before committing**: Show commit message and file list

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

### Example - Focus on WHY

```
fix(api): return 422 for missing required parameters

API was returning 500 errors for missing parameters, making it
impossible for clients to distinguish between client errors and
server errors. Now returns proper 422 with clear error messages.
```

## Git Branching Flow

### Branch Strategy

**Production Branches:**
- `master`: Production-ready, always deployable
- `develop`: Development branch, default for branching

**Working Branches:**
- `feature/`: New features
- `fix/`: Bug fixes
- `chore/`: Maintenance tasks

**Branch Naming:**
- Use conventional prefixes: `feature/`, `fix/`, `chore/`
- Descriptive kebab-case names: `feature/user-authentication`
- Include issue/ticket numbers when applicable: `fix/123-login-redirect`

### Standard Workflow (Features, Fixes, Chores)

**Agent should automatically:**
1. Create branch from `develop` with appropriate name
2. Make atomic commits (following commit guidelines)
3. Push branch to remote for backup
4. Create GitHub PR with auto-generated title and description
5. Use merge commit strategy (not squash or rebase)
6. Delete local and remote branch after merge

**Example:**
```bash
# Agent automatically:
git checkout develop
git pull origin develop
git checkout -b feature/payment-integration
# ... work and commits ...
git push -u origin feature/payment-integration
gh pr create --base develop --title "..." --body "..."
# After merge:
git branch -d feature/payment-integration
git push origin --delete feature/payment-integration
```

### Hotfix Workflow (Urgent Production)

**For critical production issues:**
1. Branch from `master`: `hotfix/critical-issue`
2. Make fix commits
3. Create PR against `master` (not develop)
4. After merge to `master`, merge `master` back into `develop`
5. Delete hotfix branch

**Example:**
```bash
# Agent automatically:
git checkout master
git pull origin master
git checkout -b hotfix/payment-crash
# ... fix commits ...
gh pr create --base master --title "..." --body "..."
# After merge:
git checkout develop
git merge master  # Sync fix back to develop
git branch -d hotfix/payment-crash
```

### Trivial Changes (No Branch Required)

**Commit directly to `develop` for:**
- Typo fixes
- Documentation updates (README, comments)
- Formatting/linting only changes
- Single-line config tweaks

**Everything else requires a branch.**

### PR Title & Description

**Agent should auto-generate:**
- **Title**: Use the primary commit message (with WHY)
- **Description**: Summarize commits, include motivation/context
- Follow same "explain WHY" principle as commits

**Example PR:**
```
Title: add rate limiting to prevent API abuse

Description:
- Implements token bucket algorithm for API endpoints
- Prevents abuse that was causing service degradation
- Configurable limits per endpoint (default: 100 req/min)

Fixes #123
```

### Branch Deployment Sync

- `develop` → `master` sync only when ready to deploy/release
- Not automatic after every feature merge
- Coordinate timing for production deployments

## Testing Philosophy & Practices

### Core Principles

**TDD Preferred:**
- Write tests first when possible (especially for new features and bug fixes)
- Red → Green → Refactor cycle
- Always add tests when the opportunity arises

**For bug fixes:**
- Write a failing test that reproduces the bug first
- Then fix the bug
- Prevents regression

**Good tests are:**
- Readable (Arrange-Act-Assert)
- Fast and independent
- Deterministic and focused

## Workflow Preferences

### Before Making Changes
- **Ask first for critical files**: Configuration files, scripts that run on startup/boot
- **Show diffs**: When modifying existing files, explain what's changing and why
- **Verify context**: Read existing files to understand current implementation before suggesting changes

### Safety & Backups
- **Test commands**: When suggesting shell commands, explain what they do and potential side effects
- **Destructive operations**: Always warn before operations that delete/overwrite data
- **Symlink awareness**: Be careful with symlinked files (dotfiles managed by stow)

## Learning & Adaptation

- **Ask for feedback**: When unsure about preferences, ask rather than assume
- **Update rules**: These rules should evolve; suggest updates when patterns emerge
- **Context retention**: Remember decisions made in the current session to maintain consistency

## Restrictions

- **No automatic pushes**: Never push to remote repositories without explicit instruction
- **No config corruption**: Validate syntax before writing config files
- **No breaking changes**: For system configs, verify changes won't break boot/login/display
