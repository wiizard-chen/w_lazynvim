-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = require("utils.init").map

-- make insert mode like emacs
-- if you don't like emacs comment all key bind
-- solve the confict with karabiner
-- c-a go to head
-- c-e go to tail
map("i", "<C-A>", "<C-O>I", { desc = "jump to the start of line" })
map("i", "<C-E>", "<C-O>A", { desc = "jump to the end of line" })
map("n", "<C-A>", "^", { desc = "jump to the start of line" })
map("n", "<C-E>", "$", { desc = "jump to the end of line" })
map("i", "<C-d>", "<Del>", { desc = "delete forward character" })
map("i", "<C-h>", "<BS>", { desc = "delete backward character" })
map("i", "<C-k>", '<space><Esc>"_d$a', { desc = "delete the forward of line" })
map("v", "<C-A>", "^", { desc = "jump to the start of line" })
map("v", "<C-E>", "$", { desc = "jump to the end of line" })

-- something wrong happen
-- map("0", "^", { desc = "jump to the start of line" })

-- clear key
map("n", "<C-h>", "", { desc = "" })
map("n", "<C-j>", "", { desc = "" })
map("n", "<C-k>", "", { desc = "" })
map("n", "<C-l>", "", { desc = "" })
map("t", "<esc><esc>", "<nop>", { desc = "nothing" })

-- enahcne key
map("n", "<C-O>", "<C-O>zz", { desc = "back" })
map("n", "<C-I>", "<C-I>zz", { desc = "reback" })

-- better yank and paste
map("n", "x", '"_x')
map("n", "X", '"_X')
map("n", "c", '"_c')
-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP')

-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_")
map("v", "g_", "$")
map("n", "$", "g_")

-- scroll screen
-- visual模式下缩进代码
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<", "<<")
map("n", ">", ">>")

-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv")
map("v", "K", ":move '<-2<CR>gv-gv")
-- map("n", "J", "mzJ`z")
-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- from the primeagen
map("n", "Q", "<nop>")

map("n", "<leader>r", ":LspRestart<CR>zz")

require("config.custom_keymaps")
