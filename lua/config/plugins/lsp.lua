return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = { "lua" },
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },

      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "⏳",
              package_uninstalled = "✗",
            },
          },
        },
      },

      { "j-hui/fidget.nvim", opts = {} },
    },

    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config["lua_ls"] = {
        cmd = { "lua-language-server" },

        filetypes = { "lua" },

        root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },

        capabilities = capabilities,

        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
          },
        },
      }

      vim.lsp.config["pyright"] = {
        capabilities = capabilities,
      }

      -- enabling lsp servers
      vim.lsp.enable("lua_ls")

      -- keymap for formating the file without saving
      vim.keymap.set("n", "<leader>g", function()
        vim.lsp.buf.format()
      end)
      -- configuring "Autocommands"
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          if
              not client:supports_method("textDocument/willSaveWaitUntil")
              and client:supports_method("textDocument/formatting")
          then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = args.buf,
                  id = client.id,
                })
              end,
            })
          end
        end,
      })
    end,
  },
}
