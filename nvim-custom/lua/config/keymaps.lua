local map = vim.keymap.set

-- files / search (snacks picker)
map("n", "<leader><space>", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>e", function() require("oil").toggle_float() end, { desc = "File Explorer (oil)" })
map("n", "-", "<cmd>Oil<cr>", { desc = "Open Parent Directory" })

map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Git Files" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Config Files" })

map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Word / Selection" })
map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
map("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>snh", "<cmd>Noice history<cr>", { desc = "Noice Message History" })
map("n", "<leader>snl", "<cmd>Noice last<cr>", { desc = "Noice Last Message" })
map("n", "<leader>snd", "<cmd>Noice dismiss<cr>", { desc = "Noice Dismiss" })
map("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss Notifications" })
map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- lsp / code
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
-- K: LSP hover if available; :help in vim/lua files; otherwise a quiet message
-- (avoids the "no manual entry for ..." error from the default man lookup)
map("n", "K", function()
  if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/hover" }) > 0 then
    vim.lsp.buf.hover()
  elseif vim.bo.keywordprg:match("help") then
    vim.cmd("normal! K")
  else
    vim.notify("No hover available here", vim.log.levels.INFO)
  end
end, { desc = "Hover" })
map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- diagnostics navigation (LazyVim-style)
local E, W = vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev Diagnostic" })
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = E }) end, { desc = "Next Error" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = E }) end, { desc = "Prev Error" })
map("n", "]w", function() vim.diagnostic.jump({ count = 1, severity = W }) end, { desc = "Next Warning" })
map("n", "[w", function() vim.diagnostic.jump({ count = -1, severity = W }) end, { desc = "Prev Warning" })
map({ "n", "x" }, "<leader>cf", function() require("conform").format({ lsp_format = "fallback" }) end, { desc = "Format" })

-- windows / buffers
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bo", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if b ~= cur and vim.bo[b].buflisted and not vim.bo[b].modified then
      vim.api.nvim_buf_delete(b, {})
    end
  end
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>-", "<C-w>s", { desc = "Split Below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split Right" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete Window" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- editing
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
map("v", "<", "<gv")
map("v", ">", ">gv")
