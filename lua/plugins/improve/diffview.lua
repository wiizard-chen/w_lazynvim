return {
  {
    "sindrets/diffview.nvim",
    -- enbale = false,
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-web-devicons" } },
    opts = {
      keymaps = {
        file_panel = {
          {
            "n",
            "s",
            false,
            { desc = "Stage / unstage the selected entry" },
          },
        },
      },
    },
    keys = {
      { "<leader>gl", ":DiffviewFileHistory %<CR>", desc = "open current file history" },
      { "<leader>go", ":DiffviewOpen<CR>", desc = "open current file history" },
      -- { "<leader>gc", ":DiffviewClose<CR>", desc = "close diff view" },
    },
  },
}
