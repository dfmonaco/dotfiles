# Superpowers Install Instructions: OpenCode + Antigravity

How to install the Superpowers skill system for both OpenCode and Antigravity agents,
using dotfiles (managed by GNU stow) as the source of truth.

---

## What This Does

Superpowers is a skill system that teaches AI agents how to use structured workflows.
Two things are required per platform:

1. **Bootstrap injection** — the `using-superpowers` skill content must be present in
   every session's context automatically. Both platforms read an `AGENTS.md` on startup.
2. **Skill discovery** — individual skills must be in a directory each platform can find
   and load on demand.

Each platform gets its own `AGENTS.md` with platform-specific tool mapping. Skills are
wired via symlinks from the source repo into each platform's expected directory.

---

## Prerequisites

Two repositories cloned locally:

```
~/code/superpowers/    # the superpowers skills repo
~/dotfiles/            # your dotfiles repo (managed with GNU stow)
```

The dotfiles repo is assumed to already have these in place (standard stow setup):

| Live path                        | Source in dotfiles                              | How wired                         |
|----------------------------------|-------------------------------------------------|-----------------------------------|
| `~/.agents`                      | `dotfiles/agents/.agents/`                      | stow symlink (whole dir)          |
| `~/.agents/skills/`              | `dotfiles/agents/.agents/skills/`               | via parent stow symlink           |
| `~/.config/opencode/AGENTS.md`   | `dotfiles/opencode/.config/opencode/AGENTS.md`  | stow relative symlink             |
| `~/.gemini/AGENTS.md`            | `dotfiles/.gemini/AGENTS.md`                    | manual absolute symlink           |
| `~/.gemini/antigravity/`         | (live directory, managed by Antigravity itself) | NOT stowed — exists independently |

> **Note on `~/.gemini/antigravity/`:** Antigravity creates and manages this directory
> itself (it stores brain data, conversations, etc.). Do NOT try to replace it with a
> stow symlink. Instead, add files inside it directly.

---

## Step 1 — Append Superpowers Bootstrap to OpenCode's AGENTS.md

**File:** `dotfiles/opencode/.config/opencode/AGENTS.md`

Append the following block at the end of the file. The content is derived from
`~/code/superpowers/skills/using-superpowers/SKILL.md` (lines 6–95, stripping the
YAML frontmatter on lines 1–4), plus an OpenCode-specific preamble and tool mapping.

```
<EXTREMELY_IMPORTANT>
You have superpowers.

**IMPORTANT: The using-superpowers skill content is included below. It is ALREADY LOADED - you are currently following it. Do NOT use the skill tool to load "using-superpowers" again - that would be redundant.**


<EXTREMELY-IMPORTANT>
If you think there is even a 1% chance a skill might apply to what you are doing, you ABSOLUTELY MUST invoke the skill.

IF A SKILL APPLIES TO YOUR TASK, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.

This is not negotiable. This is not optional. You cannot rationalize your way out of this.
</EXTREMELY-IMPORTANT>

## How to Access Skills

**In OpenCode:** Use the native `Skill` tool. When you invoke a skill, its content is loaded and presented to you—follow it directly. Never use the Read tool on skill files.

# Using Skills

## The Rule

**Invoke relevant or requested skills BEFORE any response or action.** Even a 1% chance a skill might apply means that you should invoke the skill to check. If an invoked skill turns out to be wrong for the situation, you don't need to use it.

[...paste body of using-superpowers/SKILL.md lines 6-95 here...]

**Tool Mapping for OpenCode:**
When skills reference tools, all OpenCode native tools are available directly:

- `TodoWrite` → `TodoWrite` tool (same)
- `Task` tool with subagents → `Task` tool (same)
- `Skill` tool → `Skill` tool (same)
- `Read`, `Write`, `Edit`, `Bash`, `Glob`, `Grep` → native tools (same)

**Skills location:** `~/.agents/skills/superpowers/`
Use the `Skill` tool to load skills, e.g. `skill("superpowers/brainstorming")`.
</EXTREMELY_IMPORTANT>
```

