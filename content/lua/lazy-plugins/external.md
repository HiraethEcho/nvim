---
title: external
---
# external apps

plugins that use external browser

```lua
return {
  { -- "hat0uma/prelive.nvim", host a web
    "hat0uma/prelive.nvim",
    opts = {},
    cmd = {
      "PreLiveGo",
      "PreLiveStatus",
      "PreLiveClose",
      "PreLiveCloseAll",
      "PreLiveLog",
    },
  },
  { -- "axieax/urlview.nvim",
    "axieax/urlview.nvim",
    -- lazy = false,
    cmd = "UrlView",
    keys = {
      { "<leader>sU", "<cmd>UrlView<cr>", desc = "List URL" },
      { "<leader>sL", "<cmd>UrlView<cr>", desc = "List Lazy plugin url" },
    },
    opts = {
      -- default_picker = "telescope",
    },
  },
}
```
