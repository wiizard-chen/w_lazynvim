local Terminal = require("toggleterm.terminal").Terminal

local M = {}

-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

local vimcmd = vim.cmd

function _lazygit_toggle()
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
    },
    on_open = function(_)
      vimcmd("startinsert!")
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n>0]], opts)
      vim.keymap.set("t", ";lg", [[<C-\><C-n>0gg<cmd>lua _lazygit_toggle()<CR>]], opts)
      -- 先复制路径，退出 lazygit，最后打开文件
      vim.keymap.set("t", "<F5>", [[<C-o><C-\><C-n>0gg<cmd>lua _lazygit_toggle()<CR>:edit <C-r>*<CR>]], opts)
    end,
    on_close = function(_)
    end,
    count = 99,
  })
  lazygit:toggle()
end

M.lazygit_toggle = _lazygit_toggle

return M
