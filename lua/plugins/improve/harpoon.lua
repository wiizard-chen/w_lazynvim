return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("harpoon")
      local map = require("utils").map
      map("n", ";a", function()
        print("add marks")
        require("harpoon.mark").add_file()
      end, { desc = "add harpoon mark" })
      map("n", ";h", ":Telescope harpoon marks<cr>", { desc = "find harpoon marks" })
    end,
    -- keys = {
    --   {
    --     ";a",
    --     function()
    --       print("add marks")
    --       require("harpoon.mark").add_file()
    --     end,
    --     desc = "add harpoon mark",
    --   },
    --   {
    --     ";h",
    --     ":Telescope harpoon marks<cr>",
    --     desc = "find harpoon marks",
    --   },
    --   {
    --     "<leader>ha",
    --     function()
    --       print("add marks")
    --       require("harpoon.mark").add_file()
    --     end,
    --     desc = "add harpoon mark",
    --   },
    --   {
    --     "<leader>hs",
    --     ":Telescope harpoon marks<cr>",
    --     desc = "find harpoon marks",
    --   },
    -- },
  },
}
