local utils = require("utils.init")
local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
        -- find
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
        { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
        -- search
        { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
        { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
        { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        {
          "<leader>sH",
          "<cmd>Telescope highlights<cr>",
          desc = "Search Highlight Groups",
        },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        -- { "<leader>so",      "<cmd>Telescope vim_options<cr>",                         desc = "Options" },
        { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
        { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
        {
          "<leader>uC",
          Util.telescope("colorscheme", { enable_preview = true }),
          desc = "Colorscheme with preview",
        },
        {
          "<leader>ss",
          Util.telescope("lsp_document_symbols", {
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          }),
          desc = "Goto Symbol",
        },
        {
          ";f",
          function()
            builtin.git_files({ no_ignore = false, hidden = true })
          end,
          -- Util.telescope("files"),
          desc = "find files",
        },
        {
          ";r",
          function()
            builtin.grep_string({
              use_regex = false,
              grep_open_files = false,
              ---@diagnostic disable-next-line: param-type-mismatch
              search = vim.fn.input("Grep > "),
            })
          end,
          desc = "searh all file",
        },
        {
          ";e",
          function()
            builtin.resume()
          end,
          desc = "telescope resume",
        },
        {
          "<leader>ss",
          function()
            utils.grep_in_staged({
              use_regex = false,
              grep_open_files = false,
              ---@diagnostic disable-next-line: param-type-mismatch
              search = vim.fn.input("Grep > "),
            })
          end,
          desc = "grep git staged file",
        },
      }
    end,
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-i>"] = function()
              Util.telescope("find_files", { no_ignore = true })()
            end,
            ["<a-h>"] = function()
              Util.telescope("find_files", { hidden = true })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
          },
        },
      },
    },
  },
}
