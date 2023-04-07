return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-treesitter/nvim-treesitter" },
      { "kevinhwang91/promise-async" },
    },
    name = "ufo",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "close all folds",
      },
    },
    config = function()
      require("ufo").setup({
        open_fold_hl_timeout = 150,
        -- close_fold_kinds = { "imports", "comment" },
        preview = {
          win_config = {
            border = { "", "─", "", "", "", "─", "", "" },
            winhighlight = "Normal:Folded",
            winblend = 0,
          },
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            jumpTop = "[",
            jumpBot = "]",
          },
        },
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}
