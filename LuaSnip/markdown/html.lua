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
        i(3),
      }
    )
  ),
}
local autosnip = {}
return snip, autosnip
