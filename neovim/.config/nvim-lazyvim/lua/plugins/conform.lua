return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        markdown = { "prettier" },
        yaml = { "yamlfmt" },
        css = { "prettier" },
      },
      formatters = {
        yamlfmt = {
          prepend_args = { "-formatter", "type=basic,force_quote_style=single" },
        },
      },
    },
  },
}
