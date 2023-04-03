return {
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true, -- fall back to standard LSP definition on failure
        },
      })
      local map = require("utils.init").map
      local vimcmd = vim.cmd
      map("n", "gO", function()
        vimcmd("TypescriptRemoveUnused")
        vimcmd("sleep 100m")
        vimcmd("TypescriptOrganizeImports")
        vimcmd("sleep 100m")
        vimcmd("wa")
      end, { desc = "remove unused var and sort imports (typescript exclusive)" })
    end,
  },
}
