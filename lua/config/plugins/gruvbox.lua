return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        overrides = {
          Pmenu = { bg = "none", fg = "#98FBCB" },
          PmenuKind = { bg = "none" },
          PmenuExtra = { bg = "none" },
          BlinkCmpScrollBarThumb = { bg = "#ffbf00" },
          BlinkCmpMenuSelection = { bg = "#665c54", fg = "#98FBCB" },
          CocSearch = { fg = "none" },
        },
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
--- #30C030
---
