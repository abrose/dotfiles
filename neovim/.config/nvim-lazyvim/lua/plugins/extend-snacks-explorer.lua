return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- Show hidden/dotfiles by default
            -- ignored = true,  -- Optionally also show gitignored files
            layout = {
              preset = "sidebar",
              preview = "main",
            },
          },
        },
      },
    },
  },
}
