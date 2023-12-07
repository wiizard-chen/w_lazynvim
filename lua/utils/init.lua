local opt = {
  noremap = true,
  silent = true,
}
local vimcmd = vim.cmd
local clock = os.clock
local M = {}

function M.sleep(n) -- seconds
  local t0 = clock()
  while clock() - t0 <= n do
  end
end

function M.map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    opts.noremap = true
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  local res = require("cmp_nvim_lsp").default_capabilities(capabilities)
  return res
end

function M.smart_quit()
  -- save all file
  vimcmd("wa!")
  -- M.sleep(1)
  vimcmd("qa!")
end

function M.get_reg(char)
  return vim.fn.getreg(char)
  -- return vim.api.nvim_exec([[echo getreg(']]..char..[[')]], true):gsub("[\n\r]", "^J")
end

local function regexEscape(str)
  return str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
end

-- https://gist.github.com/VADemon/afb10dbb0d10d99aeb21449752da6285
function M.replace(str, this, that)
  return str:gsub(regexEscape(this), that) -- only % needs to be escaped for 'that'
end

function M.termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.vimcmd(str)
  return vim.api.nvim_command(str)
end

return M
