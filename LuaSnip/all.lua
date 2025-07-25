local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local l = require("luasnip.extras").lambda
local dl = require("luasnip.extras").dynamic_lambda
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty

local types = require("luasnip.util.types")
local events = require("luasnip.util.events")

local conds = require("luasnip.extras.expand_conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local tex = require("util.latex")

-- local maths = require("luasnip").extend_decorator.apply(s, { condition = tex.in_mathzone, show_condition = tex.in_mathzone })

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
  return args[1]
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
    })
  )
end

local date_input = function(args, snip, old_state, fmt)
  local fmt = fmt or "%Y-%m-%d"
  return sn(nil, i(1, os.date(fmt)))
end

local function bash(_, _, command)
  local file = io.popen(command, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

return {

  s("index", {
    i(2,"2"), -- ai[2]: indices based on jump-index, not position.
    sn(1, { -- ai[1]
      i(1,"11"), -- ai[1][1]
      t("lel"), -- not addressable.
      i(2,"12"), -- ai[1][2]
    }),
    c(3, { -- ai[3]
      i(nil), -- ai[3][1]
      t("32"), -- ai[3][2]: choices are always addressable.
    }),
    d(4, function() -- ai[4]
      return sn(nil, { -- ai[4][0]
        i(1,"401"), -- ai[4][0][1]
      })
    end, {}),
    r(
      5,
      "restore_key", -- ai[5]
      i(1) -- ai[5][0][1]: restoreNodes always store snippetNodes.
    ),
    r(
      6,
      "restore_key_2", -- ai[6]
      sn(nil, { -- ai[6][0]
        i(1), -- ai[6][0][1]
      })
    ),
  }),
  s("trig", {
    t("text: "),
    i(1),
    t({ "", "copy: " }),
    d(2, function(args)
      -- the returned snippetNode doesn't need a position; it's inserted
      -- "inside" the dynamicNode.
      return sn(nil, {
        -- jump-indices are local to each snippetNode, so restart at 1.
        i(1, args[1]),
      })
    end, { 1 }),
  }),
  s({ trig = "date", name = "Current date", dscr = "YYYY-MM-DD and other" }, {
    c(1, {
      p(os.date, "%Y-%m-%d"),
      p(os.date, "%Y-%m-%d %H:%M"),
      p(os.date, "%H:%M"),
      f(function()
        return os.date("%D - %H:%M")
      end),
    }),
  }),

  s("novel", {
    t("It was a dark and stormy night on "),
    d(1, date_input, {}, { user_args = { "%A, %B %d of %Y" } }),
    t(" and the clocks were striking thirteen."),
  }),

  s("fmt6", fmta("foo() { return <>; }", d(1, get_visual))),

  -- ls.parser.parse_snipmate("year", "The year is `strftime('%Y')`"),
  -- ls.parser.parse_snippet("lspsyn", "Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"),
  s(
    { trig = "a%d", regTrig = true },
    f(function(_, snip)
      return "Triggered with " .. snip.trigger .. "."
    end, {})
  ),
  s(
    { trig = "b(%d)", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      return "Captured Text: " .. snip.captures[1] .. "."
    end, {})
  ),
  s({ trig = "c(%d+)", regTrig = true }, {
    t("will only expand for even numbers"),
  }, {
    condition = function(line_to_cursor, matched_trigger, captures)
      return tonumber(captures[1]) % 2 == 0
    end,
  }),

  s("bash", f(bash, {}, { user_args = { "ls" } })),

  s("repeat", { i(1, "text"), t({ "", "" }), rep(1) }),

  -- use matchNodes (`m(argnode, condition, then, else)`) to insert text
  -- based on a pattern/function/lambda-evaluation.
  -- It's basically a shortcut for simple functionNodes:
  s("mat", {
    i(1, { "sample_text" }),
    t(": "),
    m(1, "%d", "contains a number", "no number :("),
  }),
  -- The `then`-text defaults to the first capture group/the entire
  -- match if there are none.
  s("mat2", {
    i(1, { "sample_text" }),
    t(": "),
    m(1, "[abc][abc][abc]"),
  }),
  -- It is even possible to apply gsubs' or other transformations
  -- before matching.
  s("mat3", {
    i(1, { "sample_text" }),
    t(": "),
    m(1, l._1:gsub("[123]", ""):match("%d"), "contains a number that isn't 1, 2 or 3!"),
  }),
  -- `match` also accepts a function in place of the condition, which in
  -- turn accepts the usual functionNode-args.
  -- The condition is considered true if the function returns any
  -- non-nil/false-value.
  -- If that value is a string, it is used as the `if`-text if no if is explicitly given.
  s("mat4", {
    i(1, { "sample_text" }),
    t(": "),
    m(1, function(args)
      -- args is a table of multiline-strings (as usual).
      return (#args[1][1] % 2 == 0 and args[1]) or nil
    end),
  }),

  s("ls", {
    t({ "\\begin{itemize}", "\t\\item " }),
    i(1),
    d(2, rec_ls, {}),
    t({ "", "\\end{itemize}", "" }),
  }),
}, { -- autotriggers
  s("nempty", {
    i(1, "sample_text"),
    n(1, "i(1) is not empty!"),
  }),
  s("cond2", {
    t("will only expand at the beginning of the line"),
  }, {
    condition = line_begin,
  }),
  s("cond3", {
    t("will only expand at the end of the line"),
  }, {
    condition = line_end,
  }),
}
