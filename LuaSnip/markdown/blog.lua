local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
local snip = {
  s(
    { trig = "memexbak", name = "memex front meta", desc = "title, date, tag" },
    fmta(
      [[
    ---
    title: <title>
    summary: <summary>
    date: <date><tag><category><topic><series><status><draft>
    ---

    # <head>
    ]],
      {
        title = i(1),
        summary = i(2),
        date = p(os.date, "%Y-%m-%d"),
        tag = c(3, { t({ "", "tags: " }), t("") }),
        category = c(4, { t({ "", "category: " }), t("") }),
        topic = c(5, { t({ "", "topic: " }), t("") }),
        series = c(6, { t({ "", "series: " }), t("") }),
        status = c(7, {
          sn(1, { t({ "", "status: " }), c(1, { t("progress"), t("draft") }) }),
          sn(1, t("")),
        }),
        draft = c(8, { t({ "", "draft: true" }), t("") }),
        head = rep(1),
      }
    )
  ),
  s(
    { trig = "memex", name = "memex front meta", desc = "title, date, tag" },
    fmta(
      [[
    ---
    title: <title>
    date: <date>
    summary: <summary>
    tags: <tag>
    categories: <category>
    topics: <topic>
    series: <series><draft>
    ---

    # <head>
    ]],
      {
        title = i(1),
        date = p(os.date, "%Y-%m-%d"),
        summary = i(2),
        tag = i(3),
        category = i(4),
        topic = i(5),
        series = i(6),
        draft = c(7, { t({ "", "draft: true" }), t("") }),
        head = rep(1),
      }
    )
  ),
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
              draft: true
              password: <>
              summary: <>
              categories: <>
              ]],
            { i(1), i(2), i(3) }
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
