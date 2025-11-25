return {
  -- Fuzzy finder
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
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { "tsakirist/telescope-lazy.nvim" },
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

      -- { "<leader>fs",
      --   ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Find [s]tring in files" },

      { "<leader>fs",
        "<cmd>Telescope live_grep<cr>", desc = "Find [s]tring in files" },

      { "<leader>fd",
        "<cmd>Telescope diagnostics<cr>", desc = "Find [d]iagnostics" },

      { "<leader>fh",
        "<cmd>Telescope help_tags<cr>", desc = "Find [h]elp" },

      { "<leader>fy",
        "<cmd>Telescope neoclip<cr>", desc = "Find [y]anks" },

      { "<leader>fk",
        "<cmd>Telescope keymaps<cr>", desc = "Find [k]eymaps" },

      { "<leader>fn",
        "<cmd>Telescope notify<cr>", desc = "Find [n]notifications" },

      { "<leader>fg",
        "<cmd>Telescope git_status<cr>", desc = "Find [g]it status" },
    },
    config = function()
      local telescope = require("telescope")

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

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup({
        pickers = {
          live_grep = {
            file_ignore_patterns = { 'node_modules', '.git' },
            additional_args = function(_)
              return { "--hidden" }
            end
          },
          find_files = {
            file_ignore_patterns = { 'node_modules', '.git' },
            hidden = true
          }
        },
        defaults = {
          mappings = {
            i = {
              ["<CR>"] = select_one_or_multi,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = { -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-h>"] = lga_actions.quote_prompt({ postfix = " --hidden " }),
              },
            },
          }
        },
      })

      telescope.load_extension("live_grep_args")
      telescope.load_extension("fzf")

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

}
