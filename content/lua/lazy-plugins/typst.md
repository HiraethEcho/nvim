---
title: typst
---
# typst

To enable preview in browser and inverse search.

- need websocat for inverse search
- need lsp tinymist
- and ofcourse typst installed

If tinymist or websocat is not found, the plugin will download them

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
    },
  },
}
```
