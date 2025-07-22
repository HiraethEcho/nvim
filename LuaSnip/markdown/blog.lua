local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
local snip = {
  s(
    { trig = "meta", name = "meta data", desc = "title, date, tag" },
    fmta(
      [[
    ---
    title: <>
    tags:<>
    date: <>
    <>
    ---

    # <head>
    ]],
      {
        i(1),
        i(2),
        p(os.date, "%Y-%m-%d"),
        c(3, {
          sn(
            nil,
            fmta(
              [[
              published : false
              excerpt: <>
              ]],
              { i(1) }
            )
          ),
          sn(
            nil,
            fmta(
              [[
              draft : true
              summary: <>
              ]],
              { i(1) }
            )
          ),
          t("status: draft"),
        }),
        head = i(0),
      }
    ),
    {}
  ),
}
local autosnip = {}
return snip, autosnip
