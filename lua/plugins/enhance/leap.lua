return {
  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" }, enabled = true } },
    config = function(_, opts)
      -- 全屏幕的跳转
      vim.keymap.set("n", ";s", function()
        local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
          return vim.api.nvim_win_get_config(win).focusable
        end, vim.api.nvim_tabpage_list_wins(0))
        require("leap").leap({ target_windows = focusable_windows_on_tabpage })
      end, { desc = "jump all windows" })
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
    end,
  },
}
