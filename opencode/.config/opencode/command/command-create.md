---
description: Interactive command generator for creating well-structured OpenCode commands
---

# Command Create

## Objective
Interactively design and generate new OpenCode commands that follow best practices, maintain consistency with existing commands, and include all necessary documentation and structure.

## Input
Optional command name via `$ARGUMENTS`. If not provided, will ask interactively.

## OpenCode Commands Reference

### Command Structure (Markdown Format)

All commands are markdown files with YAML frontmatter and structured content:

```markdown
---
description: Brief description shown in TUI
agent: optional-agent-name
model: optional-model-override
subtask: true/false (optional)
---

# Command Name

## Objective
[Clear statement of what this command does]

## Process
[Detailed implementation steps]

## Output
[What gets produced]

## Success Criteria
[Measurable completion criteria]
```

### Key Concepts

**Frontmatter Options:**
- `description`: (Required) Brief description shown in command list
- `agent`: (Optional) Which agent executes this command
- `model`: (Optional) Override default model (e.g., "anthropic/claude-3-5-sonnet-20241022")
- `subtask`: (Optional) Force subagent invocation if true

**Template Variables:**
- `$ARGUMENTS`: All arguments as single string
- `$1`, `$2`, `$3`, etc.: Individual positional arguments
- `!`command``: Inject bash command output
- `@filename`: Include file content

**File Location:**
- Global: `~/.config/opencode/command/`
- Per-project: `.opencode/command/`
- This repository: `./opencode/.config/opencode/command/`

**Naming Convention:**
- Lowercase with hyphens (e.g., `feature-plan.md`, `task-implement.md`)
- Descriptive but concise (2-4 words)
- Should match command invocation (e.g., `/feature-plan`)

## Command Style & Tone Guide

Based on analysis of existing commands, follow these patterns:

### Structure Patterns

**1. Planning Commands** (bug-plan, feature-plan, refactor-plan):
- Begin with Discovery phase (ask user to describe)
- Include Clarification phase (restate understanding, ask questions, provide proposed answers)
- Include Draft phase (generate structured document)
- Include Git Setup phase (create branch)
- Include Save phase (save to specific location)
- Include Commit phase (commit with conventional format)
- End with Success Criteria checklist

**2. Execution Commands** (task-implement):
- Begin with input/detection logic
- Include multi-phase structure (Planning, Implementation, Validation, Review)
- Heavy emphasis on autonomy (do NOT ask for permission)
- Include sequential task execution pattern
- Include conventional commit strategy
- Include testing requirements by task type
- End with comprehensive success criteria

**3. Utility Commands** (prompt-create, prompt-run):
- Begin with clear objective
- Include intelligent analysis/decision logic
- Include interactive confirmation flows
- Include output decision trees
- Include meta-instructions for self-reference

### Tone Characteristics

**Be:**
- **Explicit**: Use clear, unambiguous instructions
- **Directive**: Tell agent exactly what to do, step by step
- **Professional**: Focus on deliverables and quality
- **Structured**: Use consistent heading hierarchy
- **Autonomous**: Minimize back-and-forth; make decisions based on best practices

**Avoid:**
- Vague instructions like "improve" without specifics
- Asking permission for standard operations
- Conversational tone; maintain technical documentation style
- Redundant explanations; be concise but complete

### Section Standards

**## Objective**
- 1-3 sentences max
- State what gets produced
- Mention who it's for (if relevant)
- Include quality standard

**## Role & Standards** (for planning commands)
- State the persona (e.g., "Senior Software Engineer")
- State the audience (e.g., "Junior Developer")
- List 2-4 key standards (Tone, Quality, Format)

