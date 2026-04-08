-- custom telescope
local lazy_utils = require("lazyvim.util")
local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    opts = function()
      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            n = {
              ["<ESC>"] = require("telescope.actions").close,
            },
            i = {
              ["<ESC>"] = require("telescope.actions").close,
              ["<C-u>"] = function()
                -- 删除全部输入
                local code = termcodes("<C-o>")
                vim.fn.feedkeys(code)
                vim.fn.feedkeys("d0")
                -- vim.fn.feedkeys("i")
              end,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      local map = require("utils.init").map

      map("n", ";r", function()
        local searchText = vim.fn.input("Grep > ")

        if searchText == nil or searchText == "" then
          return
        end

        local func = lazy_utils.pick("grep_string", {
          cwd = false,
          use_regex = false,
          -- grep_open_files = false,
          search = searchText,
        })
        func()
        -- mutli_rg()
      end, { desc = "searh all file" })

      -- 不知道干嘛的
      map("n", ";t", function()
        local multi_reg = require("utils.multi_rg").multi_reg
        multi_reg()
      end)

      map("n", ";f", function()
        local func =
          lazy_utils.pick("grep_string", { cwd = false, no_ignore = false, hidden = true, use_regex = false })
        func()
      end, { desc = "grep files" })

      map("n", ";e", function()
        local func = lazy_utils.pick("resume")
        func()
      end, { desc = "telescope resume" })

      -- 读取 git 文件的
      map("n", ";g", function()
        local grep_in_staged = require("utils.telescope_pickers").grep_in_staged
        grep_in_staged({
          use_regex = false,
          grep_open_files = false,
          ---@diagnostic disable-next-line: param-type-mismatch
          search = vim.fn.input("Grep > "),
        })
      end, { desc = "grep git staged file" })
    end,
  },
}
