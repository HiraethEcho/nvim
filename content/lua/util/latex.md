---
title: latex
---
```lua
local M = {}

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}

local ts_utils = require("nvim-treesitter.ts_utils")

M.in_env_md = function(env)
  local node = ts_utils.get_node_at_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  while node do
    if node:type() == "generic_environment" then
      local begin = node:child(0)
      local name = begin:field("name")
      if name[1] and vim.treesitter.get_node_text(name[1], bufnr, nil) == "{" .. env .. "}" then
        return true
      end
    end
    node = node:parent()
  end
  return false
end

M.in_env = function(env)
  local pos = vim.fn["vimtex#env#is_inside"](env)
  return pos[1] ~= 0 or pos[2] ~= 0
end

M.in_mathzone = function()
  local ft = vim.bo.filetype
  if ft == "tex" then
    return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
  elseif ft == "markdown" then
    return M.in_mathzone_md()
  end
end

M.in_text = function()
  return not M.in_mathzone()
end

M.in_item = function()
  return M.in_env("itemize") or M.in_env("enumerate")
end
M.in_bib = function()
  return M.in_env("thebibliography")
end
M.in_tikz = function()
  return M.in_env("tikzpicture")
end
M.in_quantikz = function()
  return M.in_env("quantikz")
end
M.in_algo = function()
  return M.in_env("algorithmic")
end

-- For markdown
M.in_mathzone_md = function()
  local node = ts_utils.get_node_at_cursor()
  while node do
    if MATH_NODES[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

M.in_text_md = function()
  return not M.in_mathzone_md()
end

return M
```
