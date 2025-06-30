# AI Agent Global Context - Development Guidelines

## Personal Preferences

### Editor Configuration
- **Preferred editor:** Neovim

### Session Management
- At the start of any project session, check for a `docs/dev_sessions` directory
- If it exists, locate the most recent dev session summary file
- Use the content from this file as additional context to continue work from the 
  previous session

## Documentation Standards

### Markdown Guidelines
- **Maximum line length:** 80 characters
- **Header hierarchy:** Maintain proper nesting structure
  - Use only one H1 (`#`) per document
  - Ensure correct nesting progression (H1 → H2 → H3, etc.)
  - Do not skip header levels

## Git Workflow

This section outlines the Git branching strategy for the SayZen project. 
Following this workflow ensures a clean, manageable, and stable codebase.

### Branching Model

We use a simplified GitFlow model with the following primary branches:

#### Main Branch (`main`)
- **Purpose:** Single source of truth for production code
- **Requirements:** Must always be stable and deployable
- **Rules:** 
  - Direct commits are prohibited
  - Changes merged only from `develop` or `hotfix` branches after review

#### Development Branch (`develop`)
- **Purpose:** Primary integration branch for ongoing development
- **Content:** Contains code for the next release
- **Rules:**
  - Feature branches merge into `develop`
  - When stable and ready, `develop` merges into `main` for release

#### Feature Branches
- **Purpose:** Develop new features in isolation to keep `develop` clean
- **Naming convention:** `feature/<short-description>`
  - Example: `feature/pwa-foundations`
- **Workflow:**
  1. Create new feature branch from `develop`
  2. Work and commit changes on the feature branch
  3. Once complete and tested, open pull request to merge into `develop`

#### Hotfix Branches
- **Purpose:** Quick patches for critical bugs in production (`main` branch)
- **Naming convention:** `hotfix/<short-description>`
  - Example: `hotfix/fix-login-bug`
- **Workflow:**
  1. Create hotfix branch from `main`
  2. Implement and commit the fix
  3. Merge hotfix branch into **both** `main` and `develop`
     - `main`: Deploy the fix to production
     - `develop`: Ensure fix is included in future releases

### Development Flow Summary

- **New Feature:** `develop` → `feature/my-feature` → `develop` → `main` 
  (for release)
- **Production Bug Fix:** `main` → `hotfix/my-fix` → `main` AND `develop`

## Commit Message Standards

### Format Structure
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type (Required)
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation-only changes
- `style`: Code formatting changes (whitespace, formatting, no logic changes)
- `refactor`: Code restructuring without fixing bugs or adding features
- `perf`: Performance improvements
- `test`: Adding or correcting tests
- `build`: Build system or external dependency changes
- `ci`: CI configuration and script changes
- `chore`: Miscellaneous changes (no source or test file modifications)
- `revert`: Reverting a previous commit

### Scope (Optional)
- Specifies the affected codebase area
- Examples: `auth`, `database`, `ci`, `ui`

### Subject (Required)
- **Length:** 50-72 characters maximum
- **Style:** Imperative mood (e.g., "add", "change", "fix")
- **Format:** Start with lowercase letter, no ending period
- **Purpose:** Concise summary of the change

### Body (Optional, Recommended for Complex Changes)
- **Separation:** Blank line between subject and body
- **Content:** Explain the "why" - problem solved and approach taken
- **Style:** Imperative mood
- **Format:** Wrap lines at 72 characters

### Footer (Optional)
- **Issue references:** `Closes #123`, `Fixes #456`
- **Breaking changes:** `BREAKING CHANGE: <description>`

### Example Commit Messages

```
feat(auth): add OAuth2 integration

Implement Google OAuth2 authentication to replace custom login system.
This reduces security maintenance burden and improves user experience
with single sign-on capability.

Closes #145
```

```
fix(database): resolve connection timeout issues

Increase connection pool size and implement retry logic for failed
database connections during high traffic periods.

Fixes #234
```
