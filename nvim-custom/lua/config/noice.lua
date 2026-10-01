-- noice.nvim: floating command line, search and message UI.
-- Notifications (vim.notify) stay with snacks; LSP hover/signature stay native.
require("noice").setup({
  cmdline = { enabled = true },
  messages = { enabled = true },
  popupmenu = { enabled = true },
  notify = { enabled = false }, -- keep snacks as the vim.notify handler
  lsp = {
    progress = { enabled = true }, -- "ty: indexing..." style status
    hover = { enabled = false },
    signature = { enabled = false },
    message = { enabled = true },
  },
  presets = {
    bottom_search = true,        -- / and ? search at the bottom, like classic vim
    command_palette = true,      -- : command line + completions in one popup
    long_message_to_split = true, -- long output goes to a split instead of a toast
    lsp_doc_border = true,
  },
  routes = {
    -- "written", "3 fewer lines", undo counts etc: small mini message instead of a toast
    {
      filter = {
        event = "msg_show",
        any = { { find = "%d+L, %d+B" }, { find = "; after #%d+" }, { find = "; before #%d+" } },
      },
      view = "mini",
    },
  },
})

require("which-key").add({ { "<leader>sn", group = "noice" } })
