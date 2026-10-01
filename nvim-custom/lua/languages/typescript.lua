-- TypeScript 7 native server: `tsc --lsp --stdio` from the `typescript` npm package.
-- Install once:  npm i -g typescript   (or use a project-local TS 7)
local js = { "biome", "prettier", stop_after_first = true } -- biome only if biome.json exists

return {
  mason = { "prettier", "biome" },
  enable = { "tsc" },
  treesitter = { "javascript", "typescript", "tsx" },
  formatters = {
    javascript = js,
    javascriptreact = js,
    typescript = js,
    typescriptreact = js,
  },
}
