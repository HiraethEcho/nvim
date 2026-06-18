local get_visual = function(_, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local cap1 = function(_, snip)
  return snip.captures[1]
end

local cap2 = function(_, snip)
  return snip.captures[2]
end

local typst = require("util.typst")
local maths = require("luasnip").extend_decorator.apply(s, { condition = typst.in_mathzone, show_condition = typst.in_mathzone })
local texts = require("luasnip").extend_decorator.apply(s, { condition = typst.in_text, show_condition = typst.in_text })

local snip = {
  maths(
    { trig = "bar", wordTrig = true, name = "bar/acute" },
    fmt("{open}bar({x}){close} {rest}", {
      open = f(typst.open_math),
      x = d(1, get_visual),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "hat", wordTrig = true, name = "hat" },
    fmt("{open}hat({x}){close} {rest}", {
      open = f(typst.open_math),
      x = d(1, get_visual),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "tilde", wordTrig = true, name = "tilde" },
    fmt("{open}tilde({x}){close} {rest}", {
      open = f(typst.open_math),
      x = d(1, get_visual),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "Bar", wordTrig = true, name = "overline/widehat" },
    c(1, {
      sn(1, fmt("{open}overline({content}){close}", { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) })),
      sn(1, fmt("{open}hat({content}){close}", { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) })),
      sn(1, fmt("{open}tilde({content}){close}", { open = f(typst.open_math), content = d(1, get_visual), close = f(typst.close_math) })),
    })
  ),
}

local autosnip = {
  maths({ trig = "__", regTrig = false, wordTrig = false }, { t("_("), i(1), t(")") }),
  -- maths({ trig = "^^", regTrig = false, wordTrig = false }, { t("^("), i(1), t(")") }),
  --[[ maths(
    { trig = "([%a%)%]%}])(%a)%2", regTrig = true, wordTrig = false },
    fmta("<>_(<>)", {
      f(cap1),
      f(cap2),
    })
  ), ]]
  maths(
    { trig = "([%a%)%]%}])(%d)", regTrig = true, wordTrig = false },
    fmta("<>_(<>)", {
      f(cap1),
      f(cap2),
    })
  ),
  maths(
    { trig = "([%w])bar", regTrig = true, wordTrig = false },
    fmt("{open}bar({x}){close} {rest}", {
      open = f(typst.open_math),
      x = f(cap1),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "([%w])hat", regTrig = true, wordTrig = false },
    fmt("{open}hat({x}){close} {rest}", {
      open = f(typst.open_math),
      x = f(cap1),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "([%w])tilde", regTrig = true, wordTrig = false },
    fmt("{open}tilde({x}){close} {rest}", {
      open = f(typst.open_math),
      x = f(cap1),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "([%w])cal", regTrig = true, wordTrig = false },
    fmt("{open}cal({x}){close} {rest}", {
      open = f(typst.open_math),
      x = f(cap1),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "([%u])bf", regTrig = true, wordTrig = false },
    fmt("{open}{cmd}({x}){close} {rest}", {
      open = f(typst.open_math),
      cmd = c(1, { t("bold"), t("bb"), t("cal"), t("mathsf"), t("upright") }),
      x = f(cap1),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "([%w])bold", regTrig = true, wordTrig = false },
    fmt("{open}bold({x}){close} {rest}", {
      open = f(typst.open_math),
      x = f(cap1),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  texts(
    { trig = "([%w])SS", regTrig = true, wordTrig = false },
    fmt("{open}{x}{close} {rest}", {
      open = f(typst.open_math),
      x = f(cap1),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
  maths(
    { trig = "([%w%\\%{%}]+)bar", regTrig = true, wordTrig = false },
    fmt("{open}overline({x}){close} {rest}", {
      open = f(typst.open_math),
      x = f(cap1),
      close = f(typst.close_math),
      rest = i(0),
    })
  ),
}

return snip, autosnip
