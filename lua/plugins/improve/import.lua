return {
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
  },

  {
    "karb94/neoscroll.nvim",
    enabled = false,
    config = function()
      require("neoscroll").setup({})
    end,
  },
}
