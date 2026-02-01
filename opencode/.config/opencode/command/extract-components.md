---
description: Extract UI components from a file interactively, one component at a time
---

# Extract Components

## Objective
Analyze a file and extract reusable UI components in an interactive, iterative way. Suggest one component at a time, verify against existing component library, and extract only after user approval.

## Input
Optional file path argument: `$1`
- If provided: Use that file
- If not provided: Ask user which file to work on

## Core Principles
- **One component at a time:** Never batch multiple extractions
- **Library-aware:** Always check existing components before suggesting extraction
- **User-driven:** Require explicit approval before each extraction
- **Framework-agnostic:** Auto-detect framework from file
- **Justification-first:** Explain benefits before implementing
- **No auto-commit:** User controls git workflow

## Process

### Phase 1: Setup

#### 1.1 Determine Target File
If `$1` is provided:
- Verify file exists using file system check
- If file not found: Display error and exit
- Use that file

If `$1` is empty:
- Ask user: "Which file should I analyze for component extraction?"
- Verify provided file exists
- If invalid: Re-prompt up to 3 times with error message
- After 3 failed attempts: Exit with clear error message

#### 1.2 Detect Framework
Analyze file to determine framework:
- **React:** `.jsx`, `.tsx`, imports from `react`
- **Vue:** `.vue`, `<template>` tags
- **Svelte:** `.svelte`, `<script>` and `<style>` tags
- **Angular:** `.component.ts`, `@Component` decorator
- **Web Components:** `customElements.define`
- **Other:** Generic HTML/template detection

Display detected framework to user.

### Phase 2: Discovery

#### 2.1 Analyze File for Extractable Components
Read the file and identify extraction opportunities:

**Look for:**
- Repeated JSX/template patterns (used 2+ times)
- Complex inline structures (3+ levels of nesting, 10+ lines)
- Logical UI units with clear boundaries (forms, cards, modals, lists)
- Conditional rendering blocks that could be isolated
- Reusable UI elements (buttons, inputs, badges, avatars)
- Feature-rich sections (search bars, filters, pagination)

**Prioritize by:**
1. **Duplication:** Exact or near-exact repeated patterns
2. **Complexity:** Reduces parent component cognitive load
3. **Reusability:** Likely to be used elsewhere
4. **Maintainability:** Easier to test and modify in isolation

#### 2.2 Rank Components
Create internal list of all extractable components, ranked by priority (highest first).

Display summary to user:
```
Found [N] extractable components in [filename]:

1. [Component name] - [One-line reason: duplication/complexity/reusability]
2. [Component name] - [One-line reason]
...

I'll suggest these one at a time. Let's start with the first one.
```

### Phase 3: Component Extraction Loop

For each component in the prioritized list:

#### 3.1 Present Component Suggestion

```markdown
## Component Suggestion [N]/[TOTAL]: [ComponentName]

**What it is:**
[1-2 sentence description of what this component does]

**Why extract it:**
- [Specific benefit 1: e.g., "Duplicated 3 times in this file"]
- [Specific benefit 2: e.g., "Reduces parent component by 50 lines"]
- [Specific benefit 3: e.g., "Can be reused in UserProfile and AdminPanel"]

**Location in file:**
Lines [X-Y] (and lines [A-B], [C-D] if duplicated)

**Code to extract:**
```[language]
[Show the actual code block that would be extracted - 10-20 lines max]
```

Checking existing component library...
```

#### 3.2 Search Existing Component Library

Search project for existing similar components using glob patterns:
- `**/components/**/*.{jsx,tsx,vue,svelte}`
- `**/ui/**/*.{jsx,tsx,vue,svelte}`
- `**/lib/**/*.{jsx,tsx,vue,svelte}`

Search for:
- Similar component names (fuzzy match)
- Similar prop patterns
- Similar structure/complexity

**Decision tree:**
- **If exact match exists:** Recommend reusing existing component
- **If similar exists:** Recommend adapting existing component
- **If nothing similar:** Recommend creating new component

#### 3.3 Present Findings

