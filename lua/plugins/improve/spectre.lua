return {
  {
    "nvim-pack/nvim-spectre",
    keys = {
      --  TODO: spectre add current buffer file path
      -- { "<leader>sr", ":Spectre %<CR>", desc = "Replace in Current file" },
      {
        "<leader>sr",
        function()
          -- get current buffer path
          local path = vim.fn.expand("%:p")
          -- get cwd buffer path
          local cwd = vim.fn.expand("%:p:h")
          -- get file name
          local fileName, num = path:gsub(".*/", "")

          require("spectre").open({
            cwd = cwd,
            is_close = true, -- close an exists instance of spectre and open new
            is_insert_mode = false,
            path = fileName,
          })
        end,
        desc = "Replace in Current file",
      },
    },
  },
}
