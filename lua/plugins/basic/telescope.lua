local lazy_utils = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = function()
      return {
        { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", lazy_utils.telescope("live_grep", { use_regex = false }), desc = "Find in Files (Grep)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", lazy_utils.telescope("files"), desc = "Find Files (root dir)" },
        -- find
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>ff", lazy_utils.telescope("files"), desc = "Find Files (root dir)" },
        { "<leader>fF", lazy_utils.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
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
        { "<leader>sg", lazy_utils.telescope("live_grep"), desc = "Grep (root dir)" },
        { "<leader>sG", lazy_utils.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
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
        { "<leader>sw", lazy_utils.telescope("grep_string"), desc = "Word (root dir)" },
        { "<leader>sW", lazy_utils.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
        {
          "<leader>uC",
          lazy_utils.telescope("colorscheme", { enable_preview = true }),
          desc = "Colorscheme with preview",
        },
        {
          "<leader>ss",
          lazy_utils.telescope("lsp_document_symbols", {
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
      }
    end,
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<C-o>"] = require("telescope.actions.generate").which_key({
              name_width = 20, -- typically leads to smaller floats
              max_height = 0.5, -- increase potential maximum height
              separator = " > ", -- change sep between mode, keybind, and name
              close_with_action = false, -- do not close float on action
            }),
          },
        },
        -- mappings = {
        --   i = {
        --
        --     ["<c-t>"] = function(...)
        --       return require("trouble.providers.telescope").open_with_trouble(...)
        --     end,
        --     ["<a-i>"] = function()
        --       lazy_utils.telescope("find_files", { no_ignore = true })()
        --     end,
        --     ["<a-h>"] = function()
        --       lazy_utils.telescope("find_files", { hidden = true })()
        --     end,
        --     ["<C-Down>"] = function(...)
        --       return require("telescope.actions").cycle_history_next(...)
        --     end,
        --     ["<C-Up>"] = function(...)
        --       return require("telescope.actions").cycle_history_prev(...)
        --     end,
        --   },
        -- },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      local map = require("utils").map

      map("n", ";r", function()
        local func = lazy_utils.telescope("grep_string", {
          cwd = false,
          use_regex = false,
          grep_open_files = false,
          ---@diagnostic disable-next-line: param-type-mismatch
          search = vim.fn.input("Grep > "),
        })
        func()
      end, { desc = "searh all file" })

      map("n", ";f", function()
        -- builtin.git_files({ no_ignore = false, hidden = true })
        local func = lazy_utils.telescope("files", { cwd = false, no_ignore = false, hidden = true })
        func()
      end, { desc = "find files" })

      map("n", ";e", function()
        local func = lazy_utils.telescope("resume")
        func()
      end, { desc = "telescope resume" })

      map("n", "<leader>sq", function()
        local func = lazy_utils.telescope("quickfix", {
          use_regex = false,
          grep_open_files = false,
        })
        func()
      end, { desc = "search quickfix list" })

      map("n", "<leader>\\s", function()
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
