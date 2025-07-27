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
    title: <title>
    tags:<tag>
    date: <date>
    <other>
    ---

    # <head>
    ]],
      {
        title = i(1),
        tag = i(2),
        date = p(os.date, "%Y-%m-%d"),
        other = c(3, {
          fmta(
            [[
              published : false
              excerpt: <>
              ]],
            { i(1) }
          ),
          fmta(
            [[
              draft : true
              password: <>
              summary: <>
              ]],
            { i(1),i(2) }
          ),
          t("status: draft"),
          t(""),
        }),
        head = rep(1),
      }
    )
  ),
}
local autosnip = {}
return snip, autosnip
