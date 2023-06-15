local lazy_utils = require("lazyvim.util")
local custom_utils = require("utils.init")

local function start_telescope(telescope_mode, abspath, is_folder)
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  if telescope_mode == "grep_string" then
    local searchText = vim.fn.input("Grep > ")

    if searchText == nil or searchText == "" then
      return
    end

    local func = lazy_utils.telescope("grep_string", {
      cwd = basedir,
      use_regex = false,
      -- grep_open_files = false,
      search = searchText,
    })
    func()

    -- require("telescope.builtin").grep_string({
    --   cwd = basedir,
    --   use_regex = false,
    --   grep_open_files = false,
    --   search = vim.fn.input("Grep > "),
    -- })
    -- return
  end

  if telescope_mode == "find_files" then
    local func = lazy_utils.telescope("files", {
      cwd = basedir,
      no_ignore = false,
      hidden = true,
    })
    func()
    -- require("telescope.builtin")[telescope_mode]({
    --   cwd = basedir,
    -- })
  end
end

local function telescope_find_files(abspath, is_folder)
  start_telescope("find_files", abspath, is_folder)
end

local function telescope_grep_string(abspath, is_folder)
  start_telescope("grep_string", abspath, is_folder)
end

local function get_relative_path(state)
  local node = state.tree:get_node()
  local replace = custom_utils.replace
  local file_path = node._id
  local root_path = lazy_utils.get_root() .. "/"
  -- local relativePath = filePath:gsub(rootPath, "")
  local relative_path = replace(file_path, root_path, "")
  print(root_path)
  print("**************")
  print(file_path)
  print("**************")
  print(relative_path)
  vim.fn.setreg("+", relative_path)
  vim.fn.setreg('"', relative_path)
  vim.fn.setreg("*", relative_path)
end

local function get_absolute_path(state)
  local node = state.tree:get_node()
  local absoulte_path = node._id
  vim.fn.setreg("+", absoulte_path)
  vim.fn.setreg('"', absoulte_path)
  vim.fn.setreg("*", absoulte_path)
end

return {
  {
    "rcarriga/nvim-notify",
    enabled = false,
    opts = {
      background_colour = "#ffffff",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup()
    end,
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { { "s1n7ax/nvim-window-picker" } },
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          -- require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        -- desc = "Explorer NeoTree (root dir)",
        desc = "Explorer NeoTree (cwd)",
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

    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,

    opts = function()
      local global_commands = {
        get_absolute_path = get_absolute_path,
        get_relative_path = get_relative_path,
        search_file_with_path = function(state)
          local node = state.tree:get_node()
          local path = node.path
          local nodeType = node.type
          if nodeType == "directory" then
            telescope_find_files(path, true)
          end
        end,
        grep_string_with_path = function(state)
          local node = state.tree:get_node()
          local path = node.path
          local nodeType = node.type
          if nodeType == "directory" then
            telescope_grep_string(path, true)
          end
        end,
      }

      return {
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = true,
          commands = global_commands,
        },
        buffers = { commands = global_commands },
        git_status = { commands = global_commands },
        -- diagnostics = { commands = global_commands },
        source_selector = {
          winbar = true,
          content_layout = "center",
          -- statusline = true,
        },
        window = {
          mappings = {
            ["<space>"] = false,
            ["gY"] = "get_absolute_path",
            ["gy"] = "get_relative_path",
            ["g;f"] = "search_file_with_path",
            ["g;r"] = "grep_string_with_path",
            ["o"] = "open",
            ["l"] = "open",
            ["s"] = "",
            ["v"] = "open_vsplit",
            ["h"] = "close_node",
            ["H"] = "toggle_hidden",
            -- ["C"] = "close_all_node",
            ["z"] = "",
          },
        },
      }
    end,
  },
}
