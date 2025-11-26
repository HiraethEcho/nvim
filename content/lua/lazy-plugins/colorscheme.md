---
title: colorscheme
---

Just some plugins for colorschemes.

Configure some options before return plugin spec.

```lua
vim.o.background = "dark"
vim.cmd.colorscheme("wildcharm") -- a native colorscheme
```

Then plugins

```lua
return {
  {
    "ricardoraposo/nightwolf.nvim",
    opts = {
      theme = "dark-gray", -- 'black', 'dark-blue', 'gray', 'dark-gray', 'light'
      italic = true,
    },
  },
  {
    "jpwol/thorn.nvim",
    opts = {
      background = "cold", -- options are 'warm' and 'cold'
      styles = {
        keywords = { italics = true, bold = true },
        comments = { italics = true, bold = false },
        strings = { italics = true, bold = false },
        diagnostic = {
          -- true will apply the bg highlight, false applies the fg highlight
          error = { highlight = true },
          hint = { highlight = false },
          info = { highlight = false },
          warn = { highlight = false },
        },
      },
      transparent = true, -- transparent background
    },
  },
  {
    "anttikivi/lucid.nvim",
    -- lazy = false,
    config = function()
      vim.cmd.colorscheme("lucid")
    end,
  },
  {
    "mcauley-penney/techbase.nvim",
    opts = { italic_comments = true, transparent = true },
  },
  {
    "V4N1LLA-1CE/xcodedark.nvim",
    opts = {
      transparent = true,
      integrations = {
        telescope = true,
        nvim_tree = true,
        gitsigns = true,
        bufferline = true,
        incline = true,
        lazygit = true,
        which_key = true,
        notify = true,
      },
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    -- enabled = false,
    -- event = "VimEnter",
    -- cmd = "colorscheme",
    config = function()
      local palette = require("nordic.colors")
      require("nordic").setup({
        -- This callback can be used to override the colors used in the palette.
        on_palette = function(palette)
          return palette
        end,
        -- Enable bold keywords.
        bold_keywords = true,
        -- Enable italic comments.
        bright_border = true,
        -- Reduce the overall amount of blue in the theme (diverges from base Nord).
        reduced_blue = false,
        -- Override the styling of any highlight group.
        override = {
          TelescopePromptTitle = {
            fg = palette.red.bright,
            bg = palette.green.base,
            italic = true,
            underline = true,
            sp = palette.yellow.dim,
            undercurl = false,
          },
        },
        -- Cursorline options.  Also includes visual/selection.
        cursorline = {
          -- Bold font in cursorline.
          bold = true,
          -- Bold cursorline number.
          bold_number = true,
          -- Available styles: 'dark', 'light'.
          theme = "dark",
          -- Blending the cursorline bg with the buffer bg.
          blend = 0.85,
        },
        noice = {
          -- Available styles: `classic`, `flat`.
          style = "fat",
        },
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = "classic",
        },
      })
      -- vim.cmd.colorscheme 'nordic'
    end,
  },
  {
    "rose-pine/neovim",
    -- enabled = false,
    -- name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "dawn", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = true,
        extend_background_behind_borders = true,
        enable = {
          terminal = false,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },
        styles = {
          bold = true,
          italic = true,
        },
      })
      -- vim.cmd("colorscheme rose-pine")
      -- vim.cmd("colorscheme rose-pine-main")
      -- vim.cmd("colorscheme rose-pine-moon")
      -- vim.cmd("colorscheme rose-pine-dawn")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    opts = {
      options = {
        styles = { -- Style to be applied to different syntax groups
          functions = "italic,bold",
          variables = "bold",
          constants = "bold",
          numbers = "italic",
          operators = "NONE",
          strings = "italic",
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
  },
  {
    "neanias/everforest-nvim",
    -- enabled = false,
    -- lazy = false,
    -- cmd = "colorscheme",
    version = false,
    -- event = "VimEnter",
    config = function()
      require("everforest").setup({
        ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
        background = "soft",
        italics = true,
        ---By default, the colour of the sign column background is the same as the as normal text
        ---background, but you can use a grey background by setting this to `"grey"`.
        sign_column_background = "grey",
        ---The contrast of line numbers, indent lines, etc. Options are `"high"` or
        ---`"low"` (default).
        ui_contrast = "high",
        dim_inactive_windows = true,
        diagnostic_text_highlight = true,
        ---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
        diagnostic_virtual_text = "coloured",
        diagnostic_line_highlight = true,
        float_style = "bright",
      })
      -- require("everforest").load()
    end,
  },
  {
    "shaunsingh/nord.nvim",
    --Lua:
    -- event = "BufRead",
    -- event = "VimEnter",
    config = function()
      -- vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    -- event = "VimEnter",
    -- event = "BufRead",
    config = function()
      require("nightfox").setup({
        options = {
          dim_inactive = true, -- Non focused panes set to alternative background
          module_default = true, -- Default enable value for modules
          colorblind = {
            enable = true, -- Enable colorblind support
            simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
          },
          styles = { -- Style to be applied to different syntax groups
            -- bold
            -- underline
            -- undercurl  curly underline
            -- underdouble  double underline
            -- underdotted  dotted underline
            -- underdashed  dashed underline
            -- strikethrough
            -- reverse
            -- inverse    same as reverse
            -- italic
            -- standout
            -- altfont
            -- nocombine  override attributes instead of combining them
            -- NONE   no attributes used (used to reset it)
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "italic",
            constants = "bold",
            functions = "bold,italic",
            keywords = "italic",
            numbers = "italic",
            operators = "NONE",
            strings = "underdotted",
            types = "NONE",
            variables = "NONE",
          },
        },
      })
      -- setup must be called before loading
      -- vim.cmd("colorscheme nightfox")
    end,
  },
  {
    "Rics-Dev/flow",
    -- lazy = false,
    config = function()
      require("flow").setup() -- Optional: for customization
    end,
  },
  { "DonJulve/NeoCyberVim", config = true },
  { "echasnovski/mini.hues", version = false },
  { "echasnovski/mini.base16", version = false },
}
```
