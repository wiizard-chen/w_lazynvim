return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rebelot/kanagawa.nvim", name = "kanagawa" },
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
    "2nthony/vitesse.nvim",
    name = "vitesse",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
