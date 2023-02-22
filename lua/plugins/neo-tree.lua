local function start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
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

local function telescope_find_files(_)
  start_telescope("find_files")
end

local function telescope_grep_string(_)
  start_telescope("grep_string")
end

return {
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
              print(node.name)
            end,
            nowait = true,
          },
          ["g;r"] = {
            function(state)
              local node = state.tree:get_node()
              -- print(node.name, node.path)
              local path = node.path
              -- print(node)
              print(path)
            end,
            nowait = true,
          },
        },
      },
    },
  },
}
