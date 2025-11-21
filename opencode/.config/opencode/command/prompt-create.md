---
description: Expert prompt engineer that creates optimized, well-structured prompts with intelligent depth selection
---

# Prompt Create

## Objective
Create highly effective, optimized prompts using clear Markdown structure and best practices for AI Coding Agents. Generate single or multiple prompts based on task complexity and save them to the prompts folder.

## Input
The user's request for what prompt(s) to create: `$ARGUMENTS`

## Process

### 1. Analysis

Analyze the user's request to determine:

1. **Clarity check (Golden Rule)**: Would a colleague with minimal context understand what's being asked?
   - Are there ambiguous terms that could mean multiple things?
   - Would examples help clarify the desired outcome?
   - Are there missing details about constraints or requirements?
   - Is the context clear (what it's for, who it's for, why it matters)?

2. **Task complexity**: Is this simple (single file, clear goal) or complex (multi-file, research needed, multiple steps)?

3. **Single vs Multiple Prompts**: Should this be one prompt or broken into multiple?
   - Single prompt: Task has clear dependencies, single cohesive goal, sequential steps
   - Multiple prompts: Task has independent sub-tasks that could be parallelized or done separately
   - Consider: Can parts be done simultaneously? Are there natural boundaries between sub-tasks?

4. **Execution Strategy** (if multiple prompts):
   - **Parallel**: Sub-tasks are independent, no shared file modifications, can run simultaneously
   - **Sequential**: Sub-tasks have dependencies, one must finish before next starts
   - Look for: Shared files (sequential), independent modules (parallel), data flow between tasks (sequential)

5. **Reasoning depth needed**:
   - Simple/straightforward → Standard prompt
   - Complex reasoning, multiple constraints, or optimization → Include extended thinking triggers (phrases like "thoroughly analyze", "consider multiple approaches", "deeply consider")

6. **Project context needs**: Do I need to examine the codebase structure, dependencies, or existing patterns?

7. **Optimal prompt depth**: Should this be concise or comprehensive based on the task?

8. **Required tools**: What file references, bash commands, or MCP servers might be needed?

9. **Verification needs**: Does this task warrant built-in error checking or validation steps?

10. **Prompt quality needs**:
    - Does this need explicit "go beyond basics" encouragement for ambitious/creative work?
    - Should generated prompts explain WHY constraints matter, not just what they are?
    - Do examples need to demonstrate desired behavior while avoiding undesired patterns?

### 2. Clarification (if needed)
If the request is ambiguous or could benefit from more detail, ask targeted questions:

"I'll create an optimized prompt for that. First, let me clarify a few things:

1. [Specific question about ambiguous aspect]
2. [Question about constraints or requirements]
3. What is this for? What will the output be used for?
4. Who is the intended audience/user?
5. Can you provide an example of [specific aspect]?

Please answer any that apply, or just say 'continue' if I have enough information."

### 3. Confirmation
Once you have enough information, confirm your understanding:

"I'll create a prompt for: [brief summary of task]

This will be a [simple/moderate/complex] prompt that [key approach].

Should I proceed, or would you like to adjust anything?"

### 4. Generate and Save
Create the prompt(s) and save to the prompts folder.

**For single prompts:**
- Generate one prompt file following the patterns below
- Save as `./prompts/[number]-[name].md`

**For multiple prompts:**
- Determine how many prompts are needed (typically 2-4)
- Generate each prompt with clear, focused objectives
- Save sequentially: `./prompts/[N]-[name].md`, `./prompts/[N+1]-[name].md`, etc.
- Each prompt should be self-contained and executable independently

## Prompt Construction Rules

### Always Include
- **Clear Markdown structure** with semantic headings: `## Objective`, `## Context`, `## Requirements`, `## Implementation`, `## Output`
- **Contextual information**: Why this task matters, what it's for, who will use it, end goal
- **Explicit, specific instructions**: Tell the AI Coding Agent exactly what to do with clear, unambiguous language
- **Sequential steps**: Use numbered lists for clarity
- File output instructions using relative paths: `./filename` or `./subfolder/filename`
- Reference to reading the AGENTS.md for project conventions (when applicable)
- Explicit success criteria within `## Success Criteria` or `## Verification` sections

### Conditionally Include (based on analysis)
- **Extended thinking triggers** for complex reasoning:
  - Phrases like: "thoroughly analyze", "consider multiple approaches", "deeply consider", "explore multiple solutions"
  - Don't use for simple, straightforward tasks
- **"Go beyond basics" language** for creative/ambitious tasks:
  - Example: "Include as many relevant features as possible. Go beyond the basics to create a fully-featured implementation."
