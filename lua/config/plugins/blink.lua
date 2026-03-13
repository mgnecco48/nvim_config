return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    version = "1.*",

    opts = {
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<Enter>"] = { "select_and_accept", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        menu = {
          border = nil,
          draw = {
            components = {
              --   kind_icon = {
              --     text = function(ctx)
              --       local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              --       return kind_icon
              --     end,
              --     -- (optional) use highlights from mini.icons
              --     highlight = function(ctx)
              --       local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              --       return hl
              --     end,
              --   },
              --   kind = {
              --     -- (optional) use highlights from mini.icons
              --     highlight = function(ctx)
              --       local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              --       return hl
              --     end,
              --   },
            },
            columns = { { "kind_icon", "label", gap = 1 }, { "kind" }, { "source_name" } },
          },
        },
        documentation = { auto_show = false },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      signature = { enable = true },
      fuzzy = { implementation = "lua" },
    },

    opts_extend = { "sources.default" },
  },
}
