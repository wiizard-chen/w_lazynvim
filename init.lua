-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 判断当前系统类型
local has = vim.fn.has
local is_mac = has("macunix")
local is_win = has("win32")
if is_mac then
  require("utils.macos")
end
if is_win then
  require("utils.windows")
end

-- hotfix: nvim 0.9 treesitter work error
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
