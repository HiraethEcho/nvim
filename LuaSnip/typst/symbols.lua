local typst = require("util.typst")
local texts = require("luasnip").extend_decorator.apply(s, { condition = typst.in_text, show_condition = typst.in_text })

local snip = {
  -- Text abbreviations
  texts({ trig = "lcd", name = "log canonical divisor" }, t("log canonical divisor")),
  texts({ trig = "bdiv", name = "b-divisor" }, fmt("{open}bb(b){close}-divisor", { open = f(typst.open_math), close = f(typst.close_math) })),
  texts({ trig = "mm", name = "minimal model" }, t("minimal model")),
  texts({ trig = "fg", name = "finitely generated" }, t("finitely generated")),
  texts({ trig = "st", name = "such that " }, t("such that ")),
  texts({ trig = "mfs", name = "Mori fibre space" }, t("Mori fibre space")),
  texts({ trig = "gt", name = "general type" }, t("general type")),
  texts({ trig = "wlcm", name = "weak log canonical model" }, t("weak log canonical model")),
  texts({ trig = "gfq", name = "generalized foliated quadruple" }, fmt("({X}, {F}, {B}, {M})", { X = i(1), F = i(2), B = i(3), M = i(4) })),
}

local autosnip = {
  texts({ trig = "iff", name = "if and only if" }, t("if and only if")),
  texts({ trig = "wrt", name = "with respect to" }, t("with respect to")),
  texts({ trig = "wma", name = "we may assume" }, t("we may assume")),
  texts({ trig = "Qfac", name = "Q-factorial" }, fmt("{open}bb(Q){close}-factorial", { open = f(typst.open_math), close = f(typst.close_math) })),
  texts({ trig = "Rdiv", name = "R-divisor" }, fmt("{open}bb(R){close}-divisor", { open = f(typst.open_math), close = f(typst.close_math) })),
  texts({ trig = "Rcar", name = "R-Cartier" }, fmt("{open}bb(R){close}-Cartier", { open = f(typst.open_math), close = f(typst.close_math) })),
  texts({ trig = "Qdiv", name = "Q-divisor" }, fmt("{open}bb(Q){close}-divisor", { open = f(typst.open_math), close = f(typst.close_math) })),
  texts({ trig = "Qcar", name = "Q-Cartier" }, fmt("{open}bb(Q){close}-Cartier", { open = f(typst.open_math), close = f(typst.close_math) })),
}

return snip, autosnip
