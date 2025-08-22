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
- The user has provided CSS styling directives. I will adhere to these guidelines for all future CSS-related tasks, including BEM methodology, Tailwind integration, responsive design, HTML guidelines, and best practices.
- The command to build the CSS is 'yarn build:css'.
