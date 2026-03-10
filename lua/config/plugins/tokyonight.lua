return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        on_highlights = function(hl, c)
          hl.BlinkCmpMenu = {
            bg = "none",
          }
          hl.BlinkCmpMenuBorder = {
            bg = "none",
          }
          hl.BlinkCmpMenuSelection = {
            bg = "#3c3836",
          }
          hl.BlinkCmpScrollBarThumb = {
            bg = "#ffbf00",
          }
        end,
      })
      -- vim.cmd.colorscheme("tokyonight-night")
    end,
  },
}
