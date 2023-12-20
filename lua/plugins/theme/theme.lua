return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rebelot/kanagawa.nvim", name = "kanagawa", priority = 1000 },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon", transparent = true, sidebars = { "qf", "vista_kind", "terminal", "packer" } },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = { transparent_mode = true },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
