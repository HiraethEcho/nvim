---
title: external
---
```lua
return {
  { -- "hat0uma/prelive.nvim",
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
  { -- "lowitea/aw-watcher.nvim",
    "lowitea/aw-watcher.nvim",
    event = "BufRead",
    enabled = false,
    cmd = "AWStart",
    config = function()
      require("aw_watcher").setup({})
      vim.cmd([[ AWStart ]])
    end,
  },
  { -- "ActivityWatch/aw-watcher-vim",
    "ActivityWatch/aw-watcher-vim",
    -- lazy = false,
    event = "BufRead",
    enabled = false,
    cmd = "AWStart",
    config = function()
      vim.cmd([[ AWStart ]])
    end,
  },
  { -- "axieax/urlview.nvim",
    "axieax/urlview.nvim",
    -- enabled = false,
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
  { -- "sontungexpt/url-open",
    "sontungexpt/url-open",
    -- enabled = false,
    branch = "mini",
    keys = {
      { "gw", "<cmd>URLOpenUnderCursor<cr>", desc = "Open URL under cursor" },
    },
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then
        return
      end
      url_open.setup({})
    end,
  },
}
```
