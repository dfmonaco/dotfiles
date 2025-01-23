return {
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
  -- Quick Browser search
  {
    "voldikss/vim-browser-search",
    keys = {
      {
        "<C-l>",
        "<Plug>SearchVisual",
        mode = "v",
        desc = "Search visual selection"
      },
    }
  },
}
