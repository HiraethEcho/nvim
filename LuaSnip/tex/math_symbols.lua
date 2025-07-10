--[[
context "math()"
snippet Aa "Affine space" wA
\mathbb{A}^{${1:n}}
endsnippet

context "math()"
snippet RR "Real number" wA
\mathbb{R}
endsnippet

context "math()"
snippet FF "FF" wA
\mathbb{F}_{${1:n}}$0
endsnippet

context "math()"
snippet NN "Natural number" wA
\mathbb{N}
endsnippet

context "math()"
snippet ZZ "integers" wA
\mathbb{Z}
endsnippet

context "math()"
snippet QQ "Rational number" wA
\mathbb{Q}
endsnippet


context "math()"
snippet PP "Projectiv space" wA
\mathbb{P}^{${1:n}}
endsnippet

context "math()"
snippet CC "Complex number" wA
\mathbb{C} ]]
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
local snip = {
}
local autosnip = {
  maths(
    { trig = "CC", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\mathbb{C} <>", i(1))),
      sn(nil, fmta("\\mathbb{C}^{<>}", i(1,"n"))),
      sn(nil, fmta("\\mathbb{C}^{<>}", i(1,"*"))),
    })
  ),
  maths(
    { trig = "PP", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\mathbb{P} <>", i(1))),
      sn(nil, fmta("\\mathbb{P}^{<>}", i(1,"n"))),
      sn(nil, fmta("\\mathbb{P}(<>)", i(1))),
    })
  ),
  maths(
    { trig = "RR", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\mathbb{R} <>", i(1))),
      sn(nil, fmta("\\mathbb{R}_{\\geqslant 0} <>", i(1))),
      sn(nil, fmta("\\mathbb{R}^{<>}", i(1,"n"))),
    })
  ),
  maths(
    { trig = "...", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\ldots <>", i(1))),
      sn(nil, fmta("\\cdots <>", i(1))),
    })
  ),
  maths(
    { trig = "xx", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\times <>", i(1))),
      sn(nil, fmta("\\otimes <>", i(1))),
      sn(nil, fmta("\\oplus <>", i(1))),
      sn(nil, fmta("\\bigotimes_{<>}^{<>} <>", { i(1), i(2),i(0) })),
    })
  ),
  maths(
    { trig = "nn", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\cap <>", i(1))),
      sn(nil, fmta("\\bigcap <>", i(1))),
      sn(nil, fmta("\\bigcap_{<>}^{<>}", { i(1), i(2) })),
    })
  ),
  maths(
    { trig = "uu", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\cup <>", i(1))),
      sn(nil, fmta("\\bigcup <>", i(1))),
      sn(nil, fmta("\\bigcup_{<>}^{<>}", { i(1), i(2) })),
    })
  ),
  maths({ trig = "cc", wordTrig = true }, t("\\subset")),
}
return snip, autosnip
