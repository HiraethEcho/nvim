---
title: env
---

```lua
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")
local get_visual = function(args, parent)
if #parent.snippet.env.SELECT_RAW > 0 then
return sn(nil, t(parent.snippet.env.SELECT_RAW))
else -- If SELECT_RAW is empty, return a blank insert node
return sn(nil, i(1))
end
end
local texts = require("luasnip").extend_decorator.apply(s, { condition = tex.in_text, show_condition = tex.in_text })

local snip = {
texts({trig="sec"},{t("\\section{"), i(1), t({"}",""}),i(0)},{condition=line_begin}),
texts(
{ trig = "ul", name = "item list", desc = "\\begin{itemize}" },
fmta("\\begin{itemize}<option>\n\t\\item <content>\n\\end{itemize}", {
option = c(1, { t(""), sn(nil, { t("["), i(1), t("]") }) }),
content = i(0),
})
),
texts(
{ trig = "ol", name = "ordered list", desc = "\\begin{enumerate}" },
fmta("\\begin{enumerate}<option>\n\t\\item <content>\n\\end{enumerate}", {
option = c(1, { t(""), sn(nil, { t("["), i(1), t("]") }) }),
content = i(0),
})
),
texts(
{ trig = "table", name = "table in tex", desc = "table, htbp, center, tabular" },
fmta(
[[\begin{table}[htbp]
        \centering
        \begin{tabular}{<>}
          \hline
          <>
          \hline
        \end{tabular}
        \caption{<>}
        \label{tab:<>}
      \end{table}]],
{
i(1),
i(2),
i(3),
i(0),
}
),
{ condition = line_begin }
),

texts(
{ trig = "tabular", name = "tabular in tex", desc = "tabular" },
fmta(
[[\begin{tabular}{<>}
        \hline
        <>
        \hline
      \end{tabular}]],
{
i(1),
i(2),
}
),
{ condition = line_begin }
),
texts(
{ trig = "bcr" },
fmta(
[[\begin{center}
        <>
      \end{center}]],
{
i(0),
}
),
{ condition = line_begin }
),

texts(
{ trig = "box" },
fmta(
[[\begin{framed}
        <>
      \end{framed}]],
{
i(0),
}
),
{ condition = line_begin }
),
texts(
{ trig = "beg" },
fmta(
[[\begin{<>}<title>
        <>
      \end{<>}]],
{
i(1),
title = c(2, { t(""), sn(nil, { t("["), i(2), t("]") }) }),
i(0),
rep(1),
}
),
{ condition = line_begin }
),
texts(
{ trig = "minipage", desc = "minipages in figure" },
fmta(
[[\begin{figure}[htbp]
        \centering
        \begin{minipage}[t]{0.48\textwidth}
          \centering
          \includegraphics[width=6cm]{}
          \caption{}
          \label{fig:}
        \end{minipage}
        \begin{minipage}[t]{0.48\textwidth}
          \centering
          \includegraphics[width=6cm]{}
          \caption{}
          \label{fig:}
        \end{minipage}
      \end{figure}]],
{}
),
{ condition = line_begin }
),
texts(
{ trig = "figure" },
fmta(
[[\begin{figure}[htbp]
        \centering
        \includegraphics[width=0.8\textwidth]{<>}
        \caption{<>}
        \label{fig:<>}
      \end{figure}]],
{
i(1),
i(2),
rep(2),
}
),
{ condition = line_begin }
),
}
local autosnip = {}
return snip, autosnip
```
