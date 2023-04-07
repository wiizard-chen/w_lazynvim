return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "romgrk/barbar.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    event = "VeryLazy",
    opts = {
      animation = false,
      icon_custom_colors = false,
      -- -- Configure icons on the bufferline.
      icon_separator_active = "▎",
      icon_separator_inactive = "▎",
      icon_close_tab = "",
      icon_close_tab_modified = "●",
      icon_pinned = "車",
    },
    config = function()
      local hl = require("bufferline.utils").hl
      local fg_current = hl.fg_or_default({ "Normal" }, "#ff00ff", 255)
      local bg_current = hl.bg_or_default({ "Normal" }, "none")
      hl.set("BufferDefaultCurrent", bg_current, fg_current)
    end,
  },
}
