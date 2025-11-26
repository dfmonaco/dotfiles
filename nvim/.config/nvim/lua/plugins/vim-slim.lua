return {
  "slim-template/vim-slim",

  -- Only load when opening Slim template files
  ft = "slim",

  -- Ensure proper filetype detection (fixes known issue with doctype html)
  init = function()
    -- Override filetype detection to prevent .slim files being detected as html
    -- This fixes an issue where 'doctype html' causes Vim to set filetype to html
    -- before vim-slim can claim it. See: https://github.com/slim-template/vim-slim/issues/38
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.slim",
      callback = function()
        vim.bo.filetype = "slim"
      end,
    })
  end,
}
