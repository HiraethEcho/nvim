---
title: typst
---
```lua
return {
  {
    "chomosuke/typst-preview.nvim",
    -- lazy = false, -- or
    ft = "typst",
    version = "1.*",
    opts = {
      dependencies_bin = {
        ["tinymist"] = "tinymist",
        ["websocat"] = "websocat",
      },
    }, -- lazy.nvim will implicitly calls `setup {}`
  },
  -- disabled
}
```
