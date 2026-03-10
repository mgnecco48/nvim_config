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
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
-- vim.api.nvim_set_hl(0, "PmenuExtra", { bg = "none" })
-- vim.api.nvim_set_hl(0, "PmenuKind", { bg = "none" })
-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3c3836" })
-- vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { bg = "#ffbf00" })

vim.o.number = true
vim.o.relativenumber = true

vim.o.undofile = true

-- Syncs the system clipboard to Nvim's allowing to copy and paste to/from other
vim.o.clipboard = "unnamedplus"

vim.o.signcolumn = "yes"
vim.o.cursorline = true

-- making searching with '/' non-case sensitive
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.winborder = "rounded"
vim.o.inccommand = "split"

-- keymaps
require("config.special_keymaps")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "i", "n" }, "<C-s>", "<Cmd>w<CR>")
vim.keymap.set({ "i", "n" }, "<C-e>", "<Cmd>q<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

---- Moving inbetween nvim windows.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

---- Escaping the terminal with an easy bind
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

----
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.o.splitright = true

vim.opt.wrap = false
vim.opt.linebreak = false

-- Highlight on yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlighting when yanking text",
  group = vim.api.nvim_create_augroup("highlighting-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Starting treesitter highlighting for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python" },
  callback = function()
    vim.treesitter.start()
  end,
})

-- setting a specific color for an specific treesitter type.
vim.cmd([[hi @function.call.python guifg=yellow]])