- **WHY explanations** for constraints and requirements:
  - In generated prompts, explain WHY constraints matter, not just what they are
  - Example: Instead of "Never use ellipses", write "Your response will be read aloud, so never use ellipses since text-to-speech can't pronounce them"
- **Parallel tool calling** for agentic/multi-step workflows:
  - "For maximum efficiency, whenever you need to perform multiple independent operations, invoke all relevant tools simultaneously rather than sequentially."
- **Reflection after tool use** for complex agentic tasks:
  - "After receiving tool results, carefully reflect on their quality and determine optimal next steps before proceeding."
- `## Research` section when codebase exploration is needed
- `## Validation` section for tasks requiring verification
- `## Examples` section for complex or ambiguous requirements - ensure examples demonstrate desired behavior and avoid undesired patterns
- Bash command execution when system state matters
- MCP server references when specifically requested or obviously beneficial

### Output Format
1. Generate prompt content with Markdown structure
2. Save to: `./prompts/[number]-[descriptive-name].md`
   - Number format: 001, 002, 003, etc. (check existing files in ./prompts/ to determine next number)
   - Name format: lowercase, hyphen-separated, max 5 words describing the task
   - Example: `./prompts/001-implement-user-authentication.md`
3. File should contain ONLY the prompt, no explanations or metadata

## Prompt Patterns

### For Coding Tasks
```markdown
## Objective
[Clear statement of what needs to be built/fixed/refactored]
Explain the end goal and why this matters.

## Context
- Project type: [description]
- Tech stack: [list]
- Relevant constraints: [list]
- Who will use this: [description]
- What it's for: [purpose]

**Files to examine:**
- `@package.json` - [why]
- `@src/[relevant]` - [why]

## Requirements

### Functional Requirements
1. [Specific requirement 1]
2. [Specific requirement 2]

### Quality Requirements
- Performance: [expectations]
- Security: [considerations]

Be explicit about what the AI Coding Agent should do.

## Implementation

### Approach
[Any specific approaches or patterns to follow]

### Constraints
[What to avoid and WHY - explain the reasoning behind constraints]

## Output
Create/modify the following files:
- `./path/to/file.ext` - [what this file should contain]
- `./path/to/test.ext` - [test coverage needed]

## Verification
Before declaring complete, verify your work:
- [ ] [Specific test or check to perform]
- [ ] [How to confirm the solution works]
- [ ] Run tests and ensure they pass

## Success Criteria
- [ ] [Clear, measurable criterion 1]
- [ ] [Clear, measurable criterion 2]
```

### For Analysis Tasks
```markdown
## Objective
[What needs to be analyzed and why]
[What the analysis will be used for]

## Data Sources
**Files to analyze:**
- `@file1.ext` - [what to look for]
- `@file2.ext` - [what to look for]

**Commands to run:**
```bash
[relevant commands to gather data]
```

## Analysis Requirements

### Metrics to Identify
1. [Specific metric or pattern 1]
2. [Specific metric or pattern 2]

### Depth of Analysis
[Use "thoroughly analyze" for complex tasks]

### Comparisons
- Compare [A] vs [B]
- Benchmark against [standard]

## Output Format
Structure your analysis with these sections:
- Executive summary
- Detailed findings
- Recommendations
- Metrics

**Save to:** `./analyses/[descriptive-name].md`

## Verification
Before completing, verify:
- [ ] [How to validate the analysis is complete]
- [ ] [How to confirm accuracy]
```

### For Research Tasks
```markdown
## Research Objective
[What information needs to be gathered]
[Intended use of the research]

For complex research: Thoroughly explore multiple sources and consider various perspectives.

## Scope

### Boundaries
- In scope: [what to research]
- Out of scope: [what to exclude]

### Sources
- Prioritize: [preferred sources]
- Avoid: [sources to skip]
- Time period: [if relevant]

## Deliverables

### Format
[How to structure the research output]

### Level of Detail
[Depth required]

**Save to:** `./research/[topic].md`

## Evaluation Criteria

### Quality Assessment
- Source credibility: [how to assess]
- Relevance: [how to determine]

### Key Questions
1. [Question that must be answered]
2. [Question that must be answered]

## Verification
Before completing, verify:
- [ ] All key questions are answered
- [ ] Sources are credible and relevant
- [ ] Findings are well-organized
```

## Intelligence Rules

1. **Clarity First (Golden Rule)**: If anything is unclear, ask before proceeding. A few clarifying questions save time. Test: Would a colleague with minimal context understand this prompt?

