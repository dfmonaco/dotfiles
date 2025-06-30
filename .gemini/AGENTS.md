# Gemini Added Memories

- My preferred editor is neovim
- When starting a session on any project, if a `docs/dev_sessions` directory
  exists, I will find the most recent dev_session summary file within it and
  use its content for additional context to continue the work from the last
  session.

## Git Workflow

This document outlines the Git branching strategy for the SayZen project.
Following this workflow ensures a clean, manageable, and stable codebase.

## Branching Model

We use a simplified GitFlow model with the following primary branches:

- `main`: Represents the production-ready, stable codebase.
- `develop`: The primary development branch for integrating completed
  features.

### 1. `main` Branch

- **Purpose:** This branch is the single source of truth for production code.
  It should always be stable and deployable.
- **Rule:** Direct commits to `main` are not allowed. Changes are merged from
  the `develop` or `hotfix` branches after review.

### 2. `develop` Branch

- **Purpose:** This is the main integration branch for ongoing development.
  It contains the code for the next release.
- **Rule:** Feature branches are merged into `develop`. When `develop` is
  stable and ready for a release, it is merged into `main`.

### 3. Feature Branches

- **Purpose:** Used to develop new features in isolation, keeping the `develop`
  branch clean.
- **Naming Convention:** `feature/<short-description>` (e.g.,
  `feature/pwa-foundations`)
- **Workflow:**
  1. Create a new feature branch from `develop`.
  2. Work and commit your changes on this branch.
  3. Once the feature is complete and tested, open a pull request to merge it
     back into `develop`.

### 4. Hotfix Branches

- **Purpose:** Used to quickly patch critical bugs discovered in the `main`
  (production) branch.
- **Naming Convention:** `hotfix/<short-description>` (e.g.,
  `hotfix/fix-login-bug`)
- **Workflow:**
  1. Create a hotfix branch from `main`.
  2. Implement and commit the fix.
  3. Merge the hotfix branch back into *both* `main` (to deploy the fix) and
     `develop` (to ensure the fix is included in future releases).

## Summary of Flows

- **New Feature Development:**
  `develop` → `feature/my-feature` → `develop` → `main` (for release)

- **Production Bug Fix:**
  `main` → `hotfix/my-fix` → `main` AND `develop`
