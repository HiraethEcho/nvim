local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local typst = require("util.typst")
local texts = ls.extend_decorator.apply(s, { condition = typst.in_text, show_condition = typst.in_text })

local snip = {
  texts({ trig = "bib", name = "bibliography" }, fmt("#bibliography(\"{path}\")", { path = i(1, "refs.bib") })),
}

local autosnip = {}

return snip, autosnip
