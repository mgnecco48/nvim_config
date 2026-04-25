return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
      },
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        menu = {
          border = nil,
          draw = {
            columns = { { "kind_icon", "label", gap = 1 }, { "kind" }, { "source_name" } },
          },
        },
        documentation = { auto_show = false },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "snippets", "lsp", "dadbod", "path", "buffer" },
        -- per_filetype = {
        --   sql = { "snippets", "dadbod", "buffer" },
        --   mysql = { "snippets", "dadbod", "buffer" },
        --   psql = { "snippets", "dadbod", "buffer" },
        -- },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },

      fuzzy = { implementation = "lua" },
    },

    opts_extend = { "sources.default" },
  },
}
