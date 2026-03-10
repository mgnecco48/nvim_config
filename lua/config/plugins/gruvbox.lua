return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        overrides = {
          Pmenu = { bg = "none" },
          PmenuKind = { bg = "none" },
          -- PmenuExtra = { bg = "none" },
        },
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
