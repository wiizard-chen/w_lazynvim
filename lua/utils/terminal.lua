local M = {}
local vimcmd = vim.cmd

function _lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    -- size = 20,
    float_opts = {
      border = "none",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    on_open = function(_)
      vimcmd("startinsert!")
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n>0]], opts)
      vim.keymap.set("t", ";lg", [[<C-\><C-n>0gg<cmd>lua _lazygit_toggle()<CR>]], opts)
      -- 先复制路径，退出 lazygit，最后打开文件
      vim.keymap.set("t", "<F5>", [[<C-o><C-\><C-n>0gg<cmd>lua _lazygit_toggle()<CR>:edit <C-r>*<CR>]], opts)
    end,
    on_close = function(_) end,
    count = 99,
  })
  lazygit:toggle()
end

M.lazygit_toggle = _lazygit_toggle

return M
