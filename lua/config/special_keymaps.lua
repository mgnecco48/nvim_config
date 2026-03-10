--------------------------
---Advanced keymap file---
--------------------------

---- Running a script in a terminal vertical split
vim.keymap.set("n", "<leader>r", function()
  local file = vim.fn.expand("%:p") -- full path of current file
  vim.cmd("w")                      -- save file
  vim.cmd("vsplit")                 -- open vertical split
  vim.cmd("terminal python3 " .. vim.fn.shellescape(file))
  vim.cmd("startinsert")            -- enter terminal mode
end, { desc = "Run current file in terminal split" })

---- Running buffer in floating window, currently just works for python
vim.keymap.set("n", "<leader>p", function()
  local file = vim.fn.expand("%:p")
  local fileName = vim.fn.expand("%")
  local buffer = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.cmd.write()
  vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    border = "rounded",
    title = fileName,
    title_pos = "center",
  })
  vim.cmd("terminal python3 " .. vim.fn.shellescape(file))
  vim.cmd.startinsert()
end, { desc = "Run current python file in floating terminal" })
