return {
  "nvim-treesitter/nvim-treesitter-textobjects",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    vim.keymap.set({ "x", "o" }, "af", function()
      select.select_textobject("@function.outer", "textobjects")
    end, { desc = "select around function" })
    vim.keymap.set({ "x", "o" }, "if", function()
      select.select_textobject("@function.inner", "textobjects")
    end, { desc = "select inside function" })
    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end, { desc = "select around class" })
    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end, { desc = "select inside class" })
    vim.keymap.set({ "x", "o" }, "aa", function()
      select.select_textobject("@parameter.outer", "textobjects")
    end, { desc = "select around parameter" })
    vim.keymap.set({ "x", "o" }, "ia", function()
      select.select_textobject("@parameter.inner", "textobjects")
    end, { desc = "select inside parameter" })

    local move = require("nvim-treesitter-textobjects.move")
    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      move.goto_next_start("@function.outer", "textobjects")
    end, { desc = "next function" })
    vim.keymap.set({ "n", "x", "o" }, "[f", function()
      move.goto_previous_start("@function.outer", "textobjects")
    end, { desc = "previous function" })
    vim.keymap.set({ "n", "x", "o" }, "]c", function()
      move.goto_next_start("@class.outer", "textobjects")
    end, { desc = "next class" })
    vim.keymap.set({ "n", "x", "o" }, "[c", function()
      move.goto_previous_start("@class.outer", "textobjects")
    end, { desc = "previous class" })
    vim.keymap.set({ "n", "x", "o" }, "]l", function()
      move.goto_next_start("@code_cell.inner", "textobjects")
    end, { desc = "next code cell" })
    vim.keymap.set({ "n", "x", "o" }, "[l", function()
      move.goto_previous_start("@code_cell.inner", "textobjects")
    end, { desc = "previous code cell" })

    local swap = require("nvim-treesitter-textobjects.swap")
    vim.keymap.set("n", "<leader>sa", function()
      swap.swap_next("@parameter.inner")
    end, { desc = "swap next parameter" })
    vim.keymap.set("n", "<leader>sA", function()
      swap.swap_previous("@parameter.inner")
    end, { desc = "swap previous parameter" })
  end,
}
