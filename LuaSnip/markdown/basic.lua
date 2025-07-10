local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
local snip = {
  s(
    { trig = "callout", name = "callout", desc = "[!note]" },
    fmt("> [!{}] {}\n> {}", {
      c(1, { t("note"), t("tip"), t("important"), t("warning"), t("warning"), t("caution") }),
      i(2),
      i(3),
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
    { trig = "ii", name = "font", desc = "italic, bold, code" },
    fmt("{}{}{}", {
      c(2, { t("*"), t("**"), t("`"), t("~~"), t("***") }),
      d(1, get_visual),
      rep(2),
    })
  ),
}

return snip, autosnip
