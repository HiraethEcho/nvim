# nvim-math-snippetnvim][lazy]):

https://github.com/mathjiajia/nvim-math-snippets

```lua

local tex = require("math-snippets.latex")
local math_opts = { condition = tex.in_math, show_condition = tex.in_math }

    s({ trig = "rmap", name = "rational map arrow", wordTrig = false, hidden = true }, {
        d(1, function()
            if tex.in_tikzcd() then
                return sn(nil, { t({ "\\arrow[" }), i(1), t({ ",dashrightarrow]" }) })
            else
                return sn(nil, { t("\\dashrightarrow ") })
            end
        end),
    }, math_opts),

    s({ trig = "emb", name = "embeddeing map arrow", wordTrig = false, hidden = true }, {
        d(1, function()
            if tex.in_tikzcd() then
                return sn(nil, { t({ "\\arrow[" }), i(1), t({ ",hookrightarrow]" }) })
            else
                return sn(nil, { t("\\hookrightarrow ") })
            end
        end),
    }, math_opts),
```
