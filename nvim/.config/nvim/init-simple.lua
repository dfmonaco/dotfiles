-- EDITOR CONFIGURATION {{{1
  -- Options {{{2
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

	-- Enable automatic indentation when starting a new line
	vim.opt.breakindent = true

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

  -- Sets how neovim will display certain whitespace characters in the editor.
  vim.opt.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.opt.inccommand = 'split'

	--- Show the effects of a search / replace in a live preview window
	vim.o.inccommand = "split"

  --- Filetypes
  vim.filetype.add({
    pattern = { [".*/hyprland%.conf"] = "hyprlang" },
  })
-- Mappings {{{2
	vim.g.mapleader = " "

	vim.keymap.set("n", "<tab>", ":bn<CR>", { desc = "Next buffer" })

	vim.keymap.set("n", "<C-tab>", ":bp<CR>", { desc = "Previous buffer" })

	vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to system clipboard" })

	vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Previous window" })

	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Next window" })

	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Previous window" })

	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Next window" })

	vim.keymap.set("n", "<leader>0", ":keepjumps normal! ggVG<cr>", { desc = "Select entire buffer" })

	vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "[q]uit" })

	vim.keymap.set("n", "<leader>x", "<cmd>q!<cr>", { desc = "Quit without saving" })

	vim.keymap.set("n", "<leader>d", "<cmd>bdelete<cr>", { desc = "Buffer [d]elete" })

	vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "[w]rite file" })

	vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Last buffer" })

	vim.keymap.set("n", "<leader>=", "gg=G", { desc = "Autoindent the whole file" })

	vim.keymap.set("n", "<leader>ei", "<cmd>e $MYVIMRC<cr>", { desc = "Edit [i]nit.lua" })

	vim.keymap.set("n", "<leader>ez", "<cmd>e $HOME/.zshrc<cr>", { desc = "Edit [z]shrc" })

	vim.keymap.set("n", "<leader>er", "<cmd>e $HOME/.config/rubocop/config.yml<cr>", { desc = "Edit [r]ubocop" })

  vim.keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { desc = "Escape terminal mode" })

	vim.keymap.set(
		"n",
		"<leader>ir",
		[[:normal! orequire 'pry-byebug'; binding.pry<cr>]],
		{ desc = "insert [r]uby debugger" }
	)

	vim.keymap.set("n",
   "<leader>ij",
   [[:normal! odebugger<cr>]],
   { desc = "insert [j]avascript debugger" }
  )

	local function confirm_and_delete_buffer()
		local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

		if confirm == 1 then
			os.remove(vim.fn.expand("%"))
			vim.api.nvim_buf_delete(0, { force = true })
		end
	end

	vim.keymap.set("n", "<leader>D", confirm_and_delete_buffer, { desc = "[D]elete buffer and file" })
-- EVENT CALLBACKS {{{1

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.highlight.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank({ timeout = 300 })
    end,
  })

