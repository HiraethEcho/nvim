---
title: luasnip-helper
---
```lua

```lua
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local l = require("luasnip.extras").lambda
local dl = require("luasnip.extras").dynamic_lambda
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty

local types = require("luasnip.util.types")
local events = require("luasnip.util.events")

-- local conds = require("luasnip.extras.expand_conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")
-- local line_begin = require("luasnip.extras.conditions.expand").line_begin
-- local line_begin = conds_expand.line_begin
-- local line_begin = conds.line_begin

local M = {}

function M.get_visual(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

M.tex_utils = {}
M.tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

M.tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end

M.tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end

M.tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
M.tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end

M.tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end

M.tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end

return M
```
```
