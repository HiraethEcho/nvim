local tex = require("util.latex")
local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local maths =
  require("luasnip").extend_decorator.apply(s, { condition = tex.in_mathzone, show_condition = tex.in_mathzone })
local texts = require("luasnip").extend_decorator.apply(s, { condition = tex.in_text, show_condition = tex.in_text })

local snip = {
  texts({ trig = "tt", desc = "\\text{}" }, fmta("\\<>{<>} ", { c(1, { t("textbf"), t("emph") }), i(2) })),
  maths({ trig = "op", desc = "operation" }, { t("\\operatorname{"), d(1, get_visual),t("}") }),
  maths(
    { trig = "tt", wordTrig = true },
    fmta("\\<>{<>} ", {
      c(1, { t("text"), t("textit"), t("textbf"), t("mathbb"), t("bm"), t("mathrm") }),
      i(2),
    })
  ),
}
local autosnip = {}

return snip, autosnip
