return {
  mason = { "ty", "ruff" }, -- ty = type checker/LSP, ruff = lint + format
  treesitter = { "python" },
  formatters = {
    python = { "ruff_organize_imports", "ruff_format" },
  },
}
