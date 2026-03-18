-- vscode-neovim configuration
-- Loaded by the vscode-neovim extension as a standalone Neovim init file.
-- API docs: https://github.com/vscode-neovim/vscode-neovim
--
-- Keymap source of truth: nvim/.config/nvim/lua/config/keymaps.lua
-- and the plugin keymaps in nvim/.config/nvim/lua/plugins/
-- Goal: identical keys → identical results across Neovim and VS Code.

local vscode = require("vscode")

-- ============================================================================
-- LEADER KEY
-- ============================================================================
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- ============================================================================
-- EDITOR SETTINGS
-- ============================================================================
-- Match options.lua
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.scrolloff = 10

-- ============================================================================
-- GENERAL
-- ============================================================================
-- <Esc>: clear search highlight (same as keymaps.lua)
vim.keymap.set("n", "<Esc>", function()
  vscode.action("cancelSelection")
  -- Also clear neovim-side search highlight
  vim.cmd("nohlsearch")
end, { desc = "Clear search highlight / cancel selection" })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================
-- <leader>j: save file (matches keymaps.lua)
vim.keymap.set("n", "<leader>j", function()
  vscode.call("workbench.action.files.save")
end, { desc = "Save file" })

-- <leader>w: also save (matches vscode/init.lua convention & keymaps.lua <leader>j)
vim.keymap.set("n", "<leader>w", function()
  vscode.call("workbench.action.files.save")
end, { desc = "Save file" })

-- <leader>q: close editor tab (closest to :q)
vim.keymap.set("n", "<leader>q", function()
  vscode.call("workbench.action.closeActiveEditor")
end, { desc = "Close editor" })

-- <leader>o: open link under cursor
vim.keymap.set("n", "<leader>o", function()
  vscode.call("editor.action.openLink")
end, { desc = "Open link" })

-- ============================================================================
-- CONFIG EDITING
-- ============================================================================
-- <leader>ei: edit init.lua (this file)
vim.keymap.set("n", "<leader>ei", "<cmd>e $MYVIMRC<cr>", { desc = "Edit init.lua" })

-- ============================================================================
-- BUFFER / TAB NAVIGATION
-- ============================================================================
-- <Tab> / <S-Tab>: cycle editor tabs (matches bufferline.lua)
vim.keymap.set("n", "<Tab>", function()
  vscode.call("workbench.action.nextEditor")
end, { desc = "Next editor tab" })

vim.keymap.set("n", "<S-Tab>", function()
  vscode.call("workbench.action.previousEditor")
end, { desc = "Previous editor tab" })

-- <leader><leader>: toggle between last two editors (matches keymaps.lua <C-^>)
vim.keymap.set("n", "<leader><leader>", function()
  vscode.call("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup")
end, { desc = "Toggle between last two editors" })

-- <leader>k: close editor (matches snacks.lua bufdelete)
vim.keymap.set("n", "<leader>k", function()
  vscode.call("workbench.action.closeActiveEditor")
end, { desc = "Close editor (delete buffer)" })

-- <leader>ba: select all text in editor (matches keymaps.lua)
vim.keymap.set("n", "<leader>ba", function()
  vscode.call("editor.action.selectAll")
end, { desc = "Select all in buffer" })

-- <leader>bp: pin/unpin tab (matches bufferline.lua)
vim.keymap.set("n", "<leader>bp", function()
  vscode.call("workbench.action.pinEditor")
end, { desc = "Pin editor tab" })

-- <leader>bo: close other editors in group (matches bufferline.lua)
vim.keymap.set("n", "<leader>bo", function()
  vscode.call("workbench.action.closeOtherEditors")
end, { desc = "Close other editors" })

-- ============================================================================
-- WINDOW NAVIGATION (matches keymaps.lua + VS Code editor groups)
-- ============================================================================
vim.keymap.set("n", "<C-h>", function()
  vscode.action("workbench.action.focusLeftGroup")
end, { desc = "Focus left window" })

vim.keymap.set("n", "<C-j>", function()
  vscode.action("workbench.action.focusBelowGroup")
end, { desc = "Focus below window" })

