-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
--
--

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.g.copilot_node_command = "/usr/local/bin/node"

-- fold
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.wo.relativenumber = false

-- fillchars
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- vim.opt.formatoptions = "tcqj"
-- vim.o.relativenumber = false
