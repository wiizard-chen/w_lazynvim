return {
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
          { text = { "", builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          { text = { "%s" }, click = "v:lua.ScSa" },
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    enabled = true,
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-treesitter/nvim-treesitter" },
      { "kevinhwang91/promise-async" },
    },
    name = "ufo",
    keys = {
      {
        "zm",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "fold current file",
      },
      {
        "zr",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "unfold current file",
      },
    },
    config = function()
      require("ufo").setup({
        enable_get_fold_virt_text = true,
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = { "imports", "comment" },
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
