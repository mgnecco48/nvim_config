-- vim.opt_local.textwidth = 160           -- Wrap Markdown text at 160 columns when formatting.
vim.opt_local.colorcolumn = "160"       -- Show a visual guide at the 160-column limit.
-- vim.opt_local.wrap = true               -- Display long Markdown lines on multiple screen lines.
vim.opt_local.linebreak = true          -- Break wrapped screen lines at word boundaries.
vim.opt_local.breakindent = true        -- Align visually wrapped lines with their original indentation.
vim.opt_local.formatoptions:remove("l") -- Reformat existing long lines instead of leaving them unchanged.
vim.opt_local.formatoptions:append("t") -- Auto-wrap plain text while typing.
vim.opt_local.formatoptions:append("q") -- Allow gq to format comments and list markers.
vim.opt_local.formatoptions:append("n") -- Preserve numbered-list indentation when formatting.
vim.opt_local.formatoptions:append("r") -- Continue list markers after pressing Enter in insert mode.
vim.opt_local.formatoptions:append("o") -- Continue list markers after opening a new line with o or O.
vim.opt_local.formatoptions:append("c") -- Format comments
vim.opt_local.comments = {
  "b:-",
  "b:*",
  "b:+",
  "n:>",
}
vim.opt_local.spell = true    -- Enable spell checking for Markdown buffers.
vim.opt_local.scrolloff = 999 -- Keep the cursor vertically centered while scrolling.
vim.opt_local.formatlistpat = [[^\s*\d\+[\]:.)}\t ]\s*]]
------------------------
---NOTEBOOK SPECIFIC ---
------------------------

require("quarto").activate()

vim.keymap.set("n", "<S-CR>", function()
  require("quarto.runner").run_cell()
  require("nvim-treesitter-textobjects.move").goto_next_start("@code_cell.inner", "textobjects")
end, { buffer = true, desc = "Run cell and move to next" })

local notebook_extensions = {
  ipynb = true,
  qmd = true,
}

if notebook_extensions[vim.fn.expand("%:e")] then
  local buf = vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("notebook_cell_separators")

  local function refresh_cell_separators()
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end

    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    local separator = string.rep("━", vim.bo[buf].textwidth)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    local in_code_cell = false
    for i, line in ipairs(lines) do
      if line:match("^```%s*[%w_{]") then
        in_code_cell = true
        vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
          virt_lines = {
            { { separator, "Comment" } },
          },
          virt_lines_above = true,
        })
      elseif in_code_cell and line:match("^```%s*$") then
        in_code_cell = false
        local separator_line = math.min(i, #lines - 1)
        vim.api.nvim_buf_set_extmark(buf, ns, separator_line, 0, {
          virt_lines = {
            { { separator, "Comment" } },
          },
          virt_lines_above = true,
        })
      end
    end
  end

  refresh_cell_separators()

  local group = vim.api.nvim_create_augroup("markdown_notebook_cell_separators", { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = buf })
  vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI", "WinResized" }, {
    group = group,
    buffer = buf,
    callback = refresh_cell_separators,
  })
end
