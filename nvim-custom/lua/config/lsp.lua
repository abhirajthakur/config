-- Everything language-specific lives in lua/languages/*.lua
local langs = require("languages")

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- per-server settings
for name, cfg in pairs(langs.lsp_config) do
  vim.lsp.config(name, cfg)
end

require("mason").setup()
-- Auto-enables every server that Mason has installed (automatic_enable = true)
require("mason-lspconfig").setup()
-- Installs everything listed under `mason` in lua/languages/*.lua
require("mason-tool-installer").setup({ ensure_installed = langs.mason })

-- Servers NOT installed via Mason (e.g. TypeScript 7's `tsc`)
if #langs.enable > 0 then
  vim.lsp.enable(langs.enable)
end
