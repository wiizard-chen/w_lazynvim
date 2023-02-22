local function start_telescope(telescope_mode, abspath, is_folder)
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  if telescope_mode == "grep_string" then
    print("live_grep", basedir)
    require("telescope.builtin").grep_string({
      cwd = basedir,
      use_regex = false,
      grep_open_files = false,
      search = vim.fn.input("Grep > "),
    })
    return
  end

  if telescope_mode == "find_files" then
    require("telescope.builtin")[telescope_mode]({
      cwd = basedir,
    })
  end
end

local function telescope_find_files(abspath, is_folder)
  start_telescope("find_files", abspath, is_folder)
end

local function telescope_grep_string(abspath, is_folder)
  start_telescope("grep_string", abspath, is_folder)
end

return {
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["g;f"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node.path
              local nodeType = node.type
              if nodeType == "directory" then
                telescope_find_files(path, true)
              end
            end,
            nowait = true,
          },
          ["g;r"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node.path
              local nodeType = node.type
              if nodeType == "directory" then
                telescope_grep_string(path, true)
              end
            end,
            nowait = true,
          },
        },
      },
    },
  },
}