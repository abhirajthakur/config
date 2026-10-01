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
    if vim.api.nvim_buf_get_name(buf_id) == "" and not vim.bo[buf_id].modified then return "" end
    return MiniTabline.default_format(buf_id, label)
  end,
})

-- Fuzzy finder with preview (file browsing is oil.nvim, see explorer.lua)
require("snacks").setup({
  picker = { enabled = true },
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
