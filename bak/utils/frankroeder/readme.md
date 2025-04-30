https://github.com/frankroeder/dotfiles/blob/master/nvim/lua/tsutils.lua

```luasnip
require("luasnip.loaders.from_lua").lazy_load()
local tsutils = require "tsutils"
local autosnippet = require("luasnip").extend_decorator.apply(s, { snippetType = "autosnippet" })

return {
  s(
    { trig = "frac", dscr = "LaTex math fraction" },
    fmta("\\frac{<>}{<>}", { i(1, "numerator"), i(2, "denominator") }),
    { condition = tsutils.in_mathzone }
  ),
  autosnippet(
    {
      trig = "(%a)+hat",
      regTrig = true,
      name = "hat",
      dscr = "Replaces x+hat with \\hat{x}",
    },
    fmt(
      [[\hat{<>}]],
      { f(function(_, snip)
        return snip.captures[1]
      end) },
      { delimiters = "<>" }
    ),
    { condition = tsutils.in_mathzone }
  ),
  autosnippet(
    {
      trig = "(%a)+bar",
      regTrig = true,
      name = "bar",
      dscr = "Replaces x+bar with \\overline{x}",
    },
    fmt(
      [[\overline{<>}]],
      { f(function(_, snip)
        return snip.captures[1]
      end) },
      { delimiters = "<>" }
    ),
    { condition = tsutils.in_mathzone }
  ),
  autosnippet({ trig = "<=", name = "Less equal" }, t "\\le", { condition = tsutils.in_mathzone }),
  autosnippet(
    { trig = ">=", name = "Greater equal" },
    t "\\ge",
    { condition = tsutils.in_mathzone }
  ),
  autosnippet(
    { trig = "->", name = "Right arrow" },
    t "\\rightarrow",
    { condition = tsutils.in_mathzone }
  ),
  s({ trig = "<-", name = "Left arrow" }, t "\\leftarrow", { condition = tsutils.in_mathzone }),
  s(
    { trig = "<->", name = "Left-right arrow" },
    t "\\leftrightarrow",
    { condition = tsutils.in_mathzone }
  ),
  autosnippet(
    { trig = "inf", name = "Infinity" },
    t "\\infty",
    { condition = tsutils.in_mathzone }
  ),
}
```