```markdown
**Existing component check:**

[One of three outcomes:]

✓ **Found similar component:** `ComponentName` at `path/to/component.tsx`
  - [Brief comparison: what's similar, what's different]
  - **Recommendation:** Adapt this existing component by [specific changes needed]

✓ **Found related component:** `ComponentName` at `path/to/component.tsx`
  - [How it relates but differs]
  - **Recommendation:** [Reuse if possible / Create new if different enough]

✗ **No similar component found**
  - **Recommendation:** Create new component

---

**Proposed implementation:**
```[language]
[Show example of extracted component with props interface]
```

**Usage in original file:**
```[language]
[Show how the original code would be replaced with component usage]
```

---

**Decision:**
- Reply `extract` to create this component and update the file
- Reply `skip` to skip this extraction and move to the next
- Reply `adapt [component-name]` to use an existing component instead
- Reply `stop` to end the extraction session
```

#### 3.4 Handle User Response

**If `extract`:**
1. Create component file in appropriate location (follow project conventions)
2. Move code into component with proper props
3. Update original file to use new component
4. Add import statement
5. Run formatter if available
6. Mark as completed
7. Display summary and move to next component

**If `skip`:**
1. Mark as skipped
2. Move to next component

**If `adapt [component-name]`:**
1. Read existing component
2. Show user what changes are needed to use it
3. Ask for confirmation
4. If confirmed: update original file to use existing component
5. Mark as completed
6. Move to next component

**If `stop`:**
1. Exit loop
2. Jump to Phase 4: Summary

#### 3.5 Extract Component (if approved)

**Determine component location:**
- Check project structure for existing component directories
- Common patterns: `src/components/`, `components/`, `src/ui/`, `lib/components/`
- If unclear, ask user: "Where should I save this component?"

**Create component file:**
- Follow framework conventions
- Include prop types/interfaces
- Add basic component structure
- Follow project naming conventions (PascalCase, kebab-case, etc.)

**Update original file:**
- Replace extracted code with component usage
- Add import statement at top
- Pass appropriate props
- Preserve any unique identifiers or callbacks

**Run formatter (if available):**
Check if project has a formatter configured (package.json scripts, prettier config, etc.)
- If formatter exists: Run it on modified files
- If formatter fails with genuine error: Log warning but continue
- If formatter not available: Skip formatting step

**Display extraction summary:**
```markdown
✓ **Component extracted successfully**

**Created:** `path/to/NewComponent.[ext]`
**Updated:** `path/to/original-file.[ext]`

**Changes:**
- Removed [N] lines from original file
- Created new component with [M] lines
- Added import statement

Moving to next component...
```

#### 3.6 Repeat or Complete

If more components remain: Return to step 3.1

If all components processed: Continue to Phase 4

### Phase 4: Summary

Display final summary:

```markdown
## Extraction Session Complete

**File analyzed:** `path/to/file.[ext]`
**Framework detected:** [React/Vue/Svelte/etc.]

**Results:**
- Components extracted: [N]
- Components skipped: [M]
- Components adapted from existing: [K]

**Extracted components:**
1. `ComponentName` → `path/to/Component.[ext]`
2. `ComponentName` → `path/to/Component.[ext]`
...

**Skipped:**
1. `ComponentName` - [reason if provided]
...

**Next steps:**
- Review the extracted components
- Test the original file to ensure functionality is preserved
- Commit changes when ready
- Run `/extract-components [another-file]` to continue extraction in other files

**Git status (if in git repository):**
Display current git status to show modified/created files. If not in a git repository, skip this section.
```

## Output
- Extracted components in appropriate directories
- Original file updated with component imports and usage
- No automatic commits (user controls git workflow)
- Clear summary of all actions taken

## Success Criteria
- [ ] User approved each extraction explicitly
- [ ] Existing component library checked before each extraction
- [ ] Components follow project conventions
- [ ] Original file functionality preserved
- [ ] Clear summary provided

## Notes
- This command does NOT create git commits automatically
- Run the command multiple times for multiple files
- Framework detection is best-effort; user can override if incorrect
- Component location follows project conventions; asks user if unclear
