---
title: all
---
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

local conds = require("luasnip.extras.expand_conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local tex = require("util.latex")

-- stylua: ignore
local maths = require("luasnip").extend_decorator.apply(s, { condition = tex.in_mathzone, show_condition = tex.in_mathzone })

local get_visual = function(args, parent)
if #parent.snippet.env.SELECT_RAW > 0 then
return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
else -- If SELECT_RAW is empty, return a blank insert node
return sn(nil, i(1))
end
end

local snip = {
s({ trig = "date", name = "Current date", dscr = "YYYY-MM-DD and other" }, {
c(1, {
p(os.date, "%Y-%m-%d"),
p(os.date, "%Y-%m-%d %H:%M"),
p(os.date, "%H:%M"),
f(function()
return os.date("%D - %H:%M")
end),
}),
}),
}

local autosnip = {}

return snip, autosnip
```
