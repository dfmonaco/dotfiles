vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
