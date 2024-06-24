return {
  -- {
  --   "windwp/nvim-ts-autotag",
  -- },
  -- {
  --   "jose-elias-alvarez/typescript.nvim",
  --   config = function()
  --     local map = require("utils.init").map
  --     local vimcmd = vim.cmd
  --     map("n", "gO", function()
  --       vimcmd("TypescriptRemoveUnused")
  --       vimcmd("sleep 100m")
  --       vimcmd("TypescriptOrganizeImports")
  --       vimcmd("sleep 100m")
  --       vimcmd("wa")
  --     end, { desc = "remove unused var and sort imports (typescript exclusive)" })
  --   end,
  -- },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-l>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
      })
    end,
  },
  {
    "nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "supermaven" })
    end,
  },
}