vim.keymap.set("n", "<C-k>", function()
  vscode.action("workbench.action.focusAboveGroup")
end, { desc = "Focus above window" })

vim.keymap.set("n", "<C-l>", function()
  vscode.action("workbench.action.focusRightGroup")
end, { desc = "Focus right window" })

-- <leader>wx: close current split/group (matches keymaps.lua)
vim.keymap.set("n", "<leader>wx", function()
  vscode.call("workbench.action.closeEditorsInGroup")
end, { desc = "Close current split" })

-- ============================================================================
-- CLIPBOARD (matches keymaps.lua gy/gp)
-- ============================================================================
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

-- ============================================================================
-- VISUAL MODE INDENTING (matches keymaps.lua)
-- Keeps selection after indenting so you can indent multiple times
-- ============================================================================
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ============================================================================
-- SEARCH & FIND (matches snacks.lua pickers → VS Code equivalents)
-- ============================================================================
-- <leader>/: grep across project (matches snacks grep)
vim.keymap.set("n", "<leader>/", function()
  vscode.action("workbench.action.findInFiles")
end, { desc = "Grep project" })

-- <leader>ff / <leader>fa: find files (matches snacks pickers)
vim.keymap.set("n", "<leader>ff", function()
  vscode.action("workbench.action.quickOpen")
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fa", function()
  vscode.action("workbench.action.quickOpen")
end, { desc = "Find files (smart)" })

-- <leader>fg: find git files (matches snacks git_files)
vim.keymap.set("n", "<leader>fg", function()
  vscode.action("workbench.action.quickOpen")
end, { desc = "Find git files" })

-- <leader>fr: recent files (matches snacks recent)
vim.keymap.set("n", "<leader>fr", function()
  vscode.action("workbench.action.openRecent")
end, { desc = "Recent files" })

-- <leader>fb: buffers/open editors (matches snacks buffers)
vim.keymap.set("n", "<leader>fb", function()
  vscode.action("workbench.action.showAllEditors")
end, { desc = "Show open editors (buffers)" })

-- <leader>,: buffers (matches snacks.lua <leader>,)
vim.keymap.set("n", "<leader>,", function()
  vscode.action("workbench.action.showAllEditors")
end, { desc = "Buffers" })

-- <leader>f: open Find in Files (visual: pre-fill with selection)
vim.keymap.set("n", "<leader>f", function()
  vscode.action("workbench.action.findInFiles")
end, { noremap = true, silent = true, desc = "Find in files" })

vim.keymap.set("v", "<leader>f", function()
  vscode.action("workbench.action.findInFiles")
end, { noremap = true, silent = true, desc = "Find selected text in files" })

-- ?: find word under cursor in all project files (original vscode config)
vim.keymap.set("n", "?", function()
  local query = vim.fn.expand("<cword>")
  vscode.action("workbench.action.findInFiles", { args = { query = query } })
end, { noremap = true, silent = true, desc = "Find word under cursor in project" })

-- <leader>sw: grep word under cursor / visual selection (matches snacks grep_word)
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
  local query = vim.fn.expand("<cword>")
  vscode.action("workbench.action.findInFiles", { args = { query = query } })
end, { desc = "Grep word" })

-- <leader>sg: grep (matches snacks grep)
vim.keymap.set("n", "<leader>sg", function()
  vscode.action("workbench.action.findInFiles")
end, { desc = "Grep" })

-- <leader>sh: help / keybindings reference (matches snacks help)
vim.keymap.set("n", "<leader>sh", function()
  vscode.action("workbench.action.keybindingsReference")
end, { desc = "Help / keybindings reference" })

-- <leader>sk: keymaps (matches snacks keymaps)
vim.keymap.set("n", "<leader>sk", function()
  vscode.action("workbench.action.openGlobalKeybindings")
end, { desc = "Keymaps" })

-- <leader>:/<leader>sc: command history / command palette (matches snacks)
vim.keymap.set("n", "<leader>:", function()
  vscode.action("workbench.action.showCommands")
end, { desc = "Command palette" })

vim.keymap.set("n", "<leader>sc", function()
  vscode.action("workbench.action.showCommands")
end, { desc = "Commands" })

