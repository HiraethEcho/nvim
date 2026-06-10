local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local typst = require("util.typst")
local texts =
  require("luasnip").extend_decorator.apply(s, { condition = typst.in_text, show_condition = typst.in_text })
local maths =
  require("luasnip").extend_decorator.apply(s, { condition = typst.in_mathzone, show_condition = typst.in_mathzone })

local snip = {
  texts(
    { trig = "hl", name = "highlight", desc = "highlight" },
    fmt("#highlight[{content}]", { content = d(1, get_visual) })
  ),

  maths({ trig = "opn", desc = "operation" }, { t('op("'), d(1, get_visual), t('")') }),
  maths(
    { trig = "tt", name = "math formatting", desc = "math formatting" },
    fmt("{cmd}({content})", {
      cmd = c(1, { t("bb"), t("bold"), t("upright") }),
      content = d(2, get_visual),
    })
  ),
}

local autosnip = {}

return snip, autosnip
