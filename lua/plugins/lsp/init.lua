return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    -- enabled = false,
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      local keysMap = require("lazyvim.plugins.lsp.keymaps")
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false, mode = "i", desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = { "]d", false, keysMap.diagnostic_goto(true), desc = "Next Diagnostic" }
      keys[#keys + 1] = { "[d", false, keysMap.diagnostic_goto(false), desc = "Prev Diagnostic" }
      keys[#keys + 1] = { "]e", false, keysMap.diagnostic_goto(true, "ERROR"), desc = "Next Error" }
      keys[#keys + 1] = { "[e", false, keysMap.diagnostic_goto(false, "ERROR"), desc = "Prev Error" }
      keys[#keys + 1] = { "]w", false, keysMap.diagnostic_goto(true, "WARN"), desc = "Next Warning" }
      keys[#keys + 1] = { "[w", false, keysMap.diagnostic_goto(false, "WARN"), desc = "Prev Warning" }
    end,
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
}
