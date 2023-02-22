return {
  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      local leap = require("leap")
      -- for k, v in pairs(opts) do
      --   print("k is", k)
      --   print("v is", v)
      --   leap.opts[k] = v
      -- end
      leap.add_default_mappings(false)
    end,
    opts = {
      safe_labels = {
        "s", "f", "n",
        "j", "k", "l", "h", "o", "d", "w", "e", "m", "b",
        "u", "y", "v", "r", "g", "t", "c", "x", "/", "z",
        "S", "F", "N",
        "J", "K", "L", "H", "O", "D", "W", "E", "M", "B",
        "U", "Y", "V", "R", "G", "T", "C", "X", "?", "Z"
      },
    },
    keys = {
      { ",s", "<Plug>(leap-forward-to)" },
      { ",S", "<Plug>(leap-backward-to)" },
    }
  },
}
