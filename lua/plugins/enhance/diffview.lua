return {
  {
    "sindrets/diffview.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    keys = {
      { "<leader>gl", ":DiffviewFileHistory %<CR>", desc = "open current file history" },
      { "<leader>go", ":DiffviewOpen<CR>", desc = "open current file history" },
    },
  },
}
