return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_use_border_highlight = true
      vim.g.molten_output_win_border = "rounded"
      vim.g.molten_output_win_max_height = 25
      vim.g.molten_auto_open_output = true
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_wrap_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },
}
