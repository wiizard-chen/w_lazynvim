return {
  {
    "windwp/nvim-ts-autotag",
  },

  {
    "jose-elias-alvarez/typescript.nvim",
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      { "jose-elias-alvarez/typescript.nvim" },
      { "mason.nvim" },
    },
    event = "BufReadPre",
    -- dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      local tsnls = require("typescript.extensions.null-ls.code-actions")
      return {
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
          tsnls,
        },
      }
    end,
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {},
  },
}
