return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      typescript = { "oxfmt" },
      typescriptreact = { "oxfmt" },
      javascript = { "oxfmt" },
      javascriptreact = { "oxfmt" },
      json = { "prettier" },
      markdown = { "prettier" },
      yaml = { "prettier" },
      css = { "prettier" },
    },
  },
}
