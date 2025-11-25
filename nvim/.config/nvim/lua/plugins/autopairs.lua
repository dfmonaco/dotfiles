return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- Enable treesitter integration
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      typescript = { "string", "template_string" },
    },
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    -- Integration with blink.cmp
    local cmp = require("blink.cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
