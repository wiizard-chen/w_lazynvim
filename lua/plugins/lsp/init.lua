return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    -- enabled = false,
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false, mode = "i", desc = "Signature Help", has = "signatureHelp" }
    end,
  },
}
