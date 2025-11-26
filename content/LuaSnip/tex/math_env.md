---
title: math_env
---
```lua
local tex = require("util.latex")
local texts = require("luasnip").extend_decorator.apply(s, { condition = tex.in_text, show_condition = tex.in_text })

local snip = {
texts({ trig = "bigfun", name = "Big function" }, {
t({ "\\begin{align*}", "\t" }),
i(1),
t(":"),
t(" "),
i(2),
t("&\\longrightarrow "),
i(3),
t({ " \\\\", "\t" }),
i(4),
t("&\\longmapsto "),
i(5),
i(0),
t({ "", ".\\end{align*}" }),
}),
texts({ trig = "ali", name = "Align" }, { t({ "\\begin{align*}", "\t" }), i(1), t({ "", ".\\end{align*}" }) }),
}

local autosnip = {
texts({ trig = "ii" }, { t("$ "), i(1), t(" $") }),
texts(
{ trig = "dm", name = "display math", desc = "\\[\\]" },
fmta(
[[\[
        <>
      \]]],
{
i(0),
}
)
),
}
return snip, autosnip
```
