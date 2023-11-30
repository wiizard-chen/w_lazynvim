return {
  {
    "sindrets/diffview.nvim",
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
      { "<leader>go", ":DiffviewOpen<CR>", desc = "open current project" },
      { "<leader>gd", ":tabclose<CR>", desc = "close current project" },
    },
  },
}
