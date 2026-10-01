-- oil.nvim: browse and edit the filesystem like a normal buffer.
--   <leader>e  floating file browser      -  open the parent folder of the current file
-- Inside oil: <CR> open, - go up, g? help.
-- Rename/delete/create by editing the text, then :w (or <C-s>) to apply.
require("oil").setup({
  default_file_explorer = true, -- replaces netrw
  columns = { "icon" },
  watch_for_changes = true,
  view_options = { show_hidden = true },
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
