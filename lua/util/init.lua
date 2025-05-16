local M = {}
local Util = require("lazy.core.util")

-- only used in neotree
function M.system_open(path)
  -- TODO: REMOVE WHEN DROPPING NEOVIM <0.10
  if vim.ui.open then
    return vim.ui.open(path)
  end
  local cmd
  if vim.fn.has("win32") == 1 and vim.fn.executable("explorer") == 1 then
    cmd = { "cmd.exe", "/K", "explorer" }
  elseif vim.fn.has("unix") == 1 and vim.fn.executable("xdg-open") == 1 then
    cmd = { "xdg-open" }
  end
  vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand("<cfile>") }), { detach = true })
end

M.has = function(feat)
  if vim.fn.has(feat) == 1 then
    return true
  end
  return false
end

-- vim.g.is_win = (M.has("win32") or M.has("win64")) and true or false
vim.g.is_linux = (M.has("unix") and (not M.has("macunix"))) and true or false
-- vim.g.is_mac = M.has("macunix") and true or false

M.toggle_set = require("util.toggle").toggle_set
M.toggle_diagnostics = require("util.toggle").toggle_diagnostics
-- M.float_term = require("util.term").float_term
M.float_term = require("util.term")
-- M.lazygit = require("util.term").lazygit

function M.lazygit()
  return M.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end
-- M.test = require("util.test")

return M