> **How to get the current skill body:** Run:
> ```bash
> sed -n '6,95p' ~/code/superpowers/skills/using-superpowers/SKILL.md
> ```
> The YAML frontmatter (lines 1–4) is stripped; only the content starting at
> `<EXTREMELY-IMPORTANT>` is used.

> **OpenCode tool names:** All tools are native — no translation needed. The names
> used in skills (`TodoWrite`, `Task`, `Skill`, `Read`, `Write`, `Edit`, `Bash`,
> `Glob`, `Grep`) are exactly the tools available in OpenCode.

---

## Step 2 — Replace Antigravity's AGENTS.md

**File:** `dotfiles/.gemini/AGENTS.md`

This file is symlinked to `~/.gemini/AGENTS.md`. Replace its entire contents with a
new file that includes: personal rules + superpowers bootstrap + Antigravity tool mapping.

Structure:

```markdown
# Global AI Agent Rules - Personal Preferences

[...personal rules: critical thinking, verify before complex tasks, recommendations...]

---

# Superpowers

You have superpowers.

**IMPORTANT: ...already loaded...**

<EXTREMELY-IMPORTANT>
[...1% rule...]
</EXTREMELY-IMPORTANT>

## How to Access Skills

**In Antigravity:** Use `view_file` on the skill file directly.
To load a skill: `view_file ~/.gemini/antigravity/skills/<skill-name>/SKILL.md`

# Using Skills

[...paste body of using-superpowers/SKILL.md lines 6-95 here...]

## Tool Mapping for Antigravity

When skills reference tools, use these Antigravity equivalents:

- `TodoWrite` → write/update a `task.md` or `plan.md` file using `write_to_file`
- `Task` tool with subagents → `browser_subagent` for browser tasks, or structured steps with `task_boundary`
- `Skill` tool → `view_file ~/.gemini/antigravity/skills/<skill-name>/SKILL.md`
- `Read` / view file → `view_file`
- `Write` → `write_to_file`
- `Edit` → `replace_file_content` or `multi_replace_file_content`
- `Glob` / find files → `find_by_name`
- `Grep` → `grep_search`
- `Bash` → `run_command`
- `WebFetch` → `read_url_content`
- Directory listing → `list_dir`
- Code structure → `view_file_outline`, `view_code_item`
- Web search → `search_web`
- User communication during tasks → `notify_user`

**Skills location:** `~/.gemini/antigravity/skills/superpowers/`
To load a skill: `view_file ~/.gemini/antigravity/skills/<skill-name>/SKILL.md`
```

> **Antigravity tool names differ significantly from OpenCode/Claude Code.** The
> mapping above is the critical part — every time a skill says `Read`, Antigravity
> uses `view_file`; every `Bash` becomes `run_command`; every `Glob` becomes
> `find_by_name`, etc. Get these wrong and the agent won't know how to execute skills.

---

## Step 3 — Wire Superpowers Skills for OpenCode

Create a symlink inside the stow package so that all superpowers skills are available
at `~/.agents/skills/superpowers/`:

```bash
ln -s /home/diego/code/superpowers/skills \
  ~/dotfiles/agents/.agents/skills/superpowers
```

Because `~/.agents` is itself a stow symlink pointing to `dotfiles/agents/.agents/`,
anything placed inside `dotfiles/agents/.agents/skills/` is immediately visible at
`~/.agents/skills/` — no re-stow needed.

**Result:** `~/.agents/skills/superpowers/` → `~/code/superpowers/skills/`

---

## Step 4 — Wire Superpowers Skills for Antigravity

Antigravity expects skills at `~/.gemini/antigravity/skills/<skill-name>/SKILL.md`.
Since `~/.gemini/antigravity/` already exists as a live directory managed by
Antigravity, create the skills subdirectory and symlink directly inside it:

