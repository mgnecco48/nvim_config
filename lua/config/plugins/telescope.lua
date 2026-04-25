return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- optional but recommended
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local builtin = require("telescope.builtin")
      -- Finding help
      vim.keymap.set("n", "<leader>fh", builtin.help_tags)
      -- Active Buffers
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Telescope buffers" })
      -- Files in CWD
      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      -- Special picker for my config files
      vim.keymap.set("n", "<leader>co", function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config"),
          prompt_title = "CONFIG",
        })
      end)
      -- Special picker to search my notes directory
      vim.keymap.set("n", "<leader>no", function()
        builtin.find_files({
          cwd = vim.fn.expand("/Users/martin/Documents/notes"),
          prompt_title = "NOTES",
        })
      end)

      --Live-Grep
      vim.keymap.set("n", "<leader>=", function()
        builtin.live_grep({
          prompt_title = "GREEEEEP",
        })
      end)
    end,
  },
}
