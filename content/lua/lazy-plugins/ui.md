---
title: ui
---

# ui

ui other lines and colorscheme

```lua
vim.g.loaded_matchparen = 1 -- "utilyre/sentiment.nvim",
return {
  { -- "j-hui/fidget.nvim",
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        filter = vim.log.levels.TRACE,
        override_vim_notify = true,
        window = { border = "none", align = "top", tabstop = 2 },
      },
    },
  },
  { -- "catgoose/nvim-colorizer.lua",
    "catgoose/nvim-colorizer.lua",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
    opts = { -- set to setup table
      user_default_options = {
        names = true,
        RGB = true, -- #RGB hex codes
        RGBA = true, -- #RGBA hex codes
        RRGGBB = true, -- #RRGGBB hex codes #ffffff
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS *features*:
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        tailwind = true, -- Enable tailwind colors
        xterm = true, -- Enable xterm 256-color codes (#xNN, \e[38;5;NNNm)
        -- Highlighting mode.  'background'|'foreground'|'virtualtext'
        mode = "background", -- Set the display mode
        virtualtext = "■",
        -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
        virtualtext_inline = true,
        virtualtext_mode = "foreground",
        always_update = true,
      },
    },
  },
  { "nvzone/volt", lazy = true },
  { "nvzone/minty", cmd = { "Shades", "Huefy" } },
  { -- "utilyre/sentiment.nvim",
    "utilyre/sentiment.nvim",
    enabled = false,
    version = "*",
    event = "InsertEnter",
    opts = {
      pairs = {
        { "(", ")" },
        { "{", "}" },
        { "[", "]" },
      },
    },
  },
  { "OXY2DEV/helpview.nvim", ft = "help", dependencies = { "nvim-treesitter/nvim-treesitter" } },
}
```
