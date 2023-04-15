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
      -- Enables/disable clickable tabs
      --  - left-click: go to buffer
      --  - middle-click: delete buffer
      clickable = true,

      -- Excludes buffers from the tabline
      -- exclude_ft = { "javascript" },

      exclude_name = { "package.json" },

      sidebar_filetypes = {
        -- ["neo-tree"] = { event = "BufWipeout", text = "neo-tree" },
      },

      icons = {
        -- Configure the base icons on the bufferline.
        buffer_index = false,
        buffer_number = false,
        button = "",
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = false, icons = " " },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
        filetype = {
          -- Sets the icon's highlight group.
          -- If false, will use nvim-web-devicons colors
          custom_colors = false,

          -- Requires `nvim-web-devicons` if `true`
          enabled = true,
        },

        -- Configure the icons on the bufferline when modified or pinned.
        -- Supports all the base icon options.
        modified = { button = "●" },
        pinned = { button = "車", filename = true, separator = { right = "" } },
      },
    },
    config = function(_, opts)
      require("barbar").setup(opts)
      local hl = require("bufferline.utils").hl
      local fg_current = hl.fg_or_default({ "Normal" }, "#ff00ff", 255)
      local bg_current = hl.bg_or_default({ "Normal" }, "none")
      hl.set("BufferDefaultCurrent", bg_current, fg_current)
    end,
  },
}
