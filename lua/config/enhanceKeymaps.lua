local map = require("utils.init").map
local vimcmd = vim.cmd;
local utils = require("utils")


-- 非常重要的 keymap, 关于屏幕分屏的
map("n", "s", "")
map("n", "ss", ":split<Return>", { desc = "横向分屏" })
map("n", "sv", ":vsplit<Return>", { desc = "横向分屏" })
map("n", "sh", "<C-w>h", { desc = "切换上平" })
map("n", "sj", "<C-w>j", { desc = "横向分屏" })
map("n", "sk", "<C-w>k", { desc = "横向分屏" })
map("n", "sl", "<C-w>l", { desc = "横向分屏" })
map("n", "s=", "<C-w>=", { desc = "横向分屏" })

map("n", "sc", "<C-w>c", { desc = "横向分屏" })
map("n", "so", "<C-w>o", { desc = "横向分屏" })
map("n", "sn", "<C-w>=", { desc = "横向分屏" })
map("n", "sp", "<C-w>=", { desc = "横向分屏" })


-- 非常重要的 tab 动作
map("n", "tc", ":tabclose<CR>", { desc = "close tab" })
