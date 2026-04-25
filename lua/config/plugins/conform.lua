return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" },

  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },

    formatters_by_ft = {

      -- Python
      python = { "ruff_format" },

      -- Lua
      lua = { "stylua" },

      -- JSON
      json = { "jq" },

      -- YAML
      yaml = { "yamlfmt" },

      -- Bash
      sh = { "shfmt" },

      -- Markdown
      markdown = { "prettier" },

      -- TOML
      toml = { "taplo" },

      -- SQL
      sql = { "sqlfluff" },

      -- Dockerfile
      dockerfile = { "hadolint" },

      java = { "google-java-format" },
    },
  },

  config = function(_, opts)
    require("conform").setup(opts)

    -- manual formatting keymap
    vim.keymap.set({ "n", "v" }, "<leader>g", function()
      require("conform").format({
        async = true,
        lsp_fallback = true,
      })
    end, { desc = "Format buffer" })
  end,
}
