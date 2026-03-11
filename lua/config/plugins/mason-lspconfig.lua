return {
  {
    "mason-org/mason-lspconfig.nvim",

    opts = {
      ensure_installed = {
        "pyright",
        "lua_ls",
        "dockerls",
        "sqlls",
        "jsonls",
        "yamlls",
        "bashls",
        "marksman",
        "taplo",
        "hyprls",
        "vim",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
