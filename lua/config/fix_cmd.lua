-- hotfix: nvim 0.9 treesitter work error
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

-- clear formatoptions
vim.cmd([[
augroup MyAutoCommands
  autocmd!
  autocmd BufEnter * set formatoptions-=cro
augroup END
]])

-- c-k map redo
vim.cmd([[
augroup KeyMapAutoCommands
  autocmd!
  autocmd BufEnter * lua local map = require("utils.init").map; map("i", "<C-k>", '<space><Esc>"_d$a', { desc = "delete the forward of line" })
augroup END
]])