vim.keymap.set("n", "<leader>sC", function()
  vscode.action("workbench.action.showCommands")
end, { desc = "Commands" })

-- <leader>sd: diagnostics (matches snacks diagnostics picker)
vim.keymap.set("n", "<leader>sd", function()
  vscode.action("workbench.actions.view.problems")
end, { desc = "Diagnostics panel" })

-- <leader>sD: buffer diagnostics
vim.keymap.set("n", "<leader>sD", function()
  vscode.action("workbench.actions.view.problems")
end, { desc = "Buffer diagnostics" })

-- <leader>sr: search and replace across project (matches grug-far.lua)
vim.keymap.set({ "n", "x" }, "<leader>sr", function()
  vscode.action("workbench.action.findInFiles")
end, { desc = "Search and replace (find in files)" })

-- <leader>r: find and replace in current file (visual, matches vscode config)
vim.keymap.set("v", "<leader>r", function()
  vscode.call("editor.action.startFindReplaceAction")
end, { noremap = true, silent = true, desc = "Find and replace selected text" })

-- ============================================================================
-- CODE NAVIGATION (matches lsp/init.lua + snacks.lua LSP pickers)
-- ============================================================================
-- gd: go to definition
vim.keymap.set("n", "gd", function()
  vscode.action("editor.action.revealDefinition")
end, { desc = "Go to definition" })

-- gD: go to declaration (matches snacks lsp_declarations)
vim.keymap.set("n", "gD", function()
  vscode.action("editor.action.revealDeclaration")
end, { desc = "Go to declaration" })

-- gr: go to references (matches snacks lsp_references)
vim.keymap.set("n", "gr", function()
  vscode.action("editor.action.goToReferences")
end, { desc = "Go to references" })

-- gI: go to implementation (matches snacks lsp_implementations)
vim.keymap.set("n", "gI", function()
  vscode.action("editor.action.goToImplementation")
end, { desc = "Go to implementation" })

-- gy: go to type definition (matches snacks lsp_type_definitions)
-- Note: in Neovim gy is lsp_type_definitions; in vscode/init.lua it was clipboard yank.
-- Clipboard yank is already on gy above, so we skip type definition here to avoid conflict.
-- Use <leader>ct instead (see below).

-- gb: jump back (matches lsp/init.lua gb → <C-o>)
-- vscode-neovim handles <C-o> natively; we mirror gb for convenience
vim.keymap.set("n", "gb", function()
  vscode.action("workbench.action.navigateBack")
end, { desc = "Jump back" })

-- K: show hover documentation (matches lsp/init.lua)
vim.keymap.set("n", "K", function()
  vscode.action("editor.action.showHover")
end, { desc = "Show hover" })

-- [d / ]d: previous/next diagnostic (matches lsp/init.lua)
vim.keymap.set("n", "[d", function()
  vscode.action("editor.action.marker.prevInFiles")
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
  vscode.action("editor.action.marker.nextInFiles")
end, { desc = "Next diagnostic" })

-- ============================================================================
-- CODE ACTIONS (<leader>c* — matches lsp/init.lua)
-- ============================================================================
-- <leader>ca: code action / quick fix
vim.keymap.set({ "n", "v" }, "<leader>ca", function()
  vscode.action("editor.action.quickFix")
end, { desc = "Code action (quick fix)" })

-- <leader>cn: rename symbol
vim.keymap.set("n", "<leader>cn", function()
  vscode.action("editor.action.rename")
end, { desc = "Rename symbol" })

-- <leader>cf: format buffer (matches conform.lua <leader>cf)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  vscode.action("editor.action.formatDocument")
end, { desc = "Format buffer" })

-- <leader>cs: signature help
vim.keymap.set("n", "<leader>cs", function()
  vscode.action("editor.action.triggerParameterHints")
end, { desc = "Signature help" })

-- <leader>co: document outline / symbols (matches lsp/init.lua <leader>co)
vim.keymap.set("n", "<leader>co", function()
  vscode.action("workbench.action.gotoSymbol")
end, { desc = "Document outline (symbols)" })

