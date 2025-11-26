---
title: bib
---
```lua
local tex = require("util.latex")
local snip = {
s(
{ trig = "bbi" },
fmta(
[[\begin{thebibliography}
        <>
      \end{thebibliography}]],
{
i(0),
}
),
{ condition = tex.in_text, show_condition = tex.in_text }
),
s({ trig = "bib" }, { t("\\bibitem") }, { condition = tex.in_bib }),
s({ trig = "im" }, { t("\\item") }, { condition = tex.in_item }),
}

return snip, autosnip
```
