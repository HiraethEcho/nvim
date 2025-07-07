local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")
local tex_utils=require("util.luasnip-helper").tex_utils
local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local snip_bak = {
  s(
    { trig = "xym" },
    c(1, {
      sn(
        nil,
        fmta(
          [[
        \xymatrix{
        & <> \ar[ld]\ar[rd] &\\
        <>\ar[rr] & &<> 
        }
      ]],
          {
            i(1, "W"),
            i(2, "X"),
            i(3, "Y"),
          }
        )
      ),
      sn(
        nil,
        fmta(
          [[
        \xymatrix{
        <>\ar[rd] \ar[rr]$1 & & <>\ar[ld]$2 \\
        & <> &
        }
      ]],
          {
            i(1, "X"),
            i(2, "Y"),
            i(3, "V"),
          }
        )
      ),
      sn(
        nil,
        fmta(
          [[
        \xymatrix{
        <> & <> \\
        <> & <> \\
        }
      ]],
          {
            i(1),
            i(2),
            i(3),
            i(4),
          }
        )
      ),
    }),
    { condition = tex.in_mathzone, show_condition = tex.in_mathzone }
  ),
}

return {
  s(
    { trig = "roundup", name = "round up", desc = "\\left\\lceil\\right\\rceil" },
    fmta("\\left\\lceil <> \\right\\rceil", d(1, get_visual)),
    { condition = tex.in_mathzone, show_condition = tex.in_mathzone }
  ),
  s(
    { trig = "rounddown", name = "round down", desc = "\\left\\lfoor\\right\\rfloor" },
    fmta("\\left\\lfloor <> \\right\\rfloor", d(1, get_visual)),
    { condition = tex.in_mathzone, show_condition = tex.in_mathzone }
  ),
  s(
    { trig = "round", name = "round down or down", desc = "ceil or floor" },
    c(1, {
      sn(nil, fmta("\\left\\lfloor <> \\right\\rfloor", d(1, get_visual))),
      sn(nil, fmta("\\left\\lceil <> \\right\\rceil", d(1, get_visual))),
    }),
    { condition = tex.in_mathzone, show_condition = tex.in_mathzone }
  ),
  s(
    { trig = "flip" },
    fmta(
      [[
        \xymatrix{
        <>\ar[rd] \ar[rr]$1 & & <>\ar[ld]$2 \\
        & <> &
      ]],
      {
        i(1, "X"),
        i(2, "Y"),
        i(3, "V"),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "resolvemap" },
    fmta(
      [[
        \xymatrix{
        & <> \ar[ld]\ar[rd] &\\
        <>\ar[rr] & &<> 
        }
      ]],
      {
        i(1, "W"),
        i(2, "X"),
        i(3, "Y"),
      }
    ),
    { condition = tex.in_mathzone }
  ),
}, {}
