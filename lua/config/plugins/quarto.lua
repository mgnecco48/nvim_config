return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
    },
    dev = false,
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)

      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
      vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set("n", "<localleader>RA", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages", silent = true })
    end,
  },
  { -- directly open ipynb files as markdown documents
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
    config = function(_, opts)
      local jupytext_bin = "/opt/miniconda3/envs/nvim-jupyter/bin"
      if vim.fn.executable("jupytext") == 0 and vim.fn.isdirectory(jupytext_bin) == 1 then
        vim.env.PATH = jupytext_bin .. ":" .. vim.env.PATH
      end

      -- Avoid unreadable system config dirs when the jupytext CLI searches for config.
      vim.env.XDG_CONFIG_DIRS = vim.env.XDG_CONFIG_DIRS or vim.fn.expand("~/.config")
      require("jupytext").setup(opts)
    end,
  },
}
