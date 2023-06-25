return {
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    -- enabled = false,
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "single",
        },
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = false,
          enable_in_insert = false,
          sign = false,
          sign_priority = 40,
          virtual_text = false,
        },
        finder = {
          --percentage
          max_height = 0.5,
          keys = {
            jump_to = "p",
            edit = { "o", "<CR>" },
            vsplit = "s",
            split = "i",
            tabe = "t",
            tabnew = "r",
            quit = { "q", "<ESC>" },
            close_in_preview = "<ESC>",
          },
        },
      })
    end,
    keys = {
      { "g.", "<Cmd>Lspsaga code_action<CR>",           desc = "code action" },
      { "gp", "<Cmd>Lspsaga lsp_finder<CR>",            desc = "all code info" },
      { "go", "<Cmd>Lspsaga outline<CR>",               desc = "open outline" },
      { "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>", desc = "show line diagnostics" },
      { "gh", "<cmd>Lspsaga hover_doc<CR>",             desc = "Hover" },
      {
        "<C-j>",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "jump next error",
      },
      {
        "<C-k>",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "jump prev error",
      },
      {
        "]d",
        function()
          require("lspsaga.diagnostic"):goto_prev()
        end,
        desc = "Next Diagnostic",
      },
      {
        "[d",
        function()
          require("lspsaga.diagnostic"):goto_next()
        end,
        desc = "Prev Diagnostic",
      },
      {
        "]e",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Next Error",
      },
      {
        "[e",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Prev Error",
      },
      {
        "]w",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Next Warning",
      },
      {
        "[w",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Prev Warning",
      },
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
