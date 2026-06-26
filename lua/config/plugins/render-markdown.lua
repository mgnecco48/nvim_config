return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    render_modes = true,
    file_types = { "markdown", "quarto" },
    heading = {
      width = "block",
      min_width = 30,
      border = true,
    },
    dash = { width = 160 },
    indent = { enabled = true },
    code = {
      sign = false,
      language_border = " ",
      language_left = "",
      language_right = "",
      width = "block",
      left_pad = 2,
      right_pad = 2,
    },
    pipe_table = {
      preset = "round",
      cell = "trimmed",
    },
  },
}
