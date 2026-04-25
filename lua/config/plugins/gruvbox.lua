return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        overrides = {
          Pmenu = { bg = "none" },
          PmenuKind = { bg = "none" },
          PmenuExtra = { bg = "none" },
          BlinkCmpScrollBarThumb = { bg = "#ffbf00" },
          BlinkCmpMenuSelection = { bg = "#665c54", fg = "#44eb44" },
          -- BlinkDocSeparator = { fg = "#44eb44" },
        },
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
