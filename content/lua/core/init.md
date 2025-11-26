---
title: init
---

this init file load some other lua files. 

```lua
require("core.options")
require("core.keymaps")
require("core.lazy-bootstrap")
```

This load three files

[options](/lua/core/options) - this file set neovim options

[keymaps](/lua/core/keymaps) - this file set neovim keymaps

[lazy-bootstrap](/lua/core/lazy-bootstrap) - this file bootstrap lazy.nvim plugin managerk
