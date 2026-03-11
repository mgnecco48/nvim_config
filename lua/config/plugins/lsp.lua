return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
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
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      { -- optional blink completion source for require statements and module annotations
        "saghen/blink.cmp",
        opts = {
          sources = {
            -- add lazydev to your completion providers
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
              lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
              },
            },
          },
        },
      },

      { "j-hui/fidget.nvim", opts = {} },
    },

    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
        "pyright",
        "dockerls",
        "sqlls",
        "jsonls",
        "yamlls",
        "bashls",
        "marksman",
        "taplo",
        "hyprls",
        "vim",
      }

      --- adding blink capabilities to other servers.
      for _, server in ipairs(servers) do
        vim.lsp.config[server] = {
          capabilities = capabilities,
        }
      end

      --- Special Lua Config recommended by Neovim
      vim.lsp.config["lua_ls"] = {
        cmd = { "lua-language-server" },

        filetypes = { "lua" },

        capabilities = capabilities,

        root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },

        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.api.nvim_get_runtime_file("", true),
              },
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },

            completion = {
              callSnippet = "Replace",
            },
          },
        },
      }

      -- -- enabling lsp servers
      -- Usually would run somethin like 'vim.lsp.enable("lua_ls")', but since we have the mason-lspconfig plugin, that is taken care of for us.

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
