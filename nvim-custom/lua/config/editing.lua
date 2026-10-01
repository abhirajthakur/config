-- Auto-close brackets and quotes: type ( and get (), type " and get "".
require("mini.pairs").setup({
	modes = { insert = true, command = true, terminal = false },
})

-- Auto-close and auto-rename HTML/JSX tags: type <div> and get </div>.
require("nvim-ts-autotag").setup()

-- Surround (LazyVim keys):
--   gsa{char}  add     visual: select text, then  gsa"  gsa(  gsa{  gsa[  gsa'  gsa`  gsat (tag)
--   gsd{char}  delete  gsd"   removes the surrounding quotes
--   gsr{a}{b}  replace gsr"'  changes " to '
--   gsf / gsF  find next / previous surround      gsh  highlight
-- Normal mode: gsa{motion}{char}, e.g.  gsaiw"  wraps the word under the cursor.
require("mini.surround").setup({
	mappings = {
		add = "gsa",
		delete = "gsd",
		find = "gsf",
		find_left = "gsF",
		highlight = "gsh",
		replace = "gsr",
		update_n_lines = "gsn",
	},
})

require("which-key").add({ { "gs", group = "surround" } })
