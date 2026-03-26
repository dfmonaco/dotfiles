# Skill: git-worktree

Manage git worktrees with consistent naming and directory conventions. Use this skill whenever the user wants to create a worktree, work on a branch in isolation, set up a parallel working copy, list worktrees, remove or clean up worktrees, or mentions "worktree" in any context. Also use when the user says things like "I want to work on X without affecting my current branch" or "set up a separate copy for this feature".

---

## Why worktrees?

Git worktrees let you check out multiple branches of the same repository simultaneously in separate directories. Each worktree is a full working copy that shares the same `.git` object store -- no cloning, no duplicated history. This is useful when you want to:

- Work on a feature without stashing or losing context on your current branch
- Run tests on one branch while developing on another
- Compare behavior across branches side by side

## Directory convention

All worktrees live in a dedicated `worktrees/` directory that is a **sibling of the project's parent directory**. This keeps worktrees separated from main repos, avoids tool/watcher interference, and scales across multiple projects.

### Determining the worktrees path

```
project path:    /home/user/code/myapp
parent dir:      /home/user/code
worktrees dir:   /home/user/code/worktrees
```

In other words: `$(dirname <repo-root>)/worktrees/`

### Naming convention

Worktrees are named `{app}-{branch}`, where:
- `{app}` is the repository directory name (e.g., `obra`, `superpowers`)
- `{branch}` is the branch name, with `/` replaced by `-` (e.g., `feature/my-thing` becomes `feature-my-thing`)

Examples:
```
/home/user/code/worktrees/obra-my-rails-generator
/home/user/code/worktrees/obra-feature-catalog-export
/home/user/code/worktrees/superpowers-fix-login-bug
```

This convention makes it immediately clear which repo and branch a worktree belongs to, and works naturally with tab completion and `ls worktrees/obra-*`.

---

## Creating a worktree

### Gather information

Before creating a worktree, determine:

1. **App name** -- the basename of the current repo root (`basename $(git rev-parse --show-toplevel)`)
2. **Base branch** -- the branch to start from (the user should specify this; if not, ask and recommend `main` or `develop` depending on the project's branching model)
3. **New branch name** -- the name for the new branch to create in the worktree (the user should specify this)
4. **Worktrees directory** -- derived from the repo's parent: `$(dirname $(git rev-parse --show-toplevel))/worktrees`

### Steps

1. Confirm the plan with the user:
   ```
   Worktree path: <worktrees-dir>/<app>-<branch>
   New branch: <branch-name> (from <base-branch>)
   ```

2. Create the worktrees directory if it doesn't exist:
   ```bash
   mkdir -p <worktrees-dir>
   ```

3. Create the worktree with a new branch:
   ```bash
   git worktree add -b <new-branch> <worktrees-dir>/<app>-<new-branch> <base-branch>
   ```

   Or if the branch already exists:
   ```bash
   git worktree add <worktrees-dir>/<app>-<branch> <branch>
   ```

4. Verify the worktree was created:
   ```bash
   git worktree list
   ```

5. Tell the user the full path so they can open it in their editor or switch to it.

### Important notes

- The worktree shares the git object store with the main repo. Commits made in either location are visible to both.
- You cannot check out the same branch in two worktrees simultaneously. If the user wants to work on a branch that's already checked out, they need to either switch the original worktree to a different branch or create a new branch.
- Dependencies (node_modules, bundle, etc.) are NOT shared. The user will need to run install commands in the new worktree.

---

## Listing worktrees

```bash
git worktree list
```

This shows all worktrees for the current repo, their paths, HEAD commits, and branch names. Run this from any worktree of the repo.

---

## Removing a worktree

### Steps

1. Confirm which worktree to remove (list them first if needed)

2. Remove the worktree:
   ```bash
   git worktree remove <worktree-path>
   ```

   If the worktree has uncommitted changes, git will refuse. The user can force removal with:
   ```bash
   git worktree remove --force <worktree-path>
   ```

3. Optionally delete the branch if it's no longer needed:
   ```bash
   git branch -d <branch-name>
   ```

4. Verify:
   ```bash
   git worktree list
   ```

### Cleaning up stale worktrees

If a worktree directory was manually deleted (e.g., `rm -rf`), git still tracks it. Clean up with:

```bash
git worktree prune
```

This removes worktree references for directories that no longer exist on disk.

---

## Checking if the worktrees directory is empty

After removing the last worktree for all repos, the `worktrees/` directory may be empty. Mention this to the user so they can remove it if they want:

```bash
rmdir <worktrees-dir>  # only succeeds if empty
```
