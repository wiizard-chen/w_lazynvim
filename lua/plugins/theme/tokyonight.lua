return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon", transparent = true, sidebars = { "qf", "vista_kind", "terminal", "packer" } },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
