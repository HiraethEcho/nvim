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
    { trig = "roundup", name = "ceil", desc = "ceil" },
    fmt(
      [[
      {open}ceil({content}){close}
      ]],
      { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) }
    )
  ),
  maths(
    { trig = "rounddown", name = "floor", desc = "floor" },
    fmt(
      [[
      {open}floor({content}){close}
      ]],
      { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) }
    )
  ),
  maths(
    { trig = "round", name = "round", desc = "ceil or floor" },
    c(1, {
      sn(
        nil,
        fmt(
          "{open}ceil({content}){close}",
          { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) }
        )
      ),
      sn(
        nil,
        fmt(
          "{open}floor({content}){close}",
          { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) }
        )
      ),
    })
  ),
  maths(
    { trig = "set", name = "set", desc = "set notation" },
    fmt(
      [[
      {open}{{ x : {content} }}{close}
      ]],
      { open = f(typst.open_math), content = i(1), close = f(typst.close_math) }
    )
  ),
  maths(
    { trig = "abs", name = "abs", desc = "absolute value" },
    fmt(
      [[
      {open}abs({content}){close}
      ]],
      { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) }
    )
  ),
  maths(
    { trig = "norm", name = "norm", desc = "norm" },
    fmt(
      [[
      {open}norm({content}){close}
      ]],
      { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) }
    )
  ),
}

local autosnip = {}

return snip, autosnip
