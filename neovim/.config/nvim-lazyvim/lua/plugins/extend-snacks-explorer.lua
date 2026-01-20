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
              layout = {
                width = 0.2, -- 20% of screen width
                min_width = 40,
                max_width = 60,
              },
            },
          },
        },
      },
    },
  },
}
