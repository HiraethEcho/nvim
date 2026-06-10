local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local typst = require("util.typst")
local maths = require("luasnip").extend_decorator.apply(s, { condition = typst.in_mathzone, show_condition = typst.in_mathzone })
local texts = require("luasnip").extend_decorator.apply(s, { condition = typst.in_text, show_condition = typst.in_text })

local snip = {
  maths(
    { trig = "ali", name = "align", desc = "aligned display math" },
    fmt(
      [[
      $
        {left1} &= {right1} \
        {left2} &= {right2}
      $
      ]],
      {
        left1 = i(1),
        right1 = i(2),
        left2 = i(3),
        right2 = i(0),
      }
    )
  ),
  maths(
    { trig = "bigfun", name = "big function", desc = "mapping display" },
    fmt(
      [[
      {open}
        {dom} : {src} &-> {tgt} \
        {arg} &|-> {img}
      {close}
      ]],
      {
        open = f(typst.open_math),
        dom = i(1, "f"),
        src = i(2, "X"),
        tgt = i(3, "Y"),
        arg = i(4, "x"),
        img = i(5, "f(x)"),
        close = f(typst.close_math),
      }
    )
  ),
}

local autosnip = {
  maths(
    { trig = "ii", name = "inline math", desc = "inline math" },
    fmt("${content}$", { content = i(1) })
  ),
  texts(
    { trig = "dm", name = "display math", desc = "display math" },
    fmt(
      [[
      $
        {content}
      $
      ]],
      { content = i(0) }
    )
  ),
}

return snip, autosnip
