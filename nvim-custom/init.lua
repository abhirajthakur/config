vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.plugins") -- vim.pack.add(...)  <- add new plugins here
require("config.ui") -- theme, file tree/picker, which-key
require("config.statusline") -- lualine
require("config.noice") -- nicer cmdline/messages
require("config.explorer") -- oil.nvim file browser
require("config.treesitter")
require("config.completion")
require("config.lsp") -- Mason + servers, driven by lua/languages/*.lua
require("config.diagnostics")
require("config.format") -- conform, driven by lua/languages/*.lua
require("config.keymaps")
require("config.update") -- :Update and <leader>p keys
require("config.autocmds")
