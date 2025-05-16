return {
  { "folke/flash.nvim", enabled = false },

  {
    "stevearc/conform.nvim",
    opts = function()
      local opts = {
        formatters_by_ft = {
          javascript = { "biome" },
          javascriptreact = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
      }
      return opts
    end,
  },
}
