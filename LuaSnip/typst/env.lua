local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin
local typst = require("util.typst")
local texts = require("luasnip").extend_decorator.apply(s, { condition = typst.in_text, show_condition = typst.in_text })

local snip = {
  texts(
    { trig = "table", name = "table", desc = "table in figure", condition = line_begin },
    fmt(
      [[
      #figure(
        table(
          columns: ({cols}),
          {rows}
        ),
        caption: [{caption}]
      )
      ]],
      { cols = i(1, "1pt"), rows = i(2), caption = i(0) }
    )
  ),
  texts(
    { trig = "figure", name = "figure", desc = "figure with image", condition = line_begin },
    fmt(
      [[
      #figure(
        image("{path}", width: {width}),
        caption: [{caption}]
      )
      ]],
      { path = i(1), width = i(2, "80%"), caption = i(0) }
    )
  ),
  texts(
    { trig = "align", name = "align center", desc = "align center", condition = line_begin },
    fmt(
      [[
      #align({how}, [
        {content}
      ])
      ]],
      { how = i(1, "center"), content = i(0) }
    )
  ),
}

local autosnip = {}

return snip, autosnip
