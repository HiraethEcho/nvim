local tex = require("util.latex")

local snip = {
  s({ trig = "bigfun", name = "Big function" }, {
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
  }, { condition = tex.in_text, show_condition = tex.in_text }),
  s(
    { trig = "ali", name = "Align" },
    { t({ "\\begin{align*}", "\t" }), i(1), t({ "", ".\\end{align*}" }) },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
}
local autosnip = {
  s({ trig = "ii" }, { t("$ "), i(1), t(" $") }, { condition = tex.in_text }),
  s(
    { trig = "dm", name = "display math", desc = "\\[\\]" },
    fmta(
      [[
      \[
        <>
      \]
      ]],
      {
        i(0),
      }
    ),
    { condition = tex.in_text }
  ),
}
return snip, autosnip
