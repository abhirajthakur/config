require("tokyonight").setup({
	style = "night",
	-- buffer tabline colors, taken from the theme palette
	on_highlights = function(hl, c)
		hl.MiniTablineCurrent = { fg = c.blue, bg = c.bg_highlight, bold = true }
		hl.MiniTablineVisible = { fg = c.fg_dark, bg = c.bg_dark }
		hl.MiniTablineHidden = { fg = c.comment, bg = c.bg_dark }
		hl.MiniTablineModifiedCurrent = { fg = c.orange, bg = c.bg_highlight, bold = true }
		hl.MiniTablineModifiedVisible = { fg = c.orange, bg = c.bg_dark }
		hl.MiniTablineModifiedHidden = { fg = c.orange, bg = c.bg_dark }
		hl.MiniTablineFill = { bg = c.bg_dark }
		hl.MiniTablineTabpagesection = { fg = c.bg_dark, bg = c.blue }
	end,
})
vim.cmd.colorscheme("tokyonight")

-- Icons: mini.icons has per-folder/filename icons (src, node_modules, .git, ...).
-- Snacks and which-key pick it up automatically; the mock keeps any plugin that
-- still expects nvim-web-devicons working.
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- Open buffers as tabs at the top (modified files are marked with +)
require("mini.tabline").setup({
	format = function(buf_id, label)
		-- hide the empty [No Name] buffer you get when starting `nvim`
		if vim.api.nvim_buf_get_name(buf_id) == "" and not vim.bo[buf_id].modified then
			return ""
		end
		return MiniTabline.default_format(buf_id, label)
	end,
})

-- Start the buffer bar to the right of the file tree (the tree keeps the full height,
-- the bar row above it stays empty).
function _G.TablineOffset()
	local has_tree, min_col = false, math.huge
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(w).relative == "" then -- ignore floating windows
			if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "snacks_layout_box" then
				has_tree = true
			else
				min_col = math.min(min_col, vim.fn.win_screenpos(w)[2])
			end
		end
	end
	local offset = (has_tree and min_col ~= math.huge) and (min_col - 1) or 0
	return "%#MiniTablineFill#" .. string.rep(" ", offset) .. MiniTabline.make_tabline_string()
end
vim.o.tabline = "%!v:lua.TablineOffset()"

vim.api.nvim_create_autocmd({ "WinNew", "WinClosed", "WinResized", "BufWinEnter" }, {
	callback = function()
		vim.schedule(function()
			vim.cmd("redrawtabline")
		end)
	end,
})

-- File tree + fuzzy finder with preview
require("snacks").setup({
	picker = {
		enabled = true,
		sources = {
			-- show dotfiles (.gitignore ...); git-ignored files are hidden.
			-- In the tree: H toggles hidden files, I toggles ignored files (.env, node_modules)
			explorer = { hidden = true, ignored = false },
		},
	},
	explorer = { enabled = true },
	-- Toast notifications (replaces vim.notify, like nvim-notify): LSP/Mason messages, warnings, errors
	notifier = { enabled = true, timeout = 4000 },
})

require("which-key").setup({ preset = "helix" })
require("which-key").add({
	{ "<leader>f", group = "file/find" },
	{ "<leader>s", group = "search" },
	{ "<leader>c", group = "code" },
	{ "<leader>b", group = "buffer" },
	{ "<leader>w", group = "windows" },
	{ "<leader>q", group = "quit" },
	{ "<leader>u", group = "ui" },
})
