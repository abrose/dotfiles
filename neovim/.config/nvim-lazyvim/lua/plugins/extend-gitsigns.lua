return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = true,
  opts = {
    on_attach = function(buf)
      local gs = require("gitsigns")
      local map = vim.keymap.set
      map("n", "<leader>ghs", gs.stage_hunk, { buffer = buf, desc = "Stage Hunk" })
      map("n", "<leader>ghS", gs.stage_buffer, { buffer = buf, desc = "Stage Buffer" })
      map("n", "<leader>ghu", gs.stage_hunk, { buffer = buf, desc = "Undo Stage Hunk" })
      map("n", "<leader>ghp", gs.preview_hunk, { buffer = buf, desc = "Preview Hunk" })
      map("n", "<leader>ghr", gs.reset_hunk, { buffer = buf, desc = "Reset Hunk" })
    end,
  },
}
