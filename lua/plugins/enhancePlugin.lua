return {
  {
    "MunifTanjim/prettier.nvim",
  },
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    enabled = false,
    config = function()
      require("grapple").setup({})
      -- local map = require("utils.init")
      -- map("n", "<leader>mm", require("grapple").toggle, { desc = "toogle grapple" })
    end,
    keys = {
      {
        "<leader>m",
        function()
          require("grapple").toggle()
        end,
        "grapple toggle",
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("harpoon")
    end,
    keys = {
      {
        ";a",
        function()
          print("add marks")
          require("harpoon.mark").add_file()
        end,
        "add harpoon mark",
      },
      {
        ";h",
        ":Telescope harpoon marks<cr>",
        "find harpoon marks",
      },
      {
        "<leader>ha",
        function()
          print("add marks")
          require("harpoon.mark").add_file()
        end,
        "add harpoon mark",
      },
      {
        "<leader>hs",
        ":Telescope harpoon marks<cr>",
        "find harpoon marks",
      },
    },
  },

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

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      { "jose-elias-alvarez/typescript.nvim" },
      { "mason.nvim" },
    },
    event = "BufReadPre",
    opts = function()
      local nls = require("null-ls")
      local tsnls = require("typescript.extensions.null-ls.code-actions")
      return {
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
          nls.builtins.diagnostics.misspell,
          -- tsnls,
        },
      }
    end,
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    keys = {
      { "<leader>gl", ":DiffviewFileHistory %<CR>", desc = "open current file history" },
      { "<leader>go", ":DiffviewOpen<CR>", desc = "open current file history" },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    name = "toggleterm",
    version = "*",
    opts = {
      -- open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "single",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      on_open = function()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n>0]], opts)
        vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], opts)
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      local term = require("utils.terminal")
      local map = require("utils.init").map
      map("n", ";lg", term.lazygit_toggle, { desc = "toggle lazygit" })
    end,
  },
}
