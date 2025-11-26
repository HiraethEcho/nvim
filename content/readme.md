---
title: readme
---

This my nvim config, by a zola theme [neovim](https://github.com/Super-Botman/neovim-theme). Totally make sense.

usually [~/.config/nvim/init.lua](/init) is the entrance of nvim config.

There is another file under `nvim/`, for formatting the config.

For `lua-language-server`, need `.luarc.json`

```json
{
  "workspace.checkThirdParty": false,
  "diagnostics.disable": ["undefined-global", "unused-local", "deprecated"]
}
```

and for style checking, need `.stylua.toml`

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
