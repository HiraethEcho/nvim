---
title: modify
---
```lua
local get_visual = function(args, parent)
if #parent.snippet.env.SELECT_RAW > 0 then
return sn(nil, t(parent.snippet.env.SELECT_RAW))
else -- If SELECT_RAW is empty, return a blank insert node
return sn(nil, i(1))
end
end
local tex = require("util.latex")
local maths =
require("luasnip").extend_decorator.apply(s, { condition = tex.in_mathzone, show_condition = tex.in_mathzone })
local texts = require("luasnip").extend_decorator.apply(s, { condition = tex.in_text, show_condition = tex.in_text })

local snip = {

maths(
{ trig = "Bar", wordTrig = true },
fmta("\\<>{<>} ", {
c(1, { t("overline"), t("widehat"), t("widetilde") }),
i(0),
})
),
maths(
{ trig = "bar", wordTrig = true },
fmta("\\<>{<>} ", {
c(1, { t("bar"), t("hat"), t("tilde") }),
i(0),
})
),
}

local autosnip = {
maths({ trig = "\__", regTrig = false, wordTrig = false }, { t("_{"), i(1), t("}") }),
maths({ trig = "/^/^", regTrig = true, wordTrig = false }, { t("^{"), i(1), t("}") }),
maths(
{ trig = "([%a%)%]%}])(%a)%2", regTrig = true, wordTrig = false },
fmta("<>_{<>}", {
f(function(_, snip)
return snip.captures[1]
end),
f(function(_, snip)
return snip.captures[2]
end),
})
),
maths(
{ trig = "([%a%)%]%}])(%d)", regTrig = true, wordTrig = false },
fmta("<>_{<>}", {
f(function(_, snip)
return snip.captures[1]
end),
f(function(_, snip)
return snip.captures[2]
end),
})
),
maths({ trig = "cal", regTrig = true, wordTrig = true }, fmta("\\mathcal{<>}", i(1))),
maths(
{ trig = "([%u])cal", regTrig = true, wordTrig = false },
fmta("\\mathcal{<>}", {
f(function(_, snip)
return snip.captures[1]
end),
})
),
maths(
{ trig = "([%u])bf", regTrig = true },
fmta("\\<>{<>} ", {
c(1, { t("mathbf"), t("mathsf"), t("mathbb"), t("bm"), t("mathrm") }),
f(function(_, snip)
return snip.captures[1]
end),
})
),
texts(
{ trig = "([%w])SS", regTrig = true, wordTrig = false },
fmta("\\(<>\\)", {
f(function(_, snip)
return snip.captures[1]
end),
})
),
maths(
{ trig = "([%w%\\%{%}]+)Bar", regTrig = true },
fmta("\\<>{<>} ", {
c(1, { t("overline"), t("widehat"), t("widetilde") }),
f(function(_, snip)
return snip.captures[1]
end),
})
),
maths(
{ trig = "([%w])bar", regTrig = true },
fmta("\\<>{<>} ", {
c(1, { t("bar"), t("hat"), t("tilde") }),
f(function(\_, snip)
return snip.captures[1]
end),
})
),
}

return snip, autosnip
```
