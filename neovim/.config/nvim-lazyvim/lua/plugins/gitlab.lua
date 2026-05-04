return {
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    build = function()
      require("gitlab.server").build(true)
    end,
    config = function()
      local gitlab = require("gitlab")
      gitlab.setup()

      local map = function(keys, fn_name, desc)
        vim.keymap.set("n", keys, function()
          require("gitlab")[fn_name]()
        end, { desc = "GitLab: " .. desc })
      end

      -- Merge request workflow
      map("<leader>glm", "choose_merge_request", "Choose MR")
      map("<leader>glr", "review", "Review MR")
      map("<leader>gls", "summary", "MR Summary")
      map("<leader>gla", "approve", "Approve MR")
      map("<leader>glR", "revoke", "Revoke Approval")

      -- Comments & discussions
      map("<leader>glc", "create_comment", "Create Comment")
      map("<leader>gld", "list_discussions", "List Discussions")
      map("<leader>glt", "toggle_resolved", "Toggle Resolved")

      -- Reviewers & assignees
      map("<leader>gl+", "add_reviewer", "Add Reviewer")
      map("<leader>gl-", "delete_reviewer", "Remove Reviewer")
    end,
  },
}
