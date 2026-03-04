return {
  "akinsho/git-conflict.nvim",
  lazy = false,
  opts = {
    default_mappings = false, -- disable built-in mappings
  },
  keys = {
    { "<leader>ho", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours" },
    { "<leader>ht", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
    { "<leader>h0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None" },
    { "<leader>hB", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both" },
    { "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
    { "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Prev Conflict" },
    { "<leader>gx", "<cmd>GitConflictListQf<cr>", desc = "List Conflicts" },
    { "<leader>gr", "<cmd>GitConflictRefresh<cr>", desc = "Refresh Conflicts" },
  },
}
