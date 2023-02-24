return {
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "single",
        },
        symbol_in_winbar = {
          enable = false,
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
        -- diagnostic = {
        --   on_insert = false,
        --   on_insert_follow = false,
        --   insert_winblend = 0,
        --   show_code_action = true,
        --   show_source = true,
        --   jump_num_shortcut = true,
        --   --1 is max
        --   max_width = 0.7,
        --   custom_fix = nil,
        --   custom_msg = nil,
        --   text_hl_follow = false,
        --   border_follow = false,
        --   keys = {
        --     exec_action = "o",
        --     quit = "q",
        --     go_action = "g",
        --   },
        -- },
      })
    end,
    keys = {
      { "g.", "<Cmd>Lspsaga code_action<CR>", desc = "code action" },
      { "gp", "<Cmd>Lspsaga lsp_finder<CR>", desc = "all code info" },
      { "go", "<Cmd>Lspsaga outline<CR>", desc = "open outline" },
      { "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>", desc = "show line diagnostics" },
      { "gh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover" },
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
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
