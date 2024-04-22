return {
  -- diffview
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-web-devicons" },
    opts = { enhanced_diff_hl = true },
  },
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
}
