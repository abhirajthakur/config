-- HTML / CSS / data formats
return {
	mason = { "prettier", "html-lsp", "css-lsp" },
	lsp_config = {
		-- Tailwind's @tailwind / @apply are not unknown to us
		cssls = { settings = { css = { lint = { unknownAtRules = "ignore" } } } },
	},
	treesitter = { "html", "css", "json", "yaml", "toml", "markdown", "markdown_inline", "bash", "regex" },
	formatters = {
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
}
