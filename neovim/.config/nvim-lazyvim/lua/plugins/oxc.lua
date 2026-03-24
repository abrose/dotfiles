return {
  -- Ensure nvim-lspconfig is up to date (v2.7.0+ has oxlint + oxfmt configs)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Enable oxlint and oxfmt LSP servers
      -- They only activate when root markers (.oxlintrc.json, .oxfmtrc.json) are found
      vim.lsp.enable("oxlint")
      vim.lsp.enable("oxfmt")
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("OxlintFixAll", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_clients({ name = "oxlint", bufnr = ev.buf })[1]
          if not client then
            return
          end
          client:request_sync("workspace/executeCommand", {
            command = "oxc.fixAll",
            arguments = { { uri = vim.uri_from_bufnr(ev.buf) } },
          }, 3000, ev.buf)
        end,
      })
    end,
  },

  -- Configure conform to use oxfmt's LSP for formatting in oxfmt-enabled projects
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- For JS/TS filetypes, use LSP formatting (oxfmt) as fallback
      -- This means: if oxfmt LSP is attached, it handles formatting;
      -- otherwise prettier (your existing config) still works
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local js_ts_types = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      }
      for _, ft in ipairs(js_ts_types) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        -- Setting lsp_format to "prefer" means conform will use the LSP formatter
        -- (oxfmt) when available, falling back to CLI formatters otherwise
      end
      opts.default_format_opts = opts.default_format_opts or {}
      opts.default_format_opts.lsp_format = "fallback"
    end,
  },
}
