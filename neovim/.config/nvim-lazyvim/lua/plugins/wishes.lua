-- Local dev spec for wishes.nvim (points at working checkout).
-- NOTE: two distinct `dev` flags here — they don't mean the same thing:
--   * spec-level `dev = true`         → lazy.nvim: treat as local dev plugin
--   * `opts = { dev = true }`         → wishes.setup(): register :WishesReload
return {
  dir = "~/workspace/private/wishes.nvim",
  name = "wishes.nvim",
  dev = true,
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    dev = true,
    categories = {
      fix = { sign = "🔥", fg = "#ff5555", label = "fix" },
    },
  },
}
