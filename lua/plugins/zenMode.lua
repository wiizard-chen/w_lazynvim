return {
  "folke/zen-mode.nvim",
  name = "zen-mode",
  keys = function()
    -- local zenMode = require("zen-mode")
    return {
      { "<leader>zz", function() require("zen-mode").toggle() end, desc = "zen mode" },
    }
  end,
}
