-- Key mappings
local keymap = vim.keymap

-- Leader key setup
-- Disable space in normal mode to prevent conflicts before setting it as leader
keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " " -- Set space as leader key
vim.g.maplocalleader = "," -- Set local leader to comma (used for buffer-local keymaps)

-- General
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- File operations
keymap.set("n", "<leader>j", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit (will prompt if unsaved changes)" })

-- Buffer operations (organized under <leader>b*)
keymap.set("n", "<Tab>", ":bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<S-Tab>", ":bp<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<leader>ba", ":keepjumps normal! ggVG<CR>", { desc = "Select all in buffer" })
keymap.set("n", "<leader>b=", "gg=G", { desc = "Auto-indent entire buffer" })
keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Toggle between last two buffers" })

-- Delete buffer and file (dangerous operation under <leader>b*)
local function confirm_and_delete_buffer()
  local confirm = vim.fn.confirm("Delete buffer and file from disk?", "&Yes\n&No", 2)
  if confirm == 1 then
    local filepath = vim.fn.expand("%")
    os.remove(filepath)
    vim.api.nvim_buf_delete(0, { force = true })
    vim.notify("Deleted: " .. filepath, vim.log.levels.INFO)
  end
end
keymap.set("n", "<leader>bD", confirm_and_delete_buffer, { desc = "Delete buffer AND file (dangerous!)" })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window management
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

-- Window resizing (Arrow keys)
keymap.set({ "n", "v" }, "<Left>", "<cmd>vertical resize 1<CR>", { desc = "Minimize window width" })
keymap.set({ "n", "v" }, "<Right>", "<C-w>=", { desc = "Equalize all windows" })

-- Terminal mode
keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode to normal mode" })

-- Visual mode indenting
-- Keeps selection after indenting so you can indent multiple times
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
