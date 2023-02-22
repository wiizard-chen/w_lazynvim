-- M._keys = M._keys or {
--   { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
--   { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
--   { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
--   { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
--   { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
--   { "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
--   { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
--   { "K", vim.lsp.buf.hover, desc = "Hover" },
--   { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
--   { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
--   { "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
--   { "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
--   { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
--   { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
--   { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
--   { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
--   { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
--   { "<leader>cf", format, desc = "Format Document", has = "documentFormatting" },
--   { "<leader>cf", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },
--   { "<leader>cr", M.rename, expr = true, desc = "Rename", has = "rename" },
-- }

return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      -- add a keymap
      keys[#keys + 1] = { "<c-k>", false }
    end,
  },
}
