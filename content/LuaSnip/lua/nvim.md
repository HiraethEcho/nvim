---
title: nvim
---
```lua
local get_visual = function(args, parent)
if #parent.snippet.env.SELECT_RAW > 0 then
return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
else -- If SELECT_RAW is empty, return a blank insert node
return sn(nil, i(1))
end
end

local snip = {
s(
{ trig = "ignore", desc = "stylua ignore" },
c(1, {
t("-- stylua: ignore"),
fmta("-- stylua: ignore start\n<>\n-- sytlua: ignore stop", d(1, get_visual)),
})
),
}

local autosnip = {}

return snip, autosnip
```
