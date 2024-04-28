return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "talha-akram/noctis.nvim" },
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
  -- {
  --   "navarasu/onedark.nvim",
  --   opts = {
  --     transparent = true,
  --     -- style = "Darker",
  --   },
  -- },
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      options = {
        transparency = true,
      },
    },
    priority = 1000, -- Ensure it loads first
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
      -- colorscheme = "rose-pine-dawn",
      -- colorscheme = "onedark",
      -- colorscheme = "catppuccin",
    },
  },
}