2. **Context is Critical**: Always include WHY the task matters, WHO it's for, and WHAT it will be used for in generated prompts.

3. **Be Explicit**: Generate prompts with explicit, specific instructions. For ambitious results, include "go beyond the basics." For specific formats, state exactly what format is needed.

4. **Scope Assessment**: Simple tasks get concise prompts. Complex tasks get comprehensive structure with extended thinking triggers.

5. **Context Loading**: Only request file reading when the task explicitly requires understanding existing code. Use patterns like:
   - "Examine @package.json for dependencies" (when adding new packages)
   - "Review @src/database/* for schema" (when modifying data layer)
   - Skip file reading for greenfield features

6. **Precision vs Brevity**: Default to precision. A longer, clear prompt beats a short, ambiguous one.

7. **Tool Integration**:
   - Include MCP servers only when explicitly mentioned or obviously needed
   - Use bash commands for environment checking when state matters
   - File references should be specific, not broad wildcards
   - For multi-step agentic tasks, include parallel tool calling guidance

8. **Output Clarity**: Every prompt must specify exactly where to save outputs using relative paths

9. **Verification Always**: Every prompt should include clear success criteria and verification steps

## Output

After saving the prompt(s), present this decision tree to the user:

---

**Prompt(s) created successfully!**

**Single Prompt Scenario:**
If you created ONE prompt (e.g., `./prompts/005-implement-feature.md`):

✓ Saved prompt to ./prompts/005-implement-feature.md

What's next?

1. Run prompt now
2. Review/edit prompt first
3. Save for later
4. Other

Choose (1-4): _

*(If user chooses #1, invoke: `/prompt-run 005`)*

---

**Parallel Execution Scenario:**
If you created MULTIPLE prompts that CAN run in parallel (independent tasks, no shared files):

✓ Saved prompts:
  - ./prompts/005-implement-auth.md
  - ./prompts/006-implement-api.md
  - ./prompts/007-implement-ui.md

Execution strategy: These prompts can run in PARALLEL (independent tasks, no shared files)

What's next?

1. Run all prompts in parallel now (launches 3 sub-agents simultaneously)
2. Run prompts sequentially instead
3. Review/edit prompts first
4. Other

Choose (1-4): _

*(If user chooses #1, invoke: `/prompt-run 005 006 007 --parallel`)*
*(If user chooses #2, invoke: `/prompt-run 005 006 007 --sequential`)*

---

**Sequential Execution Scenario:**
If you created MULTIPLE prompts that MUST run sequentially (dependencies, shared files):

✓ Saved prompts:
  - ./prompts/005-setup-database.md
  - ./prompts/006-create-migrations.md
  - ./prompts/007-seed-data.md

Execution strategy: These prompts must run SEQUENTIALLY (dependencies: 005 → 006 → 007)

What's next?

1. Run prompts sequentially now (one completes before next starts)
2. Run first prompt only (005-setup-database.md)
3. Review/edit prompts first
4. Other

Choose (1-4): _

*(If user chooses #1, invoke: `/prompt-run 005 006 007 --sequential`)*
*(If user chooses #2, invoke: `/prompt-run 005`)*

---

## Success Criteria
- [ ] User's request clearly understood (or clarified)
- [ ] Appropriate number of prompts created (single or multiple)
- [ ] Prompts follow Markdown structure and best practices
- [ ] Prompts saved to correct location with proper naming
- [ ] Decision tree presented to user
- [ ] User can execute prompts immediately or review first

## Notes

### Meta Instructions
- First, check if clarification is needed before generating the prompt
- Check existing prompts to determine the next number in sequence
- If ./prompts/ doesn't exist, create it before saving
- Keep prompt filenames descriptive but concise
- Adapt the Markdown structure to fit the task - not every section is needed every time
- Consider the user's working directory as the root for all relative paths
- Each prompt file should contain ONLY the prompt content, no preamble or explanation
- After saving, present the appropriate decision tree based on what was created

### Examples of When to Ask for Clarification
- "Build a dashboard" → Ask: "What kind of dashboard? Admin, analytics, user-facing? What data should it display? Who will use it?"
- "Fix the bug" → Ask: "Can you describe the bug? What's the expected vs actual behavior? Where does it occur?"
- "Add authentication" → Ask: "What type? JWT, OAuth, session-based? Which providers? What's the security context?"
- "Optimize performance" → Ask: "What specific performance issues? Load time, memory, database queries? What are the current metrics?"
- "Create a report" → Ask: "Who is this report for? What will they do with it? What format do they need?"
