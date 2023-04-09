return {
  {
    "ThePrimeagen/harpoon",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("harpoon")
      local map = require("utils.init").map
      map("n", ";a", function()
        print("add marks")
        require("harpoon.mark").add_file()
      end, { desc = "add harpoon mark" })
      map("n", ";h", ":Telescope harpoon marks<cr>", { desc = "find harpoon marks" })
    end,
  },
}
