return {
  "folke/zen-mode.nvim",
  name = "zen-mode",
  keys = function()
    return {
      {
        "<leader>zz",
        function()
          require("zen-mode").toggle()
        end,
        desc = "zen mode",
      },
    }
  end,
}
