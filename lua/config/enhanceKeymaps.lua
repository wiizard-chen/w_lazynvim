local map = require("utils.init").map

local vimcmd = vim.cmd

-- 方便常用的快捷键
map("n", ",r", ":nohl<CR> :edit<CR>", { desc = "refresh" })
map("n", "gw", "*zz")
map("x", "gw", "*zz")

-- 非常重要的 keymap, 关于屏幕分屏的
map("n", "s", "")
map("n", "ss", ":split<Return>", { desc = "Horizontal split screen" })
map("n", "sv", ":vsplit<Return>", { desc = "Vertical split screen" })
map("n", "sh", "<C-w>h", { desc = "Go to left window" })
map("n", "sj", "<C-w>j", { desc = "Go to lower window" })
map("n", "sk", "<C-w>k", { desc = "Go to upper window" })
map("n", "sl", "<C-w>l", { desc = "Go to right window" })
map("n", "s=", "<C-w>=", { desc = "Resize each window" })
map("n", "sc", "<C-w>c", { desc = "Close window" })
map("n", "so", "<C-w>o", { desc = "Close other window" })
map("n", "sn", "<cmd>BufferNext<CR>", { desc = "next window" })
map("n", "sp", "<cmd>BufferPrevious<CR>", { desc = "pre window" })
map("n", "sw", "<c-w><c-w>", { desc = "switch float window" })

map("n", "<leader>so", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", { desc = "close other buffers but pinned" })
map("n", "<leader>sO", "<cmd>BufferCloseAllButCurrent<CR>", { desc = "close other buffers but current" })
map("n", "<leader>sp", "<cmd>BufferPin<CR>", { desc = "pin tab" })

-- tab 的操作增强
map("n", "<leader><tab>n", function()
  local cursor = vim.fn.line(".")
  vimcmd("tabnew %")
  vimcmd(tostring(cursor))
end, { desc = "new tab with current buffer" })
map("n", "<leader><tab>o", ":tabonly<CR>", { desc = "close other tab" })

-- 个人爱好快捷键
map("n", "<leader>fs", ":wa!<CR>", { desc = "save all buffer" })
map("n", "<leader>fl", ":put =execute('messages')<CR>", { desc = "show messages" })
map("n", "<leader>gf", ":Prettier<CR>", { desc = "Prettier file" })

-- map("n", "gO", function()
--   vimcmd("TypescriptRemoveUnused")
--   vimcmd("sleep 100m")
--   vimcmd("TypescriptOrganizeImports")
--   vimcmd("sleep 100m")
--   vimcmd("wa")
-- end, { desc = "remove unused var and sort imports (typescript exclusive)" })
