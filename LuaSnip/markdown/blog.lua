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
    ]],
      {
        i(2),
        i(3),
        p(os.date, "%Y-%m-%d %H:%M"),
        c(1, { t({ "published: false", "excerpt:" }), t({ "draft: true", "summary:" }), t("status: draft") }),
        -- i(2),
      }
    )
  ),
}
local autosnip = {}
return snip, autosnip
