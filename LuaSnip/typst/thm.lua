local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(0))
  end
end

local typst = require("util.typst")
local texts = require("luasnip").extend_decorator.apply(s, { condition = typst.in_text, show_condition = typst.in_text })

local snip = {
  texts(
    { trig = "prop", name = "Proposition", desc = "proposition with or without title" },
    fmt(
      [[
      #proposition[
      {content}
      ]{label}
      ]],
      {
        content = i(0),
        label = c(1, { t(""), sn(nil, { t("<"), t("prop:"), i(1), t(">") }) }),
      }
    )
  ),
  texts(
    { trig = "thm", name = "Theorem", desc = "Theorem" },
    fmt(
      [[
      #theorem[
      {content}
      ]{label}
      ]],
      {
        content = i(0),
        label = c(1, { t(""), sn(nil, { t("<"), t("thm:"), i(1), t(">") }) }),
      }
    )
  ),
  texts(
    { trig = "lem", name = "Lemma", desc = "Lemma" },
    fmt(
      [[
      #lemma[
      {content}
      ]{label}
      ]],
      {
        content = i(0),
        label = c(1, { t(""), sn(nil, { t("<"), t("lem:"), i(1), t(">") }) }),
      }
    )
  ),
  texts(
    { trig = "rem", name = "Remark", desc = "Remark" },
    fmt(
      [[
      #remark[
      {content}
      ]{label}
      ]],
      {
        content = i(0),
        label = c(1, { t(""), sn(nil, { t("<"), t("rem:"), i(1), t(">") }) }),
      }
    )
  ),
  texts(
    { trig = "def", name = "Definition", desc = "Definition" },
    fmt(
      [[
      #definition[
      {content}
      ]{label}
      ]],
      {
        content = i(0),
        label = c(1, { t(""), sn(nil, { t("<"), t("def:"), i(1), t(">") }) }),
      }
    )
  ),
  texts(
    { trig = "cor", name = "Corollary", desc = "Corollary" },
    fmt(
      [[
      #corollary[
      {content}
      ]{label}
      ]],
      {
        content = i(0),
        label = c(1, { t(""), sn(nil, { t("<"), t("cor:"), i(1), t(">") }) }),
      }
    )
  ),
  texts(
    { trig = "ex", name = "Example", desc = "Example" },
    fmt(
      [[
      #example[
      {content}
      ]{label}
      ]],
      {
        content = i(0),
        label = c(1, { t(""), sn(nil, { t("<"), t("ex:"), i(1), t(">") }) }),
      }
    )
  ),
  texts(
    { trig = "pf", name = "Proof", desc = "Proof" },
    fmt(
      [[
      #proof[
        {content}
      ]
      ]],
      {
        content = i(0),
      }
    )
  ),
}
local autosnip = {}

return snip, autosnip
