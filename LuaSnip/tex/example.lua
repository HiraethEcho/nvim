local tex = require("util.latex")

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local autosnip = {
  s(
    { trig = "bad", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{adjustbox}{width=0.<>\textwidth}
        <>
      \end{adjustbox}
      ]],
      {
        i(1, "8"),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "(%d+)bp", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      \begin{homeworkProblem}[Problem <>.]
        <>
      \end{homeworkProblem}
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "cha", snippetType = "autosnippet" },
    fmta(
      [[
        \chapter{<>}
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
}

return snip, autosnip
