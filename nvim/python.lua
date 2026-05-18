return {
  -- Python extras (Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
        "toml",
        "json",
        "yaml",
      })
    end,
  },

  -- Mason tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruff",
        "ty",
      })
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ty = {},

        ruff = {
          cmd_env = {
            RUFF_TRACE = "messages",
          },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
      },

      setup = {
        -- Disable hover for Ruff
        ruff = function(_, opts)
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("ruff_hover_disable", { clear = true }),
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "ruff" then
                client.server_capabilities.hoverProvider = false
              end
            end,
          })
        end,

        -- Disable formatting for ty
        ty = function(_, opts)
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("ty_format_disable", { clear = true }),
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "ty" then
                client.server_capabilities.documentFormattingProvider = false
              end
            end,
          })
        end,
      },
    },
  },

  -- Formatting (Ruff formatter)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },

  -- FIX: reliable organize imports keymap
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.keymap.set("n", "<leader>co", function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.organizeImports" },
          },
        })
      end, { desc = "Organize Imports" })
    end,
  },
}
