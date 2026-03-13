-- ====================
-- MARTIN GNECCO CONFIG
-- ====================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- plugins via 'lazy.nvim'
require("config.lazy")

-- background for different windows
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

--- Miscellaneous
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.o.splitright = true
vim.opt.wrap = false
vim.opt.linebreak = false

-- Syncs the system clipboard to Nvim's allowing to copy and paste to/from other
vim.o.clipboard = "unnamedplus"

-- Making searching with '/' non-case sensitive
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.winborder = "rounded"
vim.o.inccommand = "split"

-- KEYMAPS
require("config.special_keymaps") --- Separate file for keymaps complex keymaps that would make this config too messy

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Scaping easier binds to write and quit, work best when the CAPS key has been changed to send CTRL
vim.keymap.set({ "i", "n" }, "<C-s>", "<Cmd>w<CR>")
vim.keymap.set({ "i", "n" }, "<C-e>", "<Cmd>q<CR>")

-- Sourcing the whole current file or a specific line. Very useful when experimenting with new config things
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- Quick way to access Netrw, the native file manager
vim.keymap.set("n", "<leader>-", ":Ex<CR>")

---- Resizing Splits
vim.keymap.set("n", "<C-.>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<C-,>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<C-Up>", "<cmd>resize +3<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize -3<CR>")

---- Moving inbetween nvim windows, easier than the default
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

---- Escaping the terminal mode with an easy bind.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

---- Diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)
----

-- Highlight on yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlighting when yanking text",
  group = vim.api.nvim_create_augroup("highlighting-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Setting a specific highlighting color for a specific treesitter type.
-- Use ':Inspect' with the cursor on a word to see the highliting group,
-- or ':InspectTree' for an "interactive" overview.
vim.cmd([[hi @function.call.python guifg=yellow]])
