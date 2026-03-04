-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>fy", function()
  local path = vim.fn.expand("%:.") -- relative path
  vim.fn.setreg("+", path)
  Snacks.notify.info("Copied: " .. path)
end, { desc = "Copy Relative Path" })
