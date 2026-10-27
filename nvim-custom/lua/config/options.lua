vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.undofile = true
vim.o.updatetime = 200
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 10   -- no wait after <Esc>
vim.o.synmaxcol = 240   -- skip highlighting very long lines
vim.o.confirm = true
vim.o.pumheight = 10
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.winborder = "rounded" -- border on hover, signature help, diagnostics floats, etc.

-- Snacks animations (notifications, scrolling, ...) off: actions are instant
vim.g.snacks_animate = false

-- Set the clipboard after startup; it is slow to initialize at launch
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)
