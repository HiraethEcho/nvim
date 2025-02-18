local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local tex_util = require("util.latex")
local get_visual = tex_util.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin
local postfix = require("luasnip.extras.postfix").postfix

local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  -- Combining text and insert nodes to create basic LaTeX commands
  s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" },
    {
      t("\\texttt{"), -- remember: backslashes need to be escaped
      i(1),
      t("}"),
    }
  ),

  s({ trig = "eq", dscr = "A LaTeX equation environment" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      \begin{equation}
          <>
      \end{equation}
    ]],
      -- The insert node is placed in the <> angle brackets
      { i(1) }
    -- This is where I specify that angle brackets are used as node positions.
    )
  ),

  -- s({trig="beg", snippetType="autosnippet"},
  s({ trig = "beg" },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
    ]],
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),

  s({ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
    fmta("\\textit{<>}",
      {
        d(1, get_visual),
      }
    )
  ),


  s({ trig = "sec", dscr = "section" },
    fmta(
      [[\section{<>}]],
      { i(1) }
    ),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s({ trig = "ssec", dscr = "subsection" },
    fmta(
      [[\subsection{<>}]],
      { i(1) }
    ),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s({ trig = "sssec", dscr = "subsubsection" },
    fmta(
      [[\subsubsection{<>}]],
      { i(1) }
    ),
    { condition = line_begin } -- set condition in the `opts` table
  ),

postfix("hat", {l("\\hat{" .. l.POSTFIX_MATCH .. "}")}, { condition=in_mathzone }),

  s({ trig = "frac", dscr = "fraction" },
    fmta(
      "\\frac{<>}{<>}",
      {
        i(1),
        i(2),
      }
    ),
    { condition = in_math } -- `condition` option passed in the snippet `opts` table
  ),
  postfix(".brl", {
    l("[" .. l.POSTFIX_MATCH .. "]"),
  }),
  postfix(".cal", { l("\\mathcal{" .. l.POSTFIX_MATCH .. "}") })
}
