return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",

  dependencies = {
    "mason-org/mason.nvim",
  },

  opts = {
    ensure_installed = {

      -- LSP servers
      "pyright",
      "lua-language-server",
      "bash-language-server",
      "dockerfile-language-server",
      "yaml-language-server",
      "json-lsp",
      "marksman",
      "taplo",
      "sqlls",
      "hyprls",
      "vimls",
      "gopls",

      -- formatters
      "black",
      "isort",
      "stylua",
      "shfmt",
      "ruff",
      "jq",
      "yamlfmt",
      "prettier",
      "goimports",
      "google-java-format",

      -- linters
      "shellcheck",
      "sqlfluff",
      "golangci-lint",
    },

    auto_update = false,
    run_on_start = true,
  },
}
