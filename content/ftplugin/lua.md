---
title: lua
---

lua file here is loaded automatically for corresponding filetype.

for example this a file `/ftplugin/lua.lua` will be loaded when a lua file is opened.

I use this file to enable lsp. Files in [/lsp](/lsp) can be loaded by `vim.lsp.enable`. For example,

```lua
vim.lsp.enable('lua')
```

This loads lsp for lua configured in [/lsp/lua.lua](/lsp/lua)