**## Process**
- Use numbered phases (### 1. Discovery, ### 2. Clarification)
- Within phases, use numbered or bulleted sub-steps
- Include bash commands in code blocks with comments
- Include example outputs where helpful
- Use **bold** for important notes

**## Output**
- Bulleted list of deliverables
- Include file paths, branch names, command results
- Include status updates (e.g., "Ready for implementation via...")

**## Success Criteria**
- Checklist format with `- [ ]`
- Measurable, specific criteria
- Typically 5-10 items
- Cover completeness, correctness, and process adherence

**## Notes** (optional)
- Tips, guidelines, or reference material
- Common patterns or anti-patterns
- Examples of edge cases

## Interactive Design Process

### Phase 1: Command Discovery

Ask the user to describe the command they want to create:

**Questions:**
1. What should this command do? (Main objective)
2. What problem does it solve or what workflow does it enable?
3. When would someone use this command?
4. Does it take any arguments? If so, what?

**Wait for user response before proceeding.**

### Phase 2: Command Classification

Analyze the user's description and determine:

1. **Command Category:**
   - **Planning**: Creates planning documents (PRD, bug analysis, refactor plan)
   - **Execution**: Performs implementation work (code changes, testing, deployment)
   - **Utility**: Helper/tool command (analysis, code generation, automation)
   - **Hybrid**: Combines multiple categories

2. **Interaction Pattern:**
   - **Interactive**: Asks questions, confirms decisions, provides choices
   - **Autonomous**: Executes without interruption, makes decisions automatically
   - **Hybrid**: Interactive setup, autonomous execution

3. **Complexity Level:**
   - **Simple**: Single-phase, straightforward flow (1-3 main steps)
   - **Moderate**: Multi-phase with some conditional logic (4-6 main steps)
   - **Complex**: Multi-phase with discovery, branching, and state management (7+ steps)

### Phase 3: Clarification

Present your analysis to the user:

**Example:**
```
Based on your description, I understand you want to create:

**Command Name:** [suggested-name]
**Category:** [Planning/Execution/Utility/Hybrid]
**Interaction:** [Interactive/Autonomous/Hybrid]
**Complexity:** [Simple/Moderate/Complex]

This command will:
- [Key functionality 1]
- [Key functionality 2]
- [Key functionality 3]

**Clarifying Questions:**

1. **Arguments:** Should this command accept arguments? If yes:
   - What arguments? (e.g., file paths, task names, options)
   - Are they required or optional?
   - Suggested usage: `/command-name [argument]`

2. **File Operations:** Will this command:
   - Read existing files? Which ones?
   - Create new files? Where should they be saved?
   - Modify existing files?

3. **Git Integration:** Should this command:
   - Create a new branch?
   - Make commits?
   - Interact with remote (push, PR)?

4. **Agent/Model:** Should this command:
   - Use a specific agent? (e.g., build, plan, general)
   - Use a specific model?
   - Run as a subtask?

5. **Output Format:** What should this command produce:
   - A document? (Markdown, JSON, etc.)
   - Code changes?
   - Terminal output?
   - Status updates?

6. **Success Definition:** How do we know the command succeeded?
   - What must be true?
   - What checks should be performed?

**Proposed Answers** (based on best practices):
[Provide intelligent defaults for each question based on command category]

You can reply:
- 'Agree' to accept all proposed answers
- Specify changes to any answers
- Ask for clarification on any aspect
```

**Wait for user confirmation before proceeding.**

### Phase 4: Structure Design

Based on the confirmed details, design the command structure:

1. **Determine Section Structure:**
   - Required: Objective, Process, Output, Success Criteria
   - Optional: Role & Standards (for planning), Input, Notes, Examples

2. **Design Process Flow:**
   - Break down into logical phases
   - Within each phase, define specific steps
   - Identify decision points and branching logic
   - Include bash commands, file operations, git operations

3. **Define Variables and Templates:**
   - Which template variables are needed? ($ARGUMENTS, $1-$N, !`cmd`, @file)
   - What bash commands need to run?
   - What file patterns to use?

4. **Plan Output and Verification:**
   - What gets created/modified?
   - What success criteria apply?
   - What user feedback is needed?

### Phase 5: Present Structure Outline

Show the user the planned structure:

**Example:**
```
Command Structure Outline
========================

**Filename:** command-name.md
**Invocation:** /command-name [args]

**Frontmatter:**
---
description: [Brief description]
agent: [agent-name or omit]
model: [model-override or omit]
---

**Sections:**

## Objective
[1-2 sentence description]

## Input (if applicable)
[Description of arguments: $ARGUMENTS]

## Process

### Phase 1: [Discovery/Setup/Analysis]
[Steps 1-N]

### Phase 2: [Clarification/Implementation/Processing]
[Steps 1-N]

### Phase 3: [Draft/Execution/Validation]
[Steps 1-N]

[Additional phases as needed]

## Output
[List of deliverables]

## Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
[...]

## Notes (optional)
[Tips, examples, edge cases]

========================

Does this structure look correct? 
- Reply 'Yes' to proceed with generation
- Reply 'Modify' to adjust the structure
- Ask questions about any section
```

**Wait for user approval before proceeding.**

### Phase 6: Generate Command

Once approved, generate the full command following these rules:

**Writing Style:**
- Use imperative voice ("Create", "Analyze", "Generate")
- Be specific and actionable
- Include code examples for bash commands
- Use consistent formatting (see existing commands)
- Match the tone and depth of similar existing commands

**Content Guidelines:**
- **Objective**: Clear, 1-3 sentences, includes quality standard
- **Process**: Detailed, step-by-step, numbered phases with sub-steps
- **Bash Commands**: Include full commands with comments
- **Decision Logic**: Use bullet points or tables for branching logic
- **Examples**: Include where helpful for clarity
- **Success Criteria**: 5-10 measurable checklist items

**Quality Checks:**
- [ ] Frontmatter includes required `description`
- [ ] All sections use proper Markdown heading hierarchy (##, ###, ####)
- [ ] Process steps are clear and actionable
- [ ] Variables ($ARGUMENTS, $1, etc.) used correctly
- [ ] Git operations follow conventions (branch naming, commit format)
- [ ] File paths are explicit (e.g., ./docs/tasks/)
- [ ] Success criteria are measurable
- [ ] Tone matches existing commands

### Phase 7: Save and Confirm

1. **Determine Next Number:**
   Check existing commands to determine naming convention:
   ```bash
   ls -1 ./opencode/.config/opencode/command/*.md | tail -5
   ```

2. **Generate Filename:**
   - Format: `[command-name].md` (lowercase, hyphens)
   - Location: `./opencode/.config/opencode/command/[command-name].md`

3. **Save File:**
   Write the generated command to the file.

4. **Confirm to User:**
   ```
   ✓ Command created successfully!
   
   **Location:** ./opencode/.config/opencode/command/[command-name].md
   **Invocation:** /[command-name] [args]
   **Description:** [description from frontmatter]
   
   Next Steps:
   
   1. Test the command:
      - Restart OpenCode (or it should auto-reload)
      - Type /[command-name] in the TUI
      - Verify it appears in the command list (Ctrl+P)
   
   2. Iterate if needed:
      - Use /command-create again to create variations
      - Edit the file directly to refine
   
   3. Share or document:
      - Add to project documentation if useful for the team
      - Share the pattern if it's a reusable workflow
   
   Would you like to:
   - Create another command?
   - Test this command now?
   - Modify this command?
   ```

## Output
- New command file saved to `./opencode/.config/opencode/command/[name].md`
- Command follows OpenCode best practices and existing patterns
- Command is immediately usable in TUI
- User has clear next steps

## Success Criteria
- [ ] User described their command goal clearly
- [ ] Command category and interaction pattern identified correctly
- [ ] All clarifying questions answered
- [ ] Command structure outlined and approved
- [ ] Full command generated with proper formatting
- [ ] Command saved to correct location with proper naming
- [ ] Frontmatter includes required fields
- [ ] Process steps are clear, detailed, and actionable
- [ ] Success criteria are measurable
- [ ] User confirmed satisfaction with the command

## Notes

### Tips for Great Commands

1. **Start Simple, Add Complexity**: Better to start with a working simple command than an ambitious broken one

2. **Learn from Existing Commands**: The best reference is existing commands:
   - Planning: `feature-plan.md`, `bug-plan.md`, `refactor-plan.md`
   - Execution: `task-implement.md`
   - Utility: `prompt-create.md`, `prompt-run.md`

3. **Test Early**: After generation, test the command immediately to catch issues

4. **Iterate**: Commands can be refined over time as you learn what works

### Common Command Patterns

**Discovery Pattern** (used in planning commands):
```markdown
### 1. Discovery
Ask the user to describe [the thing]. Prompt them to provide:
- [Question 1]
- [Question 2]
- [Question 3]

### 2. Clarification
Once the user responds, analyze their request and:
1. **Restate** your understanding
2. **Ask clarifying questions**
3. **Provide proposed answers**
   - Tell the user: "You can reply 'Agree' to accept all proposed answers, or correct specific ones"
```

**Autonomous Execution Pattern** (used in execution commands):
```markdown
## Core Principles

### Autonomy
- **Execute autonomously:** Do NOT ask for permission during implementation
- **Make decisions:** Choose appropriate implementations based on [criteria]
- **Adapt dynamically:** Add or adjust tasks as you discover new requirements
- **Only pause for:** [specific checkpoint, e.g., manual testing]

### Quality
- **Test-driven:** Write or update tests alongside implementation
- **Sequential execution:** Complete one task fully before starting the next
```

**Git Integration Pattern** (common in many commands):
```markdown
### N. Git Branch Setup
Before [saving/implementing], create a [type] branch for this work:

```bash
git checkout main  # or develop, depending on project
git pull origin main
git checkout -b [prefix]/[name]
```

**Branch naming:** Use kebab-case describing the [task] (e.g., `[prefix]/example-name`)
```

**Commit Pattern** (used when commands make commits):
```markdown
### N. Commit [Document/Changes]
Commit the [artifacts] to the [branch]:

```bash
git add [paths]
git commit -m "[type]: [description]

- [Detail 1]
- [Detail 2]
- [Detail 3]"
```
```

### Examples of Good Command Ideas

- **Code Review Command**: Analyze code changes and provide structured feedback
- **Dependency Audit Command**: Check for outdated or vulnerable dependencies
- **Test Coverage Command**: Analyze test coverage and suggest improvements
- **Documentation Generator**: Generate documentation from code
- **Migration Generator**: Create database migration files with best practices
- **API Contract Validator**: Verify API implementations match specifications
- **Performance Profiler**: Analyze and report performance bottlenecks

### Anti-Patterns to Avoid

- **Too Generic**: "Do something useful" - be specific about what the command does
- **Too Complex**: Commands trying to do 10 different things - break into multiple commands
- **Missing Error Handling**: Not considering what happens when things go wrong
- **Unclear Success**: No clear way to verify the command succeeded
- **Inconsistent Style**: Not following the patterns of existing commands
- **Missing Documentation**: Not explaining why certain steps are taken
