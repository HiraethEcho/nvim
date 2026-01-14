---
title: readme
---

This my [neovim](https://neovim.io) config, by a zola theme named [neovim](https://github.com/Super-Botman/neovim-theme). Totally make sense.  
And [here](https://github.com/hiraethecho/nvim) is my config repo on github. This site is maintained in `docs` branch.

The root `/` means `~/.config/nvim/` in this docs. Roughly, nvim load configs in following order.

- usually [/init.lua](/init) is the entrance of nvim config. In this, `require('file')` loads `/lua/file.lua`. `require('dir')` loads `/lua/dir/init.lua`, and `require('dir.file')` loads `/lua/dir/file.lua`
- [/plugin](/plugin) is automatically loaded.
- [/ftplugin](/ftplugin) is automatically loaded for corresponding file type. For example [/ftplugin/lua.lua](/ftplugin/lua) is loaded for all `lua` files
- [/after](/after) is loaded after others.

The following are loaded only by certain methods.

- [/lsp](/lsp) is for lsp. For example, `vim.lsp.enable('lua')` loads [/lsp/lua.lua](/lsp/lua)
- [/LuaSnip](/LuaSnip) and [/snipmate](/snipmate) are for plugin LuaSnip. See [/lua/lazy-plugins/cmp.lua](/lua/lazy-plugins/cmp).

There are two other files under `/`, for formatting the config.

For `lua-language-server`, need `/.luarc.json`

```json
{
  "workspace.checkThirdParty": false,
  "diagnostics.disable": ["undefined-global", "unused-local", "deprecated"]
}
```

and for style checking, need `/.stylua.toml`

```toml
syntax = "All"
column_width = 120
line_endings = "Unix"
indent_type = "Spaces"
indent_width = 2
quote_style = "AutoPreferDouble"
call_parentheses = "Always"
collapse_simple_statement = "Never"
space_after_function_names = "Never"

[sort_requires]
enabled = false
```
