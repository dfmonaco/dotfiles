  -- Set folding method
  vim.opt.foldmethod = "marker"

	-- Show line numbers
	vim.opt.number = true

	-- Enable mouse support in all modes
	vim.opt.mouse = "a"

	-- Ignore case when searching
	vim.opt.ignorecase = true

	-- Use smart case when searching
	vim.opt.smartcase = true

	-- Disable highlighting search matches
	vim.opt.hlsearch = false

	-- Enable line wrapping
	vim.opt.wrap = true

	-- Set the number of spaces for a tab
	vim.opt.tabstop = 2

	-- Set the number of spaces for one level of indentation
	vim.opt.shiftwidth = 2

	-- Use spaces instead of tabs for indentation
	vim.opt.expandtab = true

	-- Display the sign column, indicating signs like breakpoints, errors, etc.
	vim.opt.signcolumn = "yes"

	-- Reload the file if has been modified ouside of vim
	vim.opt.autoread = true

	-- utf-8 encoding for all files
	vim.opt.encoding = "utf-8"

	-- Show 3 lines of context around the cursor.
	vim.opt.scrolloff = 10

	-- Set the terminal's title
	vim.opt.title = true

	-- Highlight the screen line of the cursor with CursorLine
	vim.opt.cursorline = true

	-- Show line numbers relative to cursor position
	vim.opt.relativenumber = true

	-- This means that	all matches in a line are substituted instead of one.
	vim.opt.gdefault = true

	-- The current mode (e.g., insert mode, normal mode) will not be displayed in the statusline.
	vim.opt.showmode = true

	--- Render colors more accurately and with greater precision
	vim.opt.termguicolors = true

  -- Preview substitutions live, as you type!
  vim.opt.inccommand = 'split'

  --- Filetypes
  vim.filetype.add({
    pattern = { [".*/hyprland%.conf"] = "hyprlang" },
  })
