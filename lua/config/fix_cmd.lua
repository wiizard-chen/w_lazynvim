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

-- local ignore_filetypes = { "neo-tree" }
-- local ignore_buftypes = { "nofile", "prompt", "popup" }
--
-- local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
--
-- vim.api.nvim_create_autocmd("WinEnter", {
--   group = augroup,
--   callback = function(_)
--     if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
--       vim.w.focus_disable = true
--     else
--       vim.w.focus_disable = false
--     end
--   end,
--   desc = "Disable focus autoresize for BufType",
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup,
--   callback = function(_)
--     if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
--       vim.b.focus_disable = true
--     else
--       vim.b.focus_disable = false
--     end
--   end,
--   desc = "Disable focus autoresize for FileType",
-- })
