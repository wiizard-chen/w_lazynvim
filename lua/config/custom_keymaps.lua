local map = require("utils.init").map
local termcodes = require("utils.init").termcodes
local vimcmd = require("utils.init").vimcmd

map("n", ";;", ";", { desc = "fix ;" })
-- map("n", ",r", ":nohl<CR> :edit<CR>", { desc = "refresh" })

-- 方便常用的快捷键
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
map("n", "<leader>n", "<cmd>tabnew<cr>", { desc = "new tab" })

map("n", "<esc>", function()
  vimcmd("noh")
  -- 获取当前 buffer 的信息
  local buftype = vim.api.nvim_buf_get_option(0, "buftype")
  local readonly = vim.api.nvim_buf_get_option(0, "readonly")
  -- 判断是否可以保存
  if buftype == "" and not readonly then
    vimcmd("w")
  end
end, { desc = "Escape and clear hlsearch and auto save" })

local function delayed_function()
  vim.fn.feedkeys("gi")
  vim.fn.feedkeys(termcodes("<C-R>"))
  vim.fn.feedkeys("*")
end

-- 最完美的粘贴
map("i", "<C-Y>", function()
  local code = termcodes("<ESC>")
  vim.fn.feedkeys(code)
  vim.defer_fn(delayed_function, 1)
end, { desc = "paste from clipboard" })

-- 增强命令行的模式
map("c", "<C-Y>", function()
  vim.fn.feedkeys(termcodes("<C-R>"))
  vim.fn.feedkeys("*")
end, { desc = "paste from clipboard in cmd" })

map("c", "<C-A>", function()
  vim.fn.feedkeys(termcodes("<HOME>"))
end, { desc = "paste from clipboard in cmd" })

map("c", "<C-E>", function()
  vim.fn.feedkeys(termcodes("<END>"))
end, { desc = "paste from clipboard in cmd" })

map("c", "<C-D>", function()
  vim.fn.feedkeys(termcodes("<DEL>"))
end, { desc = "paste from clipboard in cmd" })

map("c", "<C-K>", function()
  vim.fn.feedkeys(termcodes("<DEL>"))
end, { desc = "paste from clipboard in cmd" })

-- buffer 跳转，绑定 cmd + number 通过 ala
map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>")
map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>")
map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>")
map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>")
map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>")
map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>")
map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>")
map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>")
map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>")
