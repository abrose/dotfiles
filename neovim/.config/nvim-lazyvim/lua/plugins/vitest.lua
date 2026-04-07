return {
  { "marilari88/neotest-vitest" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = { "neotest-vitest" },
      discovery = { enabled = false },
    },
  },
}
