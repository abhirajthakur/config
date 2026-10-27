-- Loads every lua/languages/*.lua file and merges them.
-- Files starting with "_" are ignored (handy for disabling one).
--
-- Each language file returns a table; every field is optional:
--   mason      = { "pkg", ... }        Mason packages (servers, formatters, linters)
--   enable     = { "server", ... }     servers to vim.lsp.enable() that Mason does not provide
--   lsp_config = { server = {...} }    vim.lsp.config() overrides
--   formatters = { ft = {...} }        conform formatters per filetype
--   treesitter = { "parser", ... }     treesitter parsers
local M = { mason = {}, enable = {}, lsp_config = {}, formatters = {}, treesitter = {} }

local function append(dst, src)
  for _, v in ipairs(src or {}) do
    if not vim.list_contains(dst, v) then table.insert(dst, v) end
  end
end

local dir = vim.fn.stdpath("config") .. "/lua/languages"
for name, kind in vim.fs.dir(dir) do
  if kind == "file" and name:match("%.lua$") and name ~= "init.lua" and name:sub(1, 1) ~= "_" then
    local spec = require("languages." .. name:gsub("%.lua$", ""))
    append(M.mason, spec.mason)
    append(M.enable, spec.enable)
    append(M.treesitter, spec.treesitter)
    M.lsp_config = vim.tbl_deep_extend("force", M.lsp_config, spec.lsp_config or {})
    M.formatters = vim.tbl_extend("force", M.formatters, spec.formatters or {})
  end
end

return M
