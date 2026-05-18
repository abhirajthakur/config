return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ty = {
          settings = {
            ty = {
              -- Enable stricter type checking without being unbearable
              diagnosticMode = "workspace",
              typeCheckingMode = "standard",

              -- Better completions / imports
              autoImportCompletions = true,

              -- Inlay hints
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
                parameterTypes = true,
              },

              -- Ruff handles linting better
              disableOrganizeImports = false,

              -- Performance
              indexing = true,

              -- Python venv handling
              python = {
                venvPath = vim.fn.expand("~/.virtualenvs"),
              },
            },
          },
        },
      },
    },
  },
}
