-- VSCODE SETTINGS {{{1
if vim.g.vscode then
	local vscode = require("vscode-neovim")

	-- Set space as the leader key
	vim.g.mapleader = " "

	-- Disable highlighting search matches
	vim.opt.hlsearch = false

	-- Set the number of spaces for a tab
	vim.opt.tabstop = 2

	-- Set the number of spaces for one level of indentation
	vim.opt.shiftwidth = 2

	-- Use spaces instead of tabs for indentation
	vim.opt.expandtab = true

	vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to system clipboard" })

	vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

	vim.keymap.set("n", "<leader>ei", "<cmd>e $MYVIMRC<cr>", { desc = "Edit [i]nit.lua" })

	vim.keymap.set(
		"n",
		"<leader>ir",
		[[:normal! orequire 'pry-byebug'; binding.pry<cr>]],
		{ desc = "insert [r]uby debugger" }
	)

	-- Finds the workd under the cursor in all project files
	vim.keymap.set("n", "?", function()
		local query = vim.fn.expand("<cword>")
		vscode.action("workbench.action.findInFiles", { args = { query = query } })
	end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>f", function()
		vscode.action("workbench.action.findInFiles")
	end, { noremap = true, silent = true })

	vim.keymap.set("v", "<leader>f", function()
		vscode.action("workbench.action.findInFiles")
	end, { noremap = true, silent = true })

  vim.keymap.set("v", "<leader>r", function()
    vscode.call("editor.action.startFindReplaceAction")
  end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>w", function()
		vscode.call("workbench.action.files.save")
	end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>o", function()
		vscode.call("editor.action.openLink")
	end, { noremap = true, silent = true })

else

-- EDITOR CONFIGURATION {{{1

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
	vim.opt.scrolloff = 3

	-- Set the terminal's title
	vim.opt.title = true

	-- Highlight the screen line of the cursor with CursorLine
	vim.opt.cursorline = true

	-- Show line numbers relative to cursor position
	vim.opt.relativenumber = true

	-- This means that	all matches in a line are substituted instead of one.
	vim.opt.gdefault = true

	-- The current mode (e.g., insert mode, normal mode) will not be displayed in the statusline.
	vim.opt.showmode = false

	--- Render colors more accurately and with greater precision
	vim.opt.termguicolors = true

	--- Show the effects of a search / replace in a live preview window
	vim.o.inccommand = "split"
-- Mappings {{{2
  -- Standard {{{3
	vim.g.mapleader = " "

	vim.keymap.set("n", "<tab>", ":bn<CR>", { desc = "Next buffer" })

	vim.keymap.set("n", "<C-tab>", ":bp<CR>", { desc = "Previous buffer" })

	vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to system clipboard" })

	vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Previous window" })

	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Next window" })

	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Previous window" })

	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Next window" })

	vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { desc = "Select entire buffer" })

	vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "[q]uit" })

	vim.keymap.set("n", "<leader>x", "<cmd>q!<cr>", { desc = "Quit without saving" })

	vim.keymap.set("n", "<leader>d", "<cmd>bdelete<cr>", { desc = "Buffer [d]elete" })

	vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "[w]rite file" })

	vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Last buffer" })

	vim.keymap.set("n", "<leader>=", "gg=G", { desc = "Autoindent the whole file" })
-- Edit Files {{{3
	vim.keymap.set("n", "<leader>ei", "<cmd>e $MYVIMRC<cr>", { desc = "Edit [i]nit.lua" })

	vim.keymap.set("n", "<leader>ez", "<cmd>e $HOME/.zshrc<cr>", { desc = "Edit [z]shrc" })

	vim.keymap.set("n", "<leader>er", "<cmd>e $HOME/.config/rubocop/config.yml<cr>", { desc = "Edit [r]ubocop" })
-- Insert Text {{{3
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
-- Custom Functions {{{3
	local function confirm_and_delete_buffer()
		local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

		if confirm == 1 then
			os.remove(vim.fn.expand("%"))
			vim.api.nvim_buf_delete(0, { force = true })
		end
	end

	vim.keymap.set("n", "<leader>D", confirm_and_delete_buffer, { desc = "[D]elete buffer and file" })
-- EVENT CALLBACKS {{{1
	local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight on yank",
		group = group,
		callback = function()
			vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
		end,
	})

-- PLUGINS {{{1
-- Lazy Config {{{2

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

	require('lazy').setup({
	-- Plugin Settings {{{2
    --  { "rebelot/kanagawa.nvim" }, [Theme] {{{3
    { "rebelot/kanagawa.nvim",
    },
		-- { "folke/tokyonight.nvim" }, [Theme] {{{3
		{ "folke/tokyonight.nvim" },
		-- { "joshdick/onedark.vim" }, [Theme] {{{3
		{ "joshdick/onedark.vim" },
		-- { "lunarvim/darkplus.nvim" }, [Theme] {{{3
		{
      "lunarvim/darkplus.nvim",
    },
    --  { "catppuccin/nvim" }, [Theme] {{{3
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme catppuccin]])
      end,
      opts = {
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      },
    },
		-- { "kyazdani42/nvim-web-devicons" }, [Provides icons for files, directories, etc.] {{{3
		{ "nvim-tree/nvim-web-devicons" },
		-- { "nvim-lualine/lualine.nvim" }, [Configurable status line] {{{3
		{
      "nvim-lualine/lualine.nvim",
      config = function()
        require("lualine").setup({
          options = {
            theme = "catppuccin",
            icons_enabled = true,
            component_separators = "|",
            section_separators = "",
          },
          sections = {
            lualine_c = {
              "vim.call('codeium#GetStatusString')",
              require("lsp-progress").progress,
            },
          },
        })

        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
          group = "lualine_augroup",
          pattern = "LspProgressStatusUpdated",
          callback = require("lualine").refresh,
        })
      end,
    },
		-- { "akinsho/bufferline.nvim" }, [Enhanced buffer line (tab line)] {{{3,
		{
      "akinsho/bufferline.nvim",
      config = function()
        require("bufferline").setup({
          options = {
            mode = "buffers",
            offsets = {
              { filetype = "NvimTree" },
            },
          },
          -- :help bufferline-highlights
          highlights = {
            buffer_selected = {
              italic = false,
            },
            indicator_selected = {
              -- Set the foreground color based on the 'Function' highlight group's foreground attribute.
              fg = { attribute = "fg", highlight = "Function" },
              italic = false,
            },
          },
        })
      end,
    },
		-- { "lukas-reineke/indent-blankline.nvim" }, [Displays indent lines] {{{3
		{
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("ibl").setup({
          enabled = true,
          scope = {
            enabled = false,
          },
          indent = {
            char = "┊",
          },
        })
      end,
    },
		-- { "slim-template/vim-slim" }, [Provides syntax highlighting for Slim templates] {{{3
		{ "slim-template/vim-slim" },
		-- { "zaldih/themery.nvim" }, [Theme switcher] {{{3
		{
      "zaldih/themery.nvim",
      config = function()
        require("themery").setup({
          themes = {
            "tokyonight",
            "onedark",
            "darkplus",
            "catppuccin",
            "catppuccin-latte",
            "catppuccin-frappe",
            "catppuccin-macchiato",
            "catppuccin-mocha",
            "kanagawa",
            "kanagawa-dragon",
            "kanagawa-wave",
            "kanagawa-lotus",
          },
          livePreview = true,
        })
      end,
    },
		-- { "nvim-treesitter/nvim-treesitter" }, [Language parsing and manipulation] {{{3
		{ "nvim-treesitter/nvim-treesitter",
      config = function()
        require("nvim-treesitter.configs").setup({
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
          textobjects = {
            select = {
              -- Enable text objects selection with lookahead.
              enable = true,
              lookahead = true,
              keymaps = {
                -- Define key mappings for various text objects.
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
              },
            },
          },
          ensure_installed = {
            "javascript",
            "typescript",
            "tsx",
            "lua",
            "vim",
            "vimdoc",
            "css",
            "json",
            "ruby",
            "python",
          },
        })
      end,
    },
		-- { "nvim-treesitter/nvim-treesitter-textobjects" }, [Additional text objects for treesitter] {{{3
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		-- { "akinsho/toggleterm.nvim" }, [Terminal toggling] {{{3
		{
      "akinsho/toggleterm.nvim",
      config = function()
        require("toggleterm").setup({
          open_mapping = "<C-g>",
          direction = "float",
          shade_terminals = true,
          size = function(term)
            if term.direction == "horizontal" then
              return 15
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.5
            end
          end,
        })

        local Terminal = require("toggleterm.terminal").Terminal

        vim.keymap.set("n", "<leader>os", function()
          Terminal:new({ cmd = "rails s", hidden = true, name = "rails server" }):toggle()
        end, { noremap = true, silent = true, expr = true, desc = "[s]server" })

        vim.keymap.set("n", "<leader>oc", function()
          Terminal:new({ cmd = "rails c", hidden = true, name = "rails console" }):toggle()
        end, { noremap = true, silent = true, expr = true, desc = "[c]onsole" })

        vim.keymap.set("n", "<leader>o1", "<cmd>1ToggleTerm name=Term1<cr>", { desc = "Open [1] terminal" })

        vim.keymap.set("n", "<leader>o2", "<cmd>2ToggleTerm name=Term2<cr>", { desc = "Open [2] terminal" })
      end,
    },
    -- { "Exafunction/codeium.vim" }, [AI code completion] {{{3
		{
			"Exafunction/codeium.vim",
			event = "BufEnter",
			config = function()
				vim.keymap.set("i", "<C-h>", function()
					return vim.fn["codeium#Accept"]()
				end, { expr = true })
				vim.keymap.set("i", "<C-j>", function()
					return vim.fn["codeium#CycleCompletions"](1)
				end, { expr = true })
				vim.keymap.set("i", "<C-k>", function()
					return vim.fn["codeium#CycleCompletions"](-1)
				end, { expr = true })
				vim.keymap.set("i", "<C-BS>", function()
					return vim.fn["codeium#Clear"]()
				end, { expr = true })
				vim.keymap.set("n", "<C-i>", function()
					return vim.fn["codeium#Chat"]()
				end, { expr = true })
			end,
		},
		-- { "folke/which-key.nvim" }, [Provides which-key integration] {{{3
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
      config = function()
        require("which-key").register({
          ["<leader>f"] = { name = "[f]ind" },
          ["<leader>e"] = { name = "[e]dit" },
          ["<leader>r"] = { name = "[r]eplace" },
          ["<leader>t"] = { name = "[t]est" },
          ["<leader>s"] = { name = "[s]earch" },
          ["<leader>h"] = { name = "[h]unk", _ = "which_key_ignore" },
          ["<leader>l"] = { name = "[l]sp", _ = "which_key_ignore" },
          ["<leader>o"] = { name = "[o]open", _ = "which_key_ignore" },
          ["<leader>i"] = { name = "[i]insert", _ = "which_key_ignore" },
        })
      end,
		},
		-- { "piersolenski/wtf.nvim" }, [Debug diagnostics with AI or Google] {{{3
		{
			"piersolenski/wtf.nvim",
			dependencies = {
				"MunifTanjim/nui.nvim",
			},
			opts = {},
			keys = {
				{
					"gw",
					mode = { "n", "x" },
					function()
						require("wtf").ai()
					end,
					desc = "Debug diagnostic with AI",
				},
				{
					mode = { "n" },
					"gW",
					function()
						require("wtf").search()
					end,
					desc = "Search diagnostic with Google",
				},
			},
		},
		-- { "AckslD/nvim-neoclip.lua" }, [Clipboard manager] {{{3
		{
      "AckslD/nvim-neoclip.lua",
      config = function()
	      require("neoclip").setup({})
      end,
    },
		-- { "lalitmee/browse.nvim" }, [Browser integration] {{{3
		{
			"lalitmee/browse.nvim",
			dependencies = { "nvim-telescope/telescope.nvim" },
      config = function()
        require("browse").setup({})

        local bookmarks = {
          ["search"] = {
            ["github"] = "https://github.com/search?q=%s&type=repositories",
            ["youtube"] = "https://www.youtube.com/results?search_query=%s",
            ["stackoverflow"] = "https://stackoverflow.com/search?q=%s",
            ["google"] = "https://www.google.com/search?q=%s",
            ["wikipedia"] = "https://en.wikipedia.org/w/index.php?search=%s",
          },
          ["pulls"] = {
            ["amg"] = "https://github.com/Miltheory/kronickle-directv-assetcenter/pulls",
            ["bs"] = "https://github.com/Miltheory/kronickle-directv-brandspace/pulls",
            ["cs"] = "https://github.com/Miltheory/kronickle-directv-creativeservices/pulls",
            ["legal"] = "https://github.com/Miltheory/kronickle-dtv-legal/pulls",
            ["att"] = "https://github.com/Miltheory/kronickle-att/pulls",
          },
          ["sites"] = {
            ["amg"] = "https://kronickle-dev.herokuapp.com",
            ["bs"] = "https://kronickle-brandspace-dev.herokuapp.com",
            ["cs"] = "https://kronickle-directv-cs-dev.herokuapp.com",
            ["legal"] = "https://kronickle-dtv-legal-dev.herokuapp.com",
            ["att"] = "https://kronickle-att-dev.herokuapp.com",
          },
        }

        vim.keymap.set("n", "<leader>b", function()
          require("browse").open_bookmarks({ bookmarks = bookmarks })
        end, { desc = "[b]rowse bookmarks" })
      end,
		},
		-- { "stevearc/dressing.nvim" }, [Improved input and select] {{{3
		{
			"stevearc/dressing.nvim",
      config = function()
        require("dressing").setup({
          input = {
            enabled = true,
            prompt = "➤ ",
            relative = "editor",
            position = "center",
          },
          select = {
            enabled = true,
            backend = { "telescope", "fzf", "builtin" },
          },
        })
      end,
		},
    --  { "rcarriga/nvim-notify" }, [Improved notifications] {{{3
    {
      "rcarriga/nvim-notify",
      opts = {
        stages = "static",
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
      },
      init = function()
        vim.notify = require("notify")
      end,
    },
		-- { "roobert/search-replace.nvim" }, [Search and replace] {{{3
		{
      "roobert/search-replace.nvim",
      keys = {
        {
          "<C-r>",
          "<CMD>SearchReplaceSingleBufferVisualSelection<CR>",
          mode = "v",
          desc = "Visual search/replace in buffer"
        },
        {
          "<C-s>",
          "<CMD>SearchReplaceWithinVisualSelection<CR>",
          mode = "v",
          desc = "Search/replace within visual selection"
        },
        {
          "<leader>rw",
          "<CMD>SearchReplaceSingleBufferCWord<CR>",
          desc = "Search/replace in buffer for [w]ord"
        },
        {
          "<leader>rW",
          "<CMD>SearchReplaceSingleBufferCWORD<CR>",
          desc = "Search/replace in buffer for [W]WORD"
        },
      },
      config = function()
	      require("search-replace").setup({})
      end,
    },
		-- { "numToStr/Comment.nvim" }, [Commenting] {{{3
		{
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },
		-- { "tpope/vim-surround" }, [Add mappings to easily manipulate surroundings] {{{3
		{ "tpope/vim-surround" },
		-- { "wellle/targets.vim" }, [Extends text objects to support additional targets] {{{3
		{ "wellle/targets.vim" },
		-- { "tpope/vim-repeat" }, [Repeats supported plugin commands with '.'] {{{3
		{ "tpope/vim-repeat" },
		-- { "nvim-pack/nvim-spectre", [Search and replace Panel] {{{3
		{ "nvim-pack/nvim-spectre",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      keys = {
        {
          "<leader>sp",
          '<cmd>lua require("spectre").toggle()<CR>',
          desc = "Toggle Search/Replace [p]anel",
        },
        {
          "<leader>sw",
          '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
          desc = "Search current [w]ord on all files",
        },
        { "<leader>sb",
          '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
          desc = "Search current word on current [b]uffer",
        },
      },
      config = function()
        require("spectre").setup({
          highlight = {
            ui = "String",
            search = "DiffChange",
            replace = "DiffDelete",
          },
        })
      end,
		},

		-- { "neovim/nvim-lspconfig" }, [LSP config] {{{3
		{
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", config = true },
      },
      config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        -- used to enable autocompletion (assign to every lsp server config
        local capabilities = cmp_nvim_lsp.default_capabilities()

        mason.setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            }
          }
        })

        mason_lspconfig.setup({
          handlers = {
            ["lua_ls"] = function()
              lspconfig.lua_ls.setup({
                settings = {
                  Lua = {
                    diagnostics = {
                      globals = { "vim" },
                    }
                  }
                }
              })
            end,
            ["solargraph"] = function()
              lspconfig.solargraph.setup({
                capabilities = capabilities,
                filetypes = { "ruby" },
              })
            end,
            ["pyright"] = function()
              lspconfig.pyright.setup({
                capabilities = capabilities,
              })
            end,
            ["tsserver"] = function()
              lspconfig.tsserver.setup({
                capabilities = capabilities,
                root_dir = util.root_pattern(".git")
              })
            end,
          },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
          group = group,
          desc = "LSP actions",
          callback = function()
            local bufmap = function(mode, keys, cmd, opts)
              opts.buffer = true
              vim.keymap.set(mode, keys, cmd, opts)
            end

            -- You can search each function in the help page.
            -- For example :help vim.lsp.buf.hover()

            -- It shows information about the symbol under the cursor
            bufmap("n", "<leader>li", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Show [i]nfo" })

            -- It jumps to the definition of the symbol under the cursor
            bufmap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to [d]efinition" })

            -- Lists all the implementations of the symbol under the cursor
            bufmap("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "List [i]mplementations" })
            -- Displays the signature of the function
            bufmap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Show [s]ignature" })

            -- Formats the buffer using the current language server
            bufmap(
              { "n", "x" },
              "<leader>lf",
              "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
              { desc = "Buffer [f]ormat" }
            )

            -- Selects a code action available at the current cursor position
            bufmap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Select code [a]ction" })
          end,
        })
      end,
    },
		-- { "folke/trouble.nvim"}, [Diagnostics panel] {{{3
		{
			"folke/trouble.nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
      keys = {
        { "<leader>lp", function()
            require("trouble").toggle()
          end, desc = "Toggle diagnostics [p]anel"
        },
        { "<leader>lr", function()
            require("trouble").toggle("lsp_references")
          end, desc = "Toggle LSP [r]eferences"
        },
      },
      config = function()
	      require("trouble").setup({})
      end,
		},
		-- { "linrongbin16/lsp-progress.nvim" }, [LSP progress] {{{3
		{
			"linrongbin16/lsp-progress.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
	      require("lsp-progress").setup({})
      end,
		},
		-- { "creativenull/efmls-configs-nvim" }, [Language server config] {{{3
		{
			"creativenull/efmls-configs-nvim",
			version = "v1.x.x", -- version is optional, but recommended
			dependencies = { "neovim/nvim-lspconfig" },
      config = function()
        local languages = require("efmls-configs.defaults").languages()
        -- To extend and add additional tools or to override existing
        -- defaults registered:
        languages = vim.tbl_extend("force", languages, {
          -- you custom languages, or overrides
          slim = {
            require("efmls-configs.linters.slim_lint"),
          },
        })
        local efmls_config = {
          filetypes = vim.tbl_keys(languages),
          settings = {
            rootMarkers = { ".git/" },
            languages = languages,
          },
          init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
          },
        }

        require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {}))
      end,
		},
		-- { "stevearc/oil.nvim" }, [File explorer that lets you edit your filesystem] {{{3
		{
      "stevearc/oil.nvim",
      config = function()
        require("oil").setup()
      end,
    },
		-- { "nvim-telescope/telescope.nvim" }, [Fuzzy finder] {{{3
		{
			"nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      version = false,
			dependencies = {
		    { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
        },
        {
          "nvim-telescope/telescope-live-grep-args.nvim",
          version = "^1.0.0",
        },
			},
      keys = {
        { "<leader>fr",
          "<cmd>Telescope oldfiles<cr>", desc = "Find [r]ecently opened files" },

        { "<leader>fb",
          "<cmd>Telescope buffers<cr>", desc = "Find current [b]uffers" },

        { "<leader>fa",
          "<cmd>Telescope git_files<cr>", desc = "Find [a]ll files" },

        { "<leader>ff",
          "<cmd>Telescope find_files<cr>", desc = "Find git [f]iles" },

        { "<leader>fs",
          ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Find [s]tring in files" },

        { "<leader>fd",
          "<cmd>Telescope diagnostics<cr>", desc = "Find [d]iagnostics" },

        { "<leader>fh",
          "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find string [h]ere" },

        { "<leader>fy",
          "<cmd>Telescope neoclip<cr>", desc = "Find [y]anks" },
      },
			config = function()
				require("telescope").load_extension("live_grep_args")
        require("telescope").load_extension("fzf")

        local select_one_or_multi = function(prompt_bufnr)
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          local multi = picker:get_multi_selection()
          if not vim.tbl_isempty(multi) then
            require("telescope.actions").close(prompt_bufnr)
            for _, j in pairs(multi) do
              if j.path ~= nil then
                vim.cmd(string.format("%s %s", "edit", j.path))
              end
            end
          else
            require("telescope.actions").select_default(prompt_bufnr)
          end
        end

        require("telescope").setup({
          defaults = {
            mappings = {
              i = {
                ["<CR>"] = select_one_or_multi,
              },
            },
          },
        })

        -- Fix Telescope bug
        -- https://github.com/nvim-telescope/telescope.nvim/issues/2027#issuecomment-1561836585
        -- https://github.com/nvim-telescope/telescope.nvim/issues/2766
        vim.api.nvim_create_autocmd("WinLeave", {
          callback = function()
            if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
            end
          end,
        })
			end,
		},
		-- { "nvim-neotest/neotest" }, [Test runner] {{{3
		{
			"nvim-neotest/neotest",
			dependencies = {
        "nvim-neotest/nvim-nio",
				"nvim-lua/plenary.nvim",
				"antoinemadec/FixCursorHold.nvim",
				"olimorris/neotest-rspec",
			},
      keys = {
        { "<leader>tt", function()
          require("neotest").run.run()
        end, desc = "Run nearest [t]est"},

        { "<leader>tf", function()
          require("neotest").run.run(vim.fn.expand("%"))
        end, desc = "Run [f]ile"},

        { "<leader>to", function()
          require("neotest").output.open({ enter = true })
        end, desc = "Open test [o]utput"},

        { "<leader>ts", function()
          require("neotest").summary.toggle()
        end, desc = "Toggle test [s]ummary"},

        { "<leader>tp", function()
          require("neotest").output_panel.toggle()
        end, desc = "Toggle test output [p]anel"},
      },
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-rspec"),
          },
        })
      end,
		},
		-- { "lewis6991/gitsigns.nvim" }, [Git signs and hunk management] {{{3
		{
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({
          signs = {
            add = { text = "+" },
            change = { text = "#" },
            delete = { text = "-" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
          },
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]h", function()
              if vim.wo.diff then
                return "]h"
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return "<Ignore>"
            end, { expr = true, desc = "Next hunk" })

            map("n", "[h", function()
              if vim.wo.diff then
                return "[h"
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return "<Ignore>"
            end, { expr = true, desc = "Previous hunk" })

            -- Actions
            map("v", "<leader>hs", function()
              gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Hunk [s]tage in selection" })
            map("v", "<leader>hr", function()
              gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Hunk [r]eset in selection" })

            map("n", "<leader>hs", gs.stage_hunk, { desc = "Hunk [s]tage" })
            map("n", "<leader>hr", gs.reset_hunk, { desc = "Hunk [r]eset" })
            map("n", "<leader>hS", gs.stage_buffer, { desc = "Hunk [S]tage all in buffer" })
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Hunk [u]ndo stage" })
            map("n", "<leader>hR", gs.reset_buffer, { desc = "Hunk [R]eset all in buffer" })
            map("n", "<leader>hp", gs.preview_hunk, { desc = "Hunk [p]review" })
            map("n", "<leader>hb", function()
              gs.blame_line({ full = true })
            end, { desc = "Line [b]lame" })
            map("n", "<leader>hd", gs.diffthis, { desc = "Hunk [d]iff" })
            map("n", "<leader>hD", function()
              gs.diffthis("~")
            end, { desc = "Hunk [D]iff all in buffer" })
            map("n", "<leader>ht", gs.toggle_deleted, { desc = "Hunk [t]oggle deleted" })
            map("n", "<leader>ha", ":Gitsigns setloclist<CR>", { desc = "Hunk show [a]ll" })

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
          end,
        })
      end,
    },
		-- { "tpope/vim-fugitive" }, [Git wrapper] {{{3
		{ "tpope/vim-fugitive" },
    -- { "folke/noice.nvim" }, [replaces the UI for messages, cmdline and the popupmenu] {{{3
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        },
      config = function()
        require("noice").setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        })
      end,
    },
    --  { "hrsh7th/nvim-cmp" } [Autocompletion] {{{3,
    {
      "hrsh7th/nvim-cmp",
      version = false, -- last release is way too old
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
      opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        local defaults = require("cmp.config.default")()
        return {
          auto_brackets = {}, -- configure any filetype to auto add brackets
          completion = {
            completeopt = "menu,menuone,noinsert",
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<S-CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<C-CR>"] = function(fallback)
              cmp.abort()
              fallback()
            end,
          }),
          sources = cmp.config.sources(
          {
            { name = "nvim_lsp" },
            { name = "path" },
          },
          {
            { name = "buffer" },
          }),
          experimental = {
            ghost_text = {
              hl_group = "CmpGhostText",
            },
          },
          sorting = defaults.sorting,
        }
      end,
      config = function(_, opts)
        for _, source in ipairs(opts.sources) do
          source.group_index = source.group_index or 1
        end
        local cmp = require("cmp")
        local Kind = cmp.lsp.CompletionItemKind
        cmp.setup(opts)
        cmp.event:on("confirm_done", function(event)
          if not vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
            return
          end
          local entry = event.entry
          local item = entry:get_completion_item()
          if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
            local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
            vim.api.nvim_feedkeys(keys, "i", true)
          end
        end)
      end,
    },
    -- { "echasnovski/mini.pairs" } [Auto pairs for "" '' () []] {{{3
    {
      "echasnovski/mini.pairs" ,
      event = "VeryLazy",
      config = function()
        require("mini.pairs").setup()
      end,
    },
    -- { "voldikss/vim-browser-search" } [Quick Browser search] {{{3
    {
      "voldikss/vim-browser-search",
      keys = {
        {
          "<C-s>",
          "<Plug>SearchVisual",
          mode = "v",
          desc = "Search visual selection"
        },
      }
    },
    {
        "kdheepak/lazygit.nvim",
    	cmd = {
    		"LazyGit",
    		"LazyGitConfig",
    		"LazyGitCurrentFile",
    		"LazyGitFilter",
    		"LazyGitFilterCurrentFile",
    	},
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
           { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
	})

end


