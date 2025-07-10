local snip = {
  s(
    { trig = "callout", name = "callout", desc = "[!note]" },
    fmt("> [!{}] {}\n> {}", {
      c(1, { t("note"), t("tip"), t("important"), t("warning"), t("warning"), t("caution") }),
      i(2),
      i(3),
    })
  ),
}
local autosnip = {}

return snip, autosnip
