return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = vim.fn.exepath("js-debug-adapter"),
          args = { "${port}" },
        },
      }

      local attach_local_stack = {
        type = "pwa-node",
        request = "attach",
        name = "Attach to local-stack",
        address = "localhost",
        port = function()
          local input = vim.fn.input("Inspector port: ", "9229")
          return tonumber(input) or 9229
        end,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
      }

      for _, ft in ipairs({ "typescript", "javascript" }) do
        dap.configurations[ft] = dap.configurations[ft] or {}
        table.insert(dap.configurations[ft], attach_local_stack)
      end
    end,
  },
}
