# AI Agent Global Context - Development Guidelines

## Personal Preferences

### Editor Configuration
- **Preferred editor:** Neovim

### Session Management
- At the start of any project session, check for a `docs/dev_sessions` directory
- If it exists, locate the most recent dev session summary file
- Use the content from this file as additional context to continue work from the 
  previous session

## Gemini Added Memories
- At startup, immediately after loading AGENT files, I should try to load all files inside the 'docs/ai-context/directives' directory, if they are available.
