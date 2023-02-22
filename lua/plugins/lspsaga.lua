return {
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({
        ui = {
          title = false,
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
      })
    end,
    keys = {
      { "g.", "<Cmd>Lspsaga code_action<CR>", desc = "code action" },
      { "gp", "<Cmd>Lspsaga lsp_finder<CR>", desc = "all code info" },
      { "go", "<Cmd>Lspsaga outline<CR>", desc = "open outline" },
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
