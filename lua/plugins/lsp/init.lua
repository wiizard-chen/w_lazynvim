return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    -- enabled = false,
    opts = {
      inlay_hints = { enabled = false },
    },
    init = function()
      local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          go({ severity = severity })
        end
      end

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- local keysMap = require("lazyvim.plugins.lsp.keymaps")
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false, mode = "i", desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = { "]d", false, diagnostic_goto(true), desc = "Next Diagnostic" }
      keys[#keys + 1] = { "[d", false, diagnostic_goto(false), desc = "Prev Diagnostic" }
      keys[#keys + 1] = { "]e", false, diagnostic_goto(true, "ERROR"), desc = "Next Error" }
      keys[#keys + 1] = { "[e", false, diagnostic_goto(false, "ERROR"), desc = "Prev Error" }
      keys[#keys + 1] = { "]w", false, diagnostic_goto(true, "WARN"), desc = "Next Warning" }
      keys[#keys + 1] = { "[w", false, diagnostic_goto(false, "WARN"), desc = "Prev Warning" }
    end,
  },
}