-- <leader>ss (LSP symbols) / <leader>cw (workspace symbols)
vim.keymap.set("n", "<leader>ss", function()
  vscode.action("workbench.action.gotoSymbol")
end, { desc = "LSP symbols" })

vim.keymap.set("n", "<leader>sS", function()
  vscode.action("workbench.action.showAllSymbols")
end, { desc = "LSP workspace symbols" })

vim.keymap.set("n", "<leader>cw", function()
  vscode.action("workbench.action.showAllSymbols")
end, { desc = "Workspace symbols" })

-- <leader>cx: show diagnostic float (matches lsp/init.lua)
vim.keymap.set("n", "<leader>cx", function()
  vscode.action("editor.action.showHover")
end, { desc = "Show diagnostic float" })

-- <leader>cX: list all diagnostics (matches lsp/init.lua)
vim.keymap.set("n", "<leader>cX", function()
  vscode.action("workbench.actions.view.problems")
end, { desc = "List all diagnostics" })

-- <leader>ch: toggle inlay hints (matches lsp/init.lua)
vim.keymap.set("n", "<leader>ch", function()
  vscode.action("editor.action.inlayHints.toggle")
end, { desc = "Toggle inlay hints" })

-- ============================================================================
-- GIT (<leader>g* — matches snacks.lua + gitsigns.lua)
-- ============================================================================
-- <leader>gg: lazygit / source control panel (matches snacks lazygit)
vim.keymap.set("n", "<leader>gg", function()
  vscode.action("workbench.view.scm")
end, { desc = "Source control / lazygit" })

-- <leader>gb: git branches (matches snacks git_branches)
vim.keymap.set("n", "<leader>gb", function()
  vscode.action("git.checkout")
end, { desc = "Git branches / checkout" })

-- <leader>gs: git status (matches snacks git_status)
vim.keymap.set("n", "<leader>gs", function()
  vscode.action("workbench.view.scm")
end, { desc = "Git status" })

-- <leader>gl: git log (matches snacks git_log)
vim.keymap.set("n", "<leader>gl", function()
  vscode.action("git.viewHistory")
end, { desc = "Git log" })

-- <leader>gB: git browse (matches snacks gitbrowse)
vim.keymap.set({ "n", "v" }, "<leader>gB", function()
  vscode.action("github.openOnGitHub")
end, { desc = "Git browse (open on GitHub)" })

-- <leader>go: open git modified files (matches keymaps.lua OpenGitModified command)
vim.keymap.set("n", "<leader>go", function()
  vscode.action("workbench.view.scm")
end, { desc = "Open git modified files" })

-- Git hunk navigation: <C-n>/<C-p> (matches gitsigns.lua on_attach)
vim.keymap.set("n", "<C-n>", function()
  vscode.action("workbench.action.editor.nextChange")
end, { desc = "Next git hunk" })

vim.keymap.set("n", "<C-p>", function()
  vscode.action("workbench.action.editor.previousChange")
end, { desc = "Previous git hunk" })

-- <leader>hs: stage hunk (matches gitsigns.lua)
vim.keymap.set({ "n", "v" }, "<leader>hs", function()
  vscode.action("git.stageSelectedRanges")
end, { desc = "Stage hunk" })

-- <leader>hr: reset/unstage hunk (matches gitsigns.lua)
vim.keymap.set({ "n", "v" }, "<leader>hr", function()
  vscode.action("git.unstageSelectedRanges")
end, { desc = "Reset/unstage hunk" })

-- <leader>hb: blame line (matches gitsigns.lua)
vim.keymap.set("n", "<leader>hb", function()
  vscode.action("gitlens.toggleLineBlame")
end, { desc = "Blame line" })

-- <leader>hd: diff this (matches gitsigns.lua)
vim.keymap.set("n", "<leader>hd", function()
  vscode.action("git.openChange")
end, { desc = "Diff this file" })

-- <leader>tb: toggle git blame (matches gitsigns.lua toggle)
vim.keymap.set("n", "<leader>tb", function()
  vscode.action("gitlens.toggleLineBlame")
end, { desc = "Toggle git blame" })

