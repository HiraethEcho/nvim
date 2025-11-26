---
title: lazy-bootstrap
---

# plugin manager

This file downloads `lazy.nvim`.

```lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
```

options of `lazy.nvim`. lazy default. Disable some default plugins.

```lua

local opts = {
  defaults = { lazy = true },
  profiling = { loader = true, require = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

```

Manage plugins in folder [lua/lazy-plugins](/lua/lazy-plugins).

```lua

require("lazy").setup("lazy-plugins", opts)
```
