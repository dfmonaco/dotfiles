---
description: Analyze codebase and identify top 3 refactoring opportunities
---

# Analyze Refactor Opportunities

## Objective
Scan the codebase (or a specific scope) and identify the top 3 most valuable refactoring opportunities, ranked by payoff.

## Philosophy
This command is a **discovery tool**, not a task generator. It surfaces technical debt and improvement opportunities to help you decide where to focus refactoring efforts.

- Focus on **what** needs improvement and **why** it matters
- Do NOT provide implementation details — that's the job of `/tasks/refactor`
- Prioritize by payoff: maintainability, extensibility, consistency, performance, readability

## Role
Act as a Senior Software Engineer performing a code health assessment. Be objective, specific, and actionable.

## Process

### 1. Determine Scope
Check if a scope argument was provided: `<arg1>`

If scope is provided:
- Confirm the scope exists and is valid
- Focus analysis on that area only

If no scope provided:
- Analyze the full codebase
- Exclude common non-source directories (node_modules, vendor, dist, build, .git, etc.)

Display: "Analyzing: [full codebase | specified scope]"

### 2. Codebase Analysis
Scan the codebase looking for:

**Code Smells:**
- Duplicated code / copy-paste patterns
- Long functions or files (God objects)
- Deep nesting / complex conditionals
- Inconsistent naming conventions
- Dead code or unused exports

**Structural Issues:**
- Circular dependencies
- Tight coupling between modules
- Mixed responsibilities (violation of SRP)
- Inconsistent patterns across similar components
- Missing abstractions or over-abstraction

**Maintainability Concerns:**
- Lack of separation between layers (UI/business/data)
- Hard-coded values that should be configurable
- Missing or outdated types/interfaces
- Inconsistent error handling patterns

**Technical Debt Indicators:**
- TODO/FIXME/HACK comments
- Workarounds with explanatory comments
- Deprecated dependencies or patterns
- Test coverage gaps in critical paths

### 3. Rank Opportunities
For each identified issue, evaluate:

1. **Payoff** (High/Medium/Low)
   - How much does fixing this improve the codebase?
   - Does it unblock other improvements?
   - Does it reduce future maintenance burden?

2. **Effort** (Small/Medium/Large)
   - How many files/lines are affected?
   - How risky is the change?
   - Are there dependencies on this code?

3. **Priority Score** = Payoff vs Effort ratio
   - High payoff + Small effort = Quick win (prioritize)
   - High payoff + Large effort = Strategic investment
   - Low payoff + Large effort = Avoid

Select the **top 3** opportunities with the best priority scores.

### 4. Generate Output
Create the analysis document with this structure:

```markdown
# Refactor Opportunities

**Generated:** [ISO 8601 timestamp]
**Scope:** [full codebase | specified scope path]

---

## 1. [Problem Title]

**Problem:** [1-2 sentence description of the specific issue]

**Location:** [file paths or module names affected]

**Payoff:** [What you gain by fixing this — be specific]

**Effort:** [Small | Medium | Large] — [brief justification]

---

## 2. [Problem Title]

**Problem:** [1-2 sentence description]

**Location:** [file paths or module names affected]

**Payoff:** [What you gain]

**Effort:** [Small | Medium | Large] — [brief justification]

---

## 3. [Problem Title]

**Problem:** [1-2 sentence description]

**Location:** [file paths or module names affected]

**Payoff:** [What you gain]

**Effort:** [Small | Medium | Large] — [brief justification]

---

## Next Steps

To proceed with a refactoring, run:
\`\`\`
/tasks/refactor [describe the chosen refactor]
\`\`\`

Example:
\`\`\`
/tasks/refactor Extract duplicated validation logic into shared utilities
\`\`\`
```

### 5. Ensure Output Directory Exists
```bash
mkdir -p .opencode/analysis
```

### 6. Ensure .opencode is Gitignored
```bash
if [ -f .gitignore ]; then
  if ! grep -q "^\.opencode/$" .gitignore && ! grep -q "^\.opencode$" .gitignore; then
    echo "" >> .gitignore
    echo "# OpenCode local files" >> .gitignore
    echo ".opencode/" >> .gitignore
  fi
else
  echo "# OpenCode local files" > .gitignore
  echo ".opencode/" >> .gitignore
fi
```

### 7. Save Analysis
Save the generated document to: `.opencode/analysis/refactor-opportunities.md`

### 8. Display Summary
Print a summary to the conversation:

```
Refactor Analysis Complete

Scope: [full codebase | scope]
Found 3 refactoring opportunities:

1. [Problem Title] — Effort: [Small|Medium|Large]
2. [Problem Title] — Effort: [Small|Medium|Large]
3. [Problem Title] — Effort: [Small|Medium|Large]

Full analysis saved to: .opencode/analysis/refactor-opportunities.md

To proceed: /tasks/refactor [describe chosen refactor]
```

## Output
- Analysis saved to: `.opencode/analysis/refactor-opportunities.md`
- Summary displayed in conversation
- Ready to feed into `/tasks/refactor`

## Usage Examples
```bash
# Analyze full codebase
/analyze/refactor

# Analyze specific directory
/analyze/refactor src/api

# Analyze test files only
/analyze/refactor tests/

# Analyze a specific module
/analyze/refactor src/components/auth
```
