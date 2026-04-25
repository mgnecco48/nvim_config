return {
  "nvim-treesitter/nvim-treesitter-textobjects",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    textobjects = {

      -- Selecting code blocks
      select = {
        enable = true,
        lookahead = true,

        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",

          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },

      -- Moving between code structures
      move = {
        enable = true,
        set_jumps = true,

        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },

        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        -- Keymaps to swap next/previous
        swap_next = {
          ["<leader>sa"] = "@parameter.inner", -- Swap next parameter
        },
        swap_previous = {
          ["<leader>sA"] = "@parameter.inner", -- Swap previous parameter
        },
      },
    },
  },
}
