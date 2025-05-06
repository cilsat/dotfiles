return {
  -- diffview
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
          winbar_info = true,
        },
      },
    },
    keys = {
      { "<leader>gdd", "<cmd>DiffviewOpen<cr>", desc = "Git diff against HEAD" },
      { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "Git history of current buffer" },
    },
  },
}
