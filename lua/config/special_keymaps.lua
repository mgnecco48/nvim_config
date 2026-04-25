--------------------------
---Advanced keymap file---
--------------------------

---- Running a script in a terminal vertical split
vim.keymap.set("n", "<leader>rv", function()
  local file = vim.fn.expand("%:p") -- full path of current filea
  local file_short = vim.fn.expand("%")
  local buftype = vim.api.nvim_get_current_buf()
  vim.cmd("w") -- save file

  if vim.bo[buftype].filetype == "python" then
    vim.cmd("vsplit | terminal python3 " .. vim.fn.shellescape(file))
    vim.cmd("startinsert") -- enter terminal mode
  end

  if vim.bo[buftype].filetype == "go" then
    vim.cmd("vsplit | terminal go run .")
    vim.cmd.startinsert()
  end

  if vim.bo[buftype].filetype == "java" then
    vim.cmd("vsplit | terminal javac " .. vim.fn.shellescape(file) .. " && java " .. vim.fn.shellescape(file_short))
    vim.cmd.startinsert()
  end
end, { desc = "Run current file in terminal split" })

---- Running a script in a terminal bottom split
vim.keymap.set("n", "<leader>rb", function()
  local file = vim.fn.expand("%:p") -- full path of current filea
  local file_short = vim.fn.expand("%")
  local buftype = vim.api.nvim_get_current_buf()
  vim.cmd("w") -- save file

  if vim.bo[buftype].filetype == "python" then
    vim.cmd("split | terminal python3 " .. vim.fn.shellescape(file))
    vim.cmd("startinsert") -- enter terminal mode
  end

  if vim.bo[buftype].filetype == "go" then
    vim.cmd("split | terminal go run .")
    vim.cmd.startinsert()
  end

  if vim.bo[buftype].filetype == "java" then
    vim.cmd("split | terminal javac " .. vim.fn.shellescape(file) .. " && java " .. vim.fn.shellescape(file_short))
    vim.cmd.startinsert()
  end
end, { desc = "Run current file in terminal split" })

--- Running buffer in floating window, currently just works for python, go and java
vim.keymap.set("n", "<leader>rf", function()
  local file = vim.fn.expand("%:p")
  local fileName = vim.fn.expand("%")
  local buffer = vim.api.nvim_create_buf(false, true)
  local buftype = vim.api.nvim_get_current_buf()

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
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
  if vim.bo[buftype].filetype == "python" then
    vim.cmd("terminal python3 " .. vim.fn.shellescape(file))
    vim.cmd.startinsert()
  end
  if vim.bo[buftype].filetype == "go" then
    vim.cmd("terminal go run .")
    vim.cmd.startinsert()
  end
  if vim.bo[buftype].filetype == "java" then
    vim.cmd("terminal javac " .. vim.fn.shellescape(file) .. " && java " .. vim.fn.shellescape(fileName))
    vim.cmd.startinsert()
  end
end, { desc = "Run current file in floating terminal" })

---- Open a toggleable terminal, with persiting state

--- Function for toggle terminal
local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_terminal(opts)
  opts = opts or {}
  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local config = {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    border = "rounded",
    title = "TERMINAL",
    title_pos = "center",
  }

  local win = vim.api.nvim_open_win(buf, true, config)

  return { buf = buf, win = win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_terminal({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
      vim.cmd.startinsert()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command("FloaTerminal", toggle_terminal, {})

---- creating the keymap from the previously created function for toggle-ing a terminal window
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal)

-- Opening NETRW in a small floating window

vim.keymap.set("n", "<leader>net", function()
  local previous_window = vim.api.nvim_get_current_win()
  local previous_browse_split = vim.g.netrw_browse_split
  local previous_change_window = vim.g.netrw_chgwin
  local buffer = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.4)
  local height = math.floor(vim.o.lines * 0.4)
  local row = 5
  local col = 5

  local floating_window = vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    border = "rounded",
    title = "Files",
    title_pos = "center",
  })
  vim.g.netrw_banner = 0       -- Disable the netrw banner
  vim.g.netrw_browse_split = 4 -- Open files in the previous window instead of the floating netrw window
  vim.g.netrw_chgwin = vim.fn.win_id2win(previous_window)
  vim.g.netrw_liststyle = 3
  vim.cmd("Explore")
  buffer = vim.api.nvim_get_current_buf()
  vim.t.netrw_lexbufnr = buffer

  local function close_floating_netrw()
    if vim.api.nvim_win_is_valid(floating_window) then
      vim.api.nvim_win_close(floating_window, true)
    end

    vim.g.netrw_browse_split = previous_browse_split
    vim.g.netrw_chgwin = previous_change_window

    if vim.t.netrw_lexbufnr == buffer then
      vim.t.netrw_lexbufnr = nil
    end
  end

  vim.keymap.set("n", "q", close_floating_netrw, { buffer = buffer, nowait = true, desc = "close floating netrw" })

  vim.api.nvim_create_autocmd("WinLeave", {
    buffer = buffer,
    once = true,
    callback = function()
      if vim.api.nvim_win_is_valid(previous_window) then
        vim.schedule(function()
          close_floating_netrw()
        end)
      end
    end,
  })
end, { desc = "open netrw in a floating window" })

-- Easier Lazy commands
vim.keymap.set("n", "<leader>lz", ":Lazy<CR>", { desc = "Open Lazy" })
vim.keymap.set("n", "<leader>lu", ":Lazy update<CR>", { desc = "Update plugins with Lazy" })
