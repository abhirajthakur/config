-- lualine: one global statusline at the bottom
vim.o.showmode = false -- the mode is shown by lualine

local function lsp_names()
	local names = {}
	for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		names[#names + 1] = c.name
	end
	if #names == 0 then
		return ""
	end
	return "\u{f085} " .. table.concat(names, ",")
end

require("lualine").setup({
	options = {
		theme = "auto", -- follows tokyonight
		globalstatus = true,
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			"diagnostics",
			{ "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
		},
		lualine_x = { lsp_names, "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
