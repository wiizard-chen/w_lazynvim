return {
  {
    "MunifTanjim/prettier.nvim",
    enabled = false,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      print("masson ")
      table.insert(opts.ensure_installed, "prettierd")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      print("null-ls ")
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
    end,
  },
}
