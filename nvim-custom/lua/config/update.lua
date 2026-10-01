-- One command to update everything: :Update  (or <leader>pu)
--   1. Mason registry + installed tools (LSPs, formatters)
--   2. Treesitter parsers
--   3. Plugins via vim.pack -> opens a review buffer:
--        :write  applies the updates,  :quit  cancels
local function update_all()
	pcall(vim.cmd, "MasonUpdate")
	pcall(vim.cmd, "MasonToolsUpdate")
	pcall(vim.cmd, "TSUpdate")
	vim.pack.update()
end

vim.api.nvim_create_user_command("Update", update_all, { desc = "Update plugins, Mason tools, parsers" })

-- Clean: remove plugins that are installed but no longer listed in plugins.lua
local function clean_plugins()
	local unused = vim.tbl_filter(function(p)
		return not p.active
	end, vim.pack.get())
	if #unused == 0 then
		vim.notify("No unused plugins")
		return
	end
	local names = vim.tbl_map(function(p)
		return p.spec.name
	end, unused)
	local msg = "Remove unused plugins?\n\n" .. table.concat(names, "\n")
	if vim.fn.confirm(msg, "&Yes\n&No", 2) == 1 then
		vim.pack.del(names)
	end
end

-- Clean tools: uninstall Mason packages that are not listed in lua/languages/*.lua
local function clean_tools()
	pcall(vim.cmd, "MasonToolsClean")
end

vim.api.nvim_create_user_command("Clean", clean_plugins, { desc = "Remove unused plugins" })
vim.api.nvim_create_user_command("CleanTools", clean_tools, { desc = "Remove unused Mason tools" })

local map = vim.keymap.set
map("n", "<leader>pu", update_all, { desc = "Update Everything" })
map("n", "<leader>pp", function()
	vim.pack.update()
end, { desc = "Update Plugins Only" })
map("n", "<leader>pc", clean_plugins, { desc = "Clean Unused Plugins" })
map("n", "<leader>pC", clean_tools, { desc = "Clean Unused Mason Tools" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Mason" })
map("n", "<leader>pt", "<cmd>TSManager<cr>", { desc = "Treesitter Parsers" })

require("which-key").add({ { "<leader>p", group = "packages/update" } })
