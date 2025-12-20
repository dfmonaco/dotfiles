return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufReadPost",
  opts = {
    -- Render style: virtual text with colored symbols
    render = "virtual",
    virtual_symbol = "■",
    virtual_symbol_prefix = "",
    virtual_symbol_suffix = " ",
    virtual_symbol_position = "inline", -- VS Code style inline symbols

    -- Enable all color formats
    enable_hex = true,           -- #FFFFFF
    enable_short_hex = true,     -- #fff
    enable_rgb = true,           -- rgb(0 0 0)
    enable_hsl = true,           -- hsl(150deg 30% 40%)
    enable_ansi = true,          -- \033[0;34m
    enable_hsl_without_function = true, -- --foreground: 0 69% 69%;
    enable_var_usage = true,     -- var(--testing-color)
    enable_named_colors = true,  -- green, blue, red, etc.
    enable_tailwind = true,      -- Tailwind class color previews (requires tailwindcss LSP)

    -- Exclude file types to prevent distractions and performance issues
    exclude_filetypes = {
      "log",           -- Log files often have ANSI codes
      "text",          -- Plain text files
      "markdown",      -- Documentation
      "help",          -- Vim help files
      "txt",           -- Text files
      "conf",          -- Config files (usually no colors)
    },
    
    -- Exclude buffer types
    exclude_buftypes = {
      "terminal",      -- Terminal buffers have their own colors
      "prompt",        -- Command prompts
      "nofile",        -- Scratch buffers
    },

    -- Exclude large files (> 1MB) to prevent performance issues
    exclude_buffer = function(bufnr)
      local max_filesize = 1024 * 1024 -- 1 MB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max_filesize then
        return true
      end
      return false
    end,
  },
}
