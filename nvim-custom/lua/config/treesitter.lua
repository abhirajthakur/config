-- Parsers come from lua/languages/*.lua (field: treesitter)
require("tree-sitter-manager").setup({
  ensure_installed = require("languages").treesitter,
})
