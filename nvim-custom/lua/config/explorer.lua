-- oil.nvim: browse and edit the filesystem like a normal buffer.
--   <leader>e  floating file browser      -  open the parent folder of the current file
-- Inside oil: <CR> open, - go up, g. show/hide hidden + git-ignored files, g? help.
-- Rename/delete/create by editing the text, then :w (or <C-s>) to apply.

-- Git-ignored files/folders (node_modules, dist, .next ...) are hidden, cached per folder.
-- Ignored dotfiles (.env, .env.local ...) stay visible so you can edit them.
local ignored_cache = {}
local function git_ignored(dir)
	if ignored_cache[dir] then
		return ignored_cache[dir]
	end
	local set = {}
	local res = vim.system(
		{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
		{ cwd = dir, text = true }
	):wait()
	if res.code == 0 then
		for line in vim.gsplit(res.stdout, "\n", { plain = true, trimempty = true }) do
			local is_dir = line:sub(-1) == "/"
			set[(line:gsub("/$", ""))] = is_dir and "dir" or "file"
		end
	end
	ignored_cache[dir] = set
	return set
end

vim.api.nvim_create_autocmd("User", {
	pattern = "OilMutationComplete",
	callback = function()
		ignored_cache = {}
	end,
})

require("oil").setup({
	default_file_explorer = true, -- replaces netrw
	columns = { "icon" },
	watch_for_changes = true,
	win_options = { signcolumn = "yes:2" }, -- room for the git status marks
	view_options = {
		show_hidden = false, -- press g. in oil to reveal hidden and ignored files
		is_hidden_file = function(name, bufnr)
			if name == ".git" then
				return true
			end
			local dir = require("oil").get_current_dir(bufnr)
			if dir == nil then
				return false
			end
			local kind = git_ignored(dir)[name]
			if kind == nil then
				return false
			end
			-- ignored dotfiles (.env) stay visible; ignored folders and other files are hidden
			return not (kind == "file" and name:sub(1, 1) == ".")
		end,
	},
	float = { padding = 2 },
	keymaps = {
		-- free these so window navigation and save keep working inside oil
		["<C-h>"] = false,
		["<C-l>"] = false,
		["<C-s>"] = false,
		["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
		["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
		["<C-r>"] = "actions.refresh",
		["q"] = "actions.close",
	},
})

-- Git status marks next to files in oil (modified, added, untracked ...)
require("oil-git-status").setup({ show_ignored = false })
