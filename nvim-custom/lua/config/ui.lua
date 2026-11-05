require("tokyonight").setup({ style = "night" })
vim.cmd.colorscheme("tokyonight")

-- Icons: mini.icons has per-folder/filename icons (src, node_modules, .git, ...).
-- Snacks and which-key pick it up automatically; the mock keeps any plugin that
-- still expects nvim-web-devicons working.
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- Open buffers as tabs at the top. offsets makes the bar start to the right of the file tree.
require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    always_show_bufferline = true,
    -- hide the empty [No Name] buffer you get when starting `nvim`
    custom_filter = function(buf)
      return not (vim.api.nvim_buf_get_name(buf) == "" and not vim.bo[buf].modified)
    end,
    offsets = { { filetype = "snacks_layout_box" } },
  },
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
