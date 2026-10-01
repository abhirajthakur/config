-- gitsigns: changed lines in the gutter + hunk actions
require("gitsigns").setup({
	numhl = true, -- color the line number of changed lines
	linehl = true, -- highlight the whole changed line (added / changed lines)
	on_attach = function(buf)
		local gs = require("gitsigns")
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
		end
		map("]h", function()
			gs.nav_hunk("next")
		end, "Next Hunk")
		map("[h", function()
			gs.nav_hunk("prev")
		end, "Prev Hunk")
		map("<leader>ghp", gs.preview_hunk, "Preview Hunk")
		map("<leader>ghs", gs.stage_hunk, "Stage Hunk")
		map("<leader>ghr", gs.reset_hunk, "Reset Hunk")
		map("<leader>ghi", gs.preview_hunk_inline, "Preview Hunk Inline")
		map("<leader>ghd", gs.diffthis, "Diff This (vs index)")
		map("<leader>ghD", function()
			gs.diffthis("~")
		end, "Diff This (vs last commit)")
		map("<leader>ghl", gs.toggle_linehl, "Toggle Line Highlight")
		map("<leader>ghn", gs.toggle_numhl, "Toggle Number Highlight")
		map("<leader>ghw", gs.toggle_word_diff, "Toggle Word Diff")
		map("<leader>ght", gs.toggle_deleted, "Toggle Deleted Lines")
		map("<leader>ghb", function()
			gs.blame_line({ full = true })
		end, "Blame Line")
	end,
})

require("which-key").add({
	{ "<leader>g", group = "git" },
	{ "<leader>gh", group = "hunks" },
})
