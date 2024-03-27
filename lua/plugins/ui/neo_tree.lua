local lazy_utils = require("lazyvim.util")
local custom_utils = require("utils.init")

local function context_dir(state)
  -- return the directory of the current neo-tree node
  local node = state.tree:get_node()
  if node.type == "directory" then
    return node.path
  end
  return node.path:gsub("/[^/]*$", "") -- go up one level
end

local function splitString(inputStr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputStr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

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
  local root_path = lazy_utils.root.get() .. "/"
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

local function copy_name(state)
  local node = state.tree:get_node()
  local path = node:get_id()
  local result = splitString(path, "/")
  local name = result[#result]
  vim.fn.setreg("+", name)
  vim.fn.setreg('"', name)
  vim.fn.setreg("*", name)
end

return {
  {
    "rcarriga/nvim-notify",
    -- enabled = false,
    opts = {
      background_colour = "#ffffff",
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
    branch = "v3.x",
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
        copy_name = copy_name,
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
          follow_current_file = { enabled = true },
          commands = global_commands,
        },
        buffers = { commands = global_commands },
        git_status = { commands = global_commands },
        -- diagnostics = { commands = global_commands },
        source_selector = {
          winbar = false,
          -- content_layout = "center",
          -- statusline = true,
        },
        window = {
          position = "float",
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
            ["z"] = "",
            ["Y"] = "copy_name",

            -- paste from the system clipboard
            ["g;p"] = {
              function(state)
                local dest_dir = context_dir(state)
                local files = vim.split(vim.fn.getreg("+"), "\n")
                for _, file in ipairs(files) do
                  local filename = file:gsub("^.*/", "")
                  local dest = dest_dir .. "/" .. filename
                  -- run `git add` afterwards if the file will not be overwriten and `.git` dir found in CWD
                  local git_add = vim.fn.filereadable(file) == 1
                    and vim.fn.filereadable(dest) == 0
                    and vim.fn.isdirectory(".git") == 1

                  if vim.fn.isdirectory(file) == 1 or vim.fn.filereadable(file) == 1 then
                    vim.fn.jobstart({ "cp", "-r", file, dest_dir }, {
                      detach = true,
                      on_exit = function()
                        vim.notify("Paste " .. vim.fn.shellescape(filename), vim.log.levels.INFO, {
                          title = "neo-tree",
                          timeout = 500,
                        })
                        -- if file is not in the ignored path and not overwriten, then `git add`
                        if git_add then
                          vim.fn.jobstart({ "git", "add", dest }, {
                            on_exit = function()
                              state.commands["refresh"](state)
                            end,
                          })
                        else
                          state.commands["refresh"](state)
                        end
                      end,
                      on_stderr = function(_, data)
                        if data[1] ~= "" then
                          vim.notify(data[1], vim.log.levels.ERROR)
                        end
                      end,
                    })
                  end
                end
              end,
              desc = "paste from clipboard",
              nowait = true,
            },
            -- open in Spectre to replace here
            ["<c-r>"] = {
              function(state)
                local node = state.tree:get_node()
                if node.type == "directory" then
                  require("spectre").open({
                    cwd = node.path,
                    is_close = true, -- close an exists instance of spectre and open new
                    is_insert_mode = false,
                    path = "",
                  })
                else
                  require("spectre").open({
                    cwd = context_dir(state),
                    is_close = true, -- close an exists instance of spectre and open new
                    is_insert_mode = false,
                    path = node.path:match("^.+/(.+)$"),
                  })
                end
                -- close neo-tree
                vim.cmd("Neotree close")
              end,
              desc = "replace here",
              nowait = true,
            },
          },
        },
      }
    end,
  },
}
