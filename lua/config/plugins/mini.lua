return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      -- local statusline = require("mini.statusline")
      -- statusline.setup({ use_icons = true })
      require("mini.icons").setup() -- use default config
      require("mini.surround").setup()
      require("mini.indentscope").setup({
        symbol = "▏",
        -- symbol = "│",
        options = { try_as_border = true },
      })
      require("mini.pairs").setup({
        modes = { insert = true, command = true, terminal = false },
        -- skip autopair when next character is one of these
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        -- skip autopair when the cursor is inside these treesitter nodes
        skip_ts = { "string" },
        -- skip autopair when next character is closing pair
        -- and there are more closing pairs than opening pairs
        skip_unbalanced = true,
        -- better deal with markdown code blocks
        markdown = true,
      })
    end,
  },
}
