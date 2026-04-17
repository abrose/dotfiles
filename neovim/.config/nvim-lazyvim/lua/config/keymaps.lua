-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>fy", function()
  local path = vim.fn.expand("%:.") -- relative path
  vim.fn.setreg("+", path)
  Snacks.notify.info("Copied: " .. path)
end, { desc = "Copy Relative Path" })

vim.keymap.set("n", "<leader>fY", function()
  local path = vim.fn.expand("%:p") -- absolute path
  vim.fn.setreg("+", path)
  Snacks.notify.info("Copied: " .. path)
end)

vim.keymap.set("n", "<leader>am", function()
  require("minuet.virtualtext").action.toggle_auto_trigger()
end, { desc = "Toggle Minuet Auto-completion" })

local function find_claude_root()
  local home = vim.fn.expand("~")
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" do
    if dir == home then
      vim.notify("Reached home directory without finding .claude/ — aborting", vim.log.levels.WARN)
      return nil
    end
    if vim.fn.isdirectory(dir .. "/.claude") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

local function add_review_note(start_line, end_line)
  local root = find_claude_root()
  if not root then
    vim.notify("No .claude/ directory found in parent directories", vim.log.levels.WARN)
    return
  end

  local file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":s?" .. root .. "/??")
  local input = vim.fn.input("Review note: ")
  if input == "" then
    return
  end

  local location
  if end_line and end_line ~= start_line then
    location = string.format("%s:%d-%d", file, start_line, end_line)
  else
    location = string.format("%s:%d", file, start_line)
  end

  local entry = string.format("%s — %s", location, input)
  local review_file = root .. "/.claude-review"
  local f, err = io.open(review_file, "a")
  if not f then
    vim.notify("Failed to open review file: " .. err, vim.log.levels.ERROR)
    return
  end
  f:write(entry .. "\n")
  f:close()
  vim.notify("Review note added (" .. root .. ")", vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>an", function()
  add_review_note(vim.fn.line("."))
end, { desc = "Add Claude Code review note" })

vim.keymap.set("v", "<leader>an", function()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  -- exit visual mode so marks are set
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  add_review_note(start_line, end_line)
end, { desc = "Add Claude Code review note (range)" })