-- ============================================================================
-- FILE EXPLORER (matches snacks.lua explorer + oil.lua)
-- ============================================================================
-- <leader>e: file explorer (matches snacks explorer)
vim.keymap.set("n", "<leader>e", function()
  vscode.action("workbench.view.explorer")
end, { desc = "File explorer" })

-- <leader>br: rename file (matches snacks rename_file)
vim.keymap.set("n", "<leader>br", function()
  vscode.action("fileutils.renameFile")
end, { desc = "Rename file" })

-- ============================================================================
-- TERMINAL (matches snacks.lua <c-/> and toggleterm.lua)
-- ============================================================================
-- <C-/>: toggle terminal (matches snacks terminal)
vim.keymap.set({ "n", "t" }, "<c-/>", function()
  vscode.action("workbench.action.terminal.toggleTerminal")
end, { desc = "Toggle terminal" })

-- ============================================================================
-- TESTING (<leader>t* — matches vim-test.lua)
-- ============================================================================
-- <leader>tn: run nearest test
vim.keymap.set("n", "<leader>tn", function()
  vscode.action("testing.runAtCursor")
end, { desc = "Test nearest" })

-- <leader>tf: run test file
vim.keymap.set("n", "<leader>tf", function()
  vscode.action("testing.runCurrentFile")
end, { desc = "Test file" })

-- <leader>ts: run test suite
vim.keymap.set("n", "<leader>ts", function()
  vscode.action("testing.runAll")
end, { desc = "Test suite" })

-- <leader>tl: run last test
vim.keymap.set("n", "<leader>tl", function()
  vscode.action("testing.reRunLastRun")
end, { desc = "Test last" })

-- ============================================================================
-- NOTIFICATIONS & UI TOGGLES (matches snacks.lua toggle mappings)
-- ============================================================================
-- <leader>n: notification history (matches snacks notifier history)
vim.keymap.set("n", "<leader>n", function()
  vscode.action("notifications.showList")
end, { desc = "Notification history" })

-- <leader>un: dismiss all notifications (matches snacks hide)
vim.keymap.set("n", "<leader>un", function()
  vscode.action("notifications.clearAll")
end, { desc = "Dismiss all notifications" })

-- <leader>ud: toggle diagnostics (matches snacks toggle)
vim.keymap.set("n", "<leader>ud", function()
  vscode.action("workbench.action.toggleProblemsView")
end, { desc = "Toggle diagnostics" })

-- <leader>uw: toggle word wrap (matches snacks toggle wrap)
vim.keymap.set("n", "<leader>uw", function()
  vscode.action("editor.action.toggleWordWrap")
end, { desc = "Toggle word wrap" })

-- <leader>ul: toggle line numbers (matches snacks toggle line_number)
vim.keymap.set("n", "<leader>ul", function()
  vscode.action("editor.action.toggleLineNumbers")
end, { desc = "Toggle line numbers" })

-- <leader>uL: toggle relative line numbers (matches snacks toggle relativenumber)
vim.keymap.set("n", "<leader>uL", function()
  vscode.action("editor.action.toggleRelativeLineNumbers")
end, { desc = "Toggle relative line numbers" })

-- <leader>us: toggle spell check (matches snacks toggle spell)
vim.keymap.set("n", "<leader>us", function()
  vscode.action("cSpell.toggleEnableSpellChecker")
end, { desc = "Toggle spell check" })

-- ============================================================================
-- DEBUGGER SNIPPETS (matches keymaps.lua)
-- ============================================================================
-- <leader>ir: insert Ruby debugger
vim.keymap.set(
  "n",
  "<leader>ir",
  [[:normal! orequire 'pry-byebug'; binding.pry<cr>]],
  { desc = "Insert Ruby debugger" }
)

-- ============================================================================
-- SCRATCH / MISC (matches snacks.lua)
-- ============================================================================
-- <leader>.: scratch buffer (matches snacks scratch)
vim.keymap.set("n", "<leader>.", function()
  vscode.action("workbench.action.files.newUntitledFile")
end, { desc = "New scratch buffer" })
