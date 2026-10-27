-- Format manually with <leader>cf (no format on save).
-- Formatters per filetype come from lua/languages/*.lua (field: formatters)
require("conform").setup({
  formatters_by_ft = require("languages").formatters,
})
