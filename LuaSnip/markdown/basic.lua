local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
local snip = {
  s({ trig = "link", name = "link", desc = "[]()", wordTrig = false }, fmt("[{}]({})", { d(1, get_visual), i(2) })),
  s(
    { trig = "callout", name = "callout", desc = "[!note]" },
    fmt("> [!{}] {}\n> {}", {
      c(1, { t("NOTE"), t("TIP"), t("IMPORTANT"), t("WARNING"), t("WARNING"), t("CAUTION") }),
      i(2),
      i(3),
    })
  ),
  s(
    { trig = "note", name = "callout note", desc = "[!note]" },
    fmt("> [!{}] {}\n> {}", {
      t("NOTE"),
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "tip", name = "callout tip", desc = "[!tip]" },
    fmt("> [!{}] {}\n> {}", {
      t("TIP"),
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "important", name = "callout important", desc = "[!important]" },
    fmt("> [!{}] {}\n> {}", {
      t("IMPORTANT"),
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "warning", name = "callout warning", desc = "[!warning]" },
    fmt("> [!{}] {}\n> {}", {
      t("WARNING"),
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "caution", name = "callout caution", desc = "[!caution]" },
    fmt("> [!{}] {}\n> {}", {
      t("CAUTION"),
      i(1),
      i(2),
    })
  ),
  s({ trig = "h([2-6])", name = "Heading", desc = "Add Heading", regTrig = true }, {
    f(function(_, snip)
      return string.rep("#", tonumber(snip.captures[1], 10)) .. " "
    end),
  }),
}
local autosnip = {
  s(
    { trig = "ii", name = "font", desc = "italic, bold, code", wordTrig = false },
    fmt("{}{}{}", {
      c(2, { t("*"), t("**"), t("`"), t("~~"), t("***") }),
      d(1, get_visual),
      rep(2),
    })
  ),
}

return snip, autosnip
