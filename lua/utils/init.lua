local pickers = require('utils.telescopePickers')

local opt = {
  noremap = true,
  silent = true,
}
local vimcmd = vim.cmd
local clock = os.clock
local M = {}

function M.sleep(n) -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

function M.map(m, k, v, optional)
  -- 可选参数
  local _opt = optional or opt
  vim.keymap.set(m, k, v, _opt)
end

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  local res = require("cmp_nvim_lsp").default_capabilities(capabilities)
  return res
end

function M.smart_quit()
  -- save all file
  vimcmd('wa!')
  -- M.sleep(1)
  vimcmd('qa!')
end

function M.get_reg(char)
  return vim.fn.getreg(char)
  -- return vim.api.nvim_exec([[echo getreg(']]..char..[[')]], true):gsub("[\n\r]", "^J")
end

M.grep_in_staged = pickers.grep_in_staged

return M
