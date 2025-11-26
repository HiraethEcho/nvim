---
title: init
---

This is the main initialization file for Neovim configuration.

```lua
if vim.env.PROF then
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      -- event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      event = "VeryLazy",
    },
  })
end

-- require("opts")
require("core")
-- require("utils")
```

Code on the top makes that one can use `PROF=1 nvim` to start Neovim with the profiler enabled. It shows a profile of nvim.

`require("core")` load the file [lua/core/init.lua](/lua/core/init)
