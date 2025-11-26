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
  maths({ trig = "set", wordTrig = true }, { t("\\{ "), i(1), t(" \\}") }),
}
local autosnip = {
  maths({ trig = "AA", wordTrig = true }, fmta("\\mathbb{A}^{<>} <>", { i(1, "n"), i(0) })),
  maths({ trig = "FF", wordTrig = true }, fmta("\\mathbb{F}_{<>} <>", { i(1, "n"), i(0) })),
  maths({ trig = "QQ", wordTrig = true }, fmta("\\mathbb{Q} <>", i(0))),
  maths({ trig = "NN", wordTrig = true }, fmta("\\mathbb{N} <>", i(0))),
  maths(
    { trig = "ZZ", wordTrig = true },
    c(1, {
      fmta("\\mathbb{Z} <>", i(0)),
      fmta("\\mathbb{Z}^{<>} <>", { i(1), i(0) }),
    })
  ),
  maths(
    { trig = "CC", wordTrig = true },
    c(1, {
      fmta("\\mathbb{C} <>", i(1)),
      fmta("\\mathbb{C}^{<>}", i(1, "n")),
    })
  ),
  maths(
    { trig = "PP", wordTrig = true },
    c(1, {
      fmta("\\mathbb{P} <>", i(1)),
      fmta("\\mathbb{P}(<>)", i(1)),
      fmta("\\mathbb{P}^{<>}", i(1, "n")),
    })
  ),
  maths(
    { trig = "RR", wordTrig = true },
    c(1, {
      fmta("\\mathbb{R} <>", i(1)),
      fmta("\\mathbb{R}_{\\geqslant 0} <>", i(1)),
      fmta("\\mathbb{R}^{<>}", i(1, "n")),
    })
  ),
  maths(
    { trig = "...", wordTrig = true },
    c(1, {
      fmta("\\ldots <>", i(1)),
      fmta("\\cdots <>", i(1)),
    })
  ),
  maths(
    { trig = "xx", wordTrig = true },
    c(1, {
      fmta("\\times <>", i(1)),
      fmta("\\otimes <>", i(1)),
      fmta("\\oplus <>", i(1)),
      fmta("\\bigotimes_{<>}^{<>} <>", { i(1), i(2), i(0) }),
    })
  ),
  maths(
    { trig = "nn", wordTrig = true },
    c(1, {
      fmta("\\cap <>", i(1)),
      fmta("\\bigcap <>", i(1)),
      fmta("\\bigcap_{<>}^{<>}", { i(1), i(2) }),
    })
  ),
  maths(
    { trig = "uu", wordTrig = true },
    c(1, {
      fmta("\\cup <>", i(1)),
      fmta("\\bigcup <>", i(1)),
      fmta("\\bigcup_{<>}^{<>}", { i(1), i(2) }),
    })
  ),
  maths({ trig = "cc", wordTrig = true }, t("\\subset")),
}
return snip, autosnip
