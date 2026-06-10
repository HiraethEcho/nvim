local typst = require("util.typst")
local maths = require("luasnip").extend_decorator.apply(s, { condition = typst.in_mathzone, show_condition = typst.in_mathzone })

local snip = {}

local autosnip = {
  -- Simple blackboard bold with editable exponent
  maths({ trig = "AA", wordTrig = true }, fmt("{open}bb(A)^{exp}{close} {rest}", { open = f(typst.open_math), exp = i(1, "n"), close = f(typst.close_math), rest = i(0) })),
  maths({ trig = "FF", wordTrig = true }, fmt("{open}bb(F)_{exp}{close} {rest}", { open = f(typst.open_math), exp = i(1, "n"), close = f(typst.close_math), rest = i(0) })),
  maths(
    { trig = "CC", wordTrig = true },
    c(1, {
      fmt("{open}bb(C){close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}bb(C)^{n}{close}", { open = f(typst.open_math), n = i(1, "n"), close = f(typst.close_math) }),
    })
  ),
  maths(
    { trig = "PP", wordTrig = true },
    c(1, {
      fmt("{open}bb(P){close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}bb(P)({args}){close} {rest}", { open = f(typst.open_math), args = i(1), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}bb(P)^{n}{close} {rest}", { open = f(typst.open_math), n = i(1, "n"), close = f(typst.close_math), rest = i(0) }),
    })
  ),
  maths(
    { trig = "RR", wordTrig = true },
    c(1, {
      fmt("{open}bb(R){close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}bb(R)_(>=0){close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}bb(R)^{n}{close}", { open = f(typst.open_math), n = i(1, "n"), close = f(typst.close_math) }),
    })
  ),
  -- Math operations
  maths(
    { trig = "xx", wordTrig = true },
    c(1, {
      fmt("{open}times{close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}times.o{close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}plus.o{close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
    })
  ),
  maths(
    { trig = "nn", wordTrig = true },
    c(1, {
      fmt("{open}inter{close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}inter.big{close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}inter.big_({low})^({high}){close} {rest}", { open = f(typst.open_math), low = i(1, "i=1"), high = i(2, "n"), close = f(typst.close_math), rest = i(0) }),
    })
  ),
  maths(
    { trig = "uu", wordTrig = true },
    c(1, {
      fmt("{open}union{close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}union.big{close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) }),
      fmt("{open}union.big_({low})^({high}){close} {rest}", { open = f(typst.open_math), low = i(1, "i=1"), high = i(2, "n"), close = f(typst.close_math), rest = i(0) }),
    })
  ),
  maths({ trig = "cc", wordTrig = true }, fmt("{open}subset{close} {rest}", { open = f(typst.open_math), close = f(typst.close_math), rest = i(0) })),
}

return snip, autosnip
