return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open (unstaged changes)" },
    { "<leader>gD", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diffview: Last commit" },
    { "<leader>gb", "<cmd>DiffviewOpen main...HEAD<cr>", desc = "Diffview: Full branch diff" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File history" },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        winbar_info = true, -- shows file path in winbar
      },
    },
    file_panel = {
      listing_style = "tree", -- tree view like you saw, groups by directory
      win_config = {
        width = 46,
      },
    },
  },
}