```bash
mkdir -p ~/.gemini/antigravity/skills
ln -s /home/diego/code/superpowers/skills \
  ~/.gemini/antigravity/skills/superpowers
```

> **Do NOT try to stow or symlink `~/.gemini/antigravity/` itself.** Antigravity
> owns that directory and stores runtime data there (brain, conversations, etc.).
> Only add things inside it.

**Result:** `~/.gemini/antigravity/skills/superpowers/` → `~/code/superpowers/skills/`

---

## Verification

Run after completing all steps:

```bash
# 1. Both AGENTS.md files have the superpowers content
grep -l "EXTREMELY-IMPORTANT" ~/.config/opencode/AGENTS.md ~/.gemini/AGENTS.md

# 2. OpenCode sees 14 superpowers skills
ls ~/.agents/skills/superpowers | wc -l
# expected: 14

# 3. Antigravity sees 14 superpowers skills
ls ~/.gemini/antigravity/skills/superpowers | wc -l
# expected: 14

# 4. Both symlinks point at the live repo
readlink ~/.agents/skills/superpowers
# expected: /home/diego/code/superpowers/skills

readlink ~/.gemini/antigravity/skills/superpowers
# expected: /home/diego/code/superpowers/skills
```

---

## Updating Superpowers in the Future

Skills update automatically — the symlinks point at the live repo:

```bash
cd ~/code/superpowers && git pull
```

**If `using-superpowers/SKILL.md` content changes materially:** the static copy
embedded in both `AGENTS.md` files will be stale. Re-run Steps 1 and 2 with the
updated content. Check what changed:

```bash
git -C ~/code/superpowers diff HEAD~1 HEAD -- skills/using-superpowers/SKILL.md
```

---

## File Change Summary

| File / Path | Action | Notes |
|---|---|---|
| `dotfiles/opencode/.config/opencode/AGENTS.md` | Append superpowers block | Lives in stow package; symlinked to `~/.config/opencode/AGENTS.md` |
| `dotfiles/.gemini/AGENTS.md` | Replace entirely | Manually symlinked to `~/.gemini/AGENTS.md` (absolute symlink, not stow) |
| `dotfiles/agents/.agents/skills/superpowers` | Create symlink → `~/code/superpowers/skills` | Lives in stow package; visible at `~/.agents/skills/superpowers/` |
| `~/.gemini/antigravity/skills/` | Create directory | Not in dotfiles — lives directly in Antigravity's runtime dir |
| `~/.gemini/antigravity/skills/superpowers` | Create symlink → `~/code/superpowers/skills` | Not in dotfiles — lives directly in Antigravity's runtime dir |

---

## Architecture Diagram

```
~/code/superpowers/skills/          ← source of truth for all skills
  brainstorming/SKILL.md
  using-superpowers/SKILL.md
  planning/SKILL.md
  ... (14 skills total)
        │
        ├──────────────────────────────────────────────────────────────┐
        ▼                                                              ▼
dotfiles/agents/.agents/skills/superpowers    ~/.gemini/antigravity/skills/superpowers
(symlink)                                     (symlink, not in dotfiles)
        │                                                              │
        ▼ (via stow: ~/.agents → dotfiles/agents/.agents)             │
~/.agents/skills/superpowers/                 ~/.gemini/antigravity/skills/superpowers/
  (OpenCode reads this)                         (Antigravity reads this)


dotfiles/opencode/.config/opencode/AGENTS.md  dotfiles/.gemini/AGENTS.md
  (personal rules + superpowers bootstrap       (personal rules + superpowers bootstrap
   + OpenCode tool mapping)                      + Antigravity tool mapping)
        │                                                              │
        ▼ (stow relative symlink)                                     ▼ (manual absolute symlink)
~/.config/opencode/AGENTS.md                  ~/.gemini/AGENTS.md
  (OpenCode reads on startup)                   (Antigravity reads on startup)
```
