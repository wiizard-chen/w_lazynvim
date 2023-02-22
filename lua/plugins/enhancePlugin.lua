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

  -- {
  --   "akinsho/toggleterm.nvim",
  --   name = "toggleterm",
  --   config = true,
  --   opts = function()
  --     require("toggleterm").setup({
  --       size = 20,
  --       open_mapping = [[<c-\>]],
  --       hide_numbers = true,
  --       shade_filetypes = {},
  --       shade_terminals = true,
  --       shading_factor = 2,
  --       start_in_insert = true,
  --       insert_mappings = true,
  --       persist_size = true,
  --       direction = "float",
  --       close_on_exit = true,
  --       shell = vim.o.shell,
  --       float_opts = {
  --         border = "curved",
  --         winblend = 0,
  --         highlights = {
  --           border = "Normal",
  --           background = "Normal",
  --         },
  --       },
  --       on_open = function()
  --         local opts = { buffer = 0 }
  --         vim.keymap.set("t", "<C-w>", [[<C-\><C-n>0]], opts)
  --         vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], opts)
  --       end,
  --     })
  --     -- local terminal = require("utils.terminal")
  --     -- local map = require("utils.init").map
  --     -- map("<leader>gg", terminal.lazygit_toggle)
  --     -- map(";lg", terminal.lazygit_toggle)
  --   end,

  --   -- keys = function()
  --   --   return {
  --   --     { "<leader>gg", terminal.lazygit_toggle, desc = "open lazygit" },
  --   --     { ";lg",        terminal.lazygit_toggle, desc = "open lazygit" },
  --   --   }
  --   -- end,
  -- },

}
