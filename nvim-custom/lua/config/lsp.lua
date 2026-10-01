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

require("mason-lspconfig").setup()

require("mason-tool-installer").setup({
	ensure_installed = langs.mason,
})

-- Servers NOT installed via Mason
if #langs.enable > 0 then
	vim.lsp.enable(langs.enable)
end

vim.keymap.set("n", "<leader>ih", function()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

-- Enable inlay hints whenever an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
	end,
})
