local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local snip = {
  s(
    { trig = "callout_div", name = "callout", desc = "div callout" },
    fmt(
      [[
  <div class="admonition {}">
  <p class="admonition-title">{}</p>
  <p>{}</p>
  </div>
    ]],
      {
        c(1, { t("note"), t("tip"), t("important"), t("warning"), t("warning"), t("caution") }),
        i(2),
        d(3, get_visual),
      }
    )
  ),
}
local autosnip = {}
return snip, autosnip
