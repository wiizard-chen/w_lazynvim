return {
  {
    "akinsho/toggleterm.nvim",
    name = "toggleterm",
    version = "*",
    opts = {
      -- open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "single",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      on_open = function()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n>0]], opts)
        vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], opts)
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      local term = require("utils.terminal")
      local map = require("utils.init").map
      map("n", ";lg", term.lazygit_toggle, { desc = "toggle lazygit" })
    end,
  },
}
