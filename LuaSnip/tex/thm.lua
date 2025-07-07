local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")
local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(0))
  end
end
local snip = {
  s(
    { trig = "prop", name = "Proposition", desc = "proposition with or without title" },
    fmta(
      [[
      \begin{proposition}<title>
      <content>
      \end{proposition}
      ]],
      {
        title = c(1, { t(""), sn(nil, { t("["), i(1), t("]") }) }),
        content = i(0,"content"),
      }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "thm", name = "Theorem", desc = "Theorem with or without title" },
    fmta(
      [[
      \begin{theorem}<title>
      <content>
      \end{theorem}
      ]],
      {
        title = c(1, { t(""), sn(nil, { t("["), i(1), t("]") }) }),
        content = i(0),
        -- content = d(0, get_visual),
      }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "lem", name = "Lemma", desc = "Lemma with or without title" },
    fmta(
      [[
      \begin{lemma}<title>
      <content>
      \end{lemma}
      ]],
      {
        title = c(1, { t(""), sn(nil, { t("["), i(1), t("]") }) }),
        -- content = d(2, get_visual),
        content = i(0),
      }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "defn", name = "Defination", desc = "Defination with or without title" },
    fmta(
      [[
      \begin{definition}<title>
      <content>
      \end{definition}
      ]],
      {
        title = c(1, { t(""), sn(nil, { t("["), i(1), t("]") }) }),
        content = i(0),
        -- content = d(2, get_visual),
      }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "pf", name = "Proof", desc = "proof with or without title" },
    fmta(
      [[
      \begin{proof}<title>
      <content>
      \end{proof}
      ]],
      {
        title = c(1, { t(""), sn(nil, { t("["), i(1), t("]") }) }),
        content = i(0),
      }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "rmk", name = "Remark", desc = "Remark with or without title" },
    fmta(
      [[
      \begin{remark}<title>
      <content>
      \end{remark}
      ]],
      {
        title = c(1, { t(""), sn(nil, { t("["), i(1), t("]") }) }),
        content = i(0),
      }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
}
local autosnip = {}

return snip, autosnip
