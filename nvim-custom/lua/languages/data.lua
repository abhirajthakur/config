-- JSON / YAML with schemas (package.json, tsconfig.json, GitHub workflows, docker-compose ...)
return {
	mason = { "json-lsp", "yaml-language-server" },
	lsp_config = {
		jsonls = {
			settings = {
				json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
			},
		},
		yamlls = {
			settings = {
				yaml = {
					schemaStore = { enable = false, url = "" }, -- use SchemaStore.nvim instead
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		},
	},
}
