local map = require("utils.init").map
local termcodes = require("utils.init").termcodes
local vimcmd = require("utils.init").vimcmd

local function open_current_buffer_in_new_tab()
  local current_buf = vim.api.nvim_get_current_buf()
  vim.cmd("tabnew")
  vim.api.nvim_set_current_buf(current_buf)
end

local function has_new_tab()
  return #vim.api.nvim_list_tabpages() > 1
end

local function paste_function()
  vim.fn.feedkeys(termcodes("<C-R>"))
  vim.fn.feedkeys("*")
end

map("n", ";;", ";", { desc = "fix ;" })
map("n", "gw", "*zz")
map("x", "gw", "*zz")

-- extra important key about spliting screen
map("n", "s", "")
map("n", "ss", ":split<Return>", { desc = "Horizontal split screen" })
map("n", "sv", ":vsplit<Return>", { desc = "Vertical split screen" })
map("n", "sh", "<C-w>h", { desc = "Go to left window" })
map("n", "sj", "<C-w>j", { desc = "Go to lower window" })
map("n", "sk", "<C-w>k", { desc = "Go to upper window" })
map("n", "sl", "<C-w>l", { desc = "Go to right window" })
map("n", "s=", "<C-w>=", { desc = "Resize each window" })
map("n", "sc", function()
  -- 获取当前标签页的所有窗口
  local tabpage = vim.api.nvim_get_current_tabpage()
  local tabs = vim.fn.gettabinfo(tabpage)
  if #tabs < 1 then
    return
  end
  local windows = tabs[1].windows
  local delete_cmd = "BufferClose"
  -- 判断窗口数量
  if #windows == 1 then
    vimcmd(delete_cmd)
  else
    local success = pcall(vim.cmd, "close", true)
    if not success then
      vimcmd(delete_cmd)
    end
  end
end, { desc = "Close window" })
map("n", "so", "<C-w>o", { desc = "Close other window" })
map("n", "sw", "<c-w><c-w>", { desc = "switch float window" })

-- tabs extra keymap
map("n", "sn", function()
  if has_new_tab() then
    vim.cmd("tabnext")
  else
    open_current_buffer_in_new_tab()
  end
end, { desc = "next window" })
map("n", "sp", function()
  if has_new_tab() then
    vim.cmd("tabprevious")
  else
    open_current_buffer_in_new_tab()
  end
end, { desc = "pre window" })
map("n", "sd", "<cmd>tabclose<cr>", { desc = "close window" })
map("n", "<leader>n", "<cmd>tabnew<cr>", { desc = "new tab" })
map("n", "<leader>sn", function()
  local cursor = vim.fn.line(".")
  vimcmd("tabnew %")
  vimcmd(tostring(cursor))
end, { desc = "new tab with current buffer" })
map("n", "<leader>sO", ":tabonly<CR>", { desc = "close other tab" })

-- custom  keymap
map("n", "<leader>fs", ":wa!<CR>", { desc = "save all buffer" })
map("n", "<leader>fl", ":put =execute('messages')<CR>", { desc = "show messages" })
map("n", "<esc>", function()
  vimcmd("noh")
  -- 获取当前 buffer 的信息
  local buftype = vim.api.nvim_get_option_value("buftype", {})
  local readonly = vim.api.nvim_get_option_value("readonly", {})

  -- 判断是否可以保存
  if buftype == "" and not readonly then
    if vim.bo.modified then
      -- pcall(vim.api.nvim_exec2, "w", true)
      vim.cmd("w")
    end
  end
end, { desc = "Escape and clear hlsearch and auto save" })

-- 最完美的粘贴
map("i", "<C-Y>", function()
  -- local code = termcodes("<ESC>")
  -- vim.fn.feedkeys(code)
  vim.defer_fn(paste_function, 1)
end, { desc = "paste from clipboard" })

-- 增强命令行的模式
map("c", "<C-Y>", function()
  paste_function()
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

-- map("c", "<C-K>", function()
--   vim.fn.feedkeys(termcodes("<DEL>"))
-- end, { desc = "paste from clipboard in cmd" })

-- buffer 跳转，绑定 cmd + number 通过 ala
map("n", "<leader>so", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", { desc = "close other buffers but pinned" })
map("n", "<leader>sp", "<cmd>BufferPin<CR>", { desc = "pin tab" })
map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>")
map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>")
map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>")
map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>")
map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>")
map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>")
map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>")
map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>")
map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>")

-- map("n", "<leader>so", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", { desc = "close other buffers but pinned" })
-- map("n", "<leader>sp", "<cmd>BufferLineTogglePin<CR>", { desc = "pin tab" })
-- map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
-- map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
-- map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
-- map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
-- map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
-- map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
-- map("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
-- map("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
-- map("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")
