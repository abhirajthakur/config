return {
  {
    "folke/noice.nvim",
    opts_extend = { "routes" },
    opts = {
      routes = {
        {
          filter = {
            event = "lsp",
            kind = "progress",
            any = {
              { find = "pyright" },
            },
          },
          opts = { skip = true },
        },
      },
    },
  },
}
