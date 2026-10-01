return {
  mason = { "lua-language-server", "stylua" },
  treesitter = { "lua", "vim", "vimdoc", "query" },
  lsp_config = {
    lua_ls = {
      settings = { Lua = { runtime = { version = "LuaJIT" }, diagnostics = { globals = { "vim" } } } },
    },
  },
  formatters = { lua = { "stylua" } },
}
