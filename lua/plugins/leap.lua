return {
  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" }, enabled = true } },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      -- leap.add_default_mappings(true)
    end,
    keys = {
      { ";s", "<Plug>(leap-forward-to)" },
      { ";S", "<Plug>(leap-backward-to)" },
    },
  },
}
