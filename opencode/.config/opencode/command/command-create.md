---
description: Interactive command generator for creating OpenCode commands
---

# Command Create

## Objective
Interactively create a new OpenCode command following existing patterns.

## Reference

### Frontmatter Options
- `description`: (Required) Brief description shown in command list
- `agent`: (Optional) Which agent executes this command
- `model`: (Optional) Override default model
- `subtask`: (Optional) Force subagent invocation if true

### Template Variables
- `$ARGUMENTS`: All arguments as single string
- `$1`, `$2`, `$3`: Individual positional arguments
- `` !`command` ``: Inject bash command output
- `@filename`: Include file content

### File Location
- Global: `~/.config/opencode/command/`
- Per-project: `.opencode/command/`

## Process

### 1. Discovery
Ask the user:
- What should this command do?
- What problem does it solve?
- Does it take arguments?

### 2. Classification
Analyze and determine:
- **Category:** Planning / Execution / Utility
- **Interaction:** Interactive / Autonomous / Hybrid
- **Complexity:** Simple / Moderate / Complex

### 3. Clarification
Present your understanding and ask about:
- Arguments (required/optional)
- File operations (read/create/modify)
- Git integration (branch/commit/PR)
- Output format

Provide proposed answers. User can "Agree" or correct.

### 4. Design Structure
Read existing commands for style reference:
```bash
ls ./opencode/.config/opencode/command/tasks/
```

Design sections based on category:
- **Planning commands:** Discovery → Clarification → Draft → Git Setup → Save
- **Execution commands:** Setup → Implementation → Validation → Output
- **Utility commands:** Input → Process → Output

### 5. Generate & Save
Generate full command matching existing patterns.

Save to: `./opencode/.config/opencode/command/[name].md`

Confirm to user:
- Location and invocation
- How to test
- Next steps

## Output
- Command file saved to `./opencode/.config/opencode/command/[name].md`
- Follows existing patterns
- Immediately usable via `/[name]`
