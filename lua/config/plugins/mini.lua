return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })
      require("mini.icons").setup() -- use default config
      require("mini.surround").setup()
    end,
  },
}
