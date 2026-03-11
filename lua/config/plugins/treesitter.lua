return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local filetypes = {
        "python",
        "markdown",
        "lua",
        "dockerfile",
        "sql",
        "hyprlang",
        "json",
        "toml",
        "yaml",
        "bash",
        "zsh",
        "vim",
      }
      require("nvim-treesitter").setup({
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install(filetypes)

      vim.api.nvim_create_autocmd("Filetype", {
        pattern = filetypes,
        callback = function()
          -- syntax highlighting, provided by Neovim
          vim.treesitter.start()
          -- indentation, provided by nvim-treesitter
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
