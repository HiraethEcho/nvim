vim.g.loaded_matchparen = 1 -- "utilyre/sentiment.nvim",
return {
  { -- "j-hui/fidget.nvim",
    "j-hui/fidget.nvim",
    -- enabled = false,
    event = "LspAttach",
    opts = {
      notification = {
        filter = vim.log.levels.TRACE,
        override_vim_notify = true,
        window = { border = "none", align = "top", tabstop = 2 },
      },
    },
  },
  { -- "y3owk1n/notifier.nvim",
    "y3owk1n/notifier.nvim",
    enabled = false,
    config = function()
      require("notifier").setup({
        -- your configuration here
      })
    end,
  },
  { -- "echasnovski/mini.notify",
    "echasnovski/mini.notify",
    opts = {},
    enabled = false,
    event = "LspAttach",
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
  { "brenoprata10/nvim-highlight-colors", enabled = false, opts = { enable_ansi = true } },
  -- { "norcalli/nvim-colorizer.lua", cmd = "ColorizerToggle", opts = true },
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
  -- disable
  { -- "rcarriga/nvim-notify",
    "rcarriga/nvim-notify",
    event = "BufReadPost",
    enabled = false,
    config = function()
      require("notify").setup({
        fps = 60,
        level = 2,
        render = "default",
        stages = "slide",
        timeout = 2000,
      })
      vim.notify = require("notify")
    end,
  },
  { "edluffy/hologram.nvim", enabled = false },
  { "gen740/SmoothCursor.nvim", enabled = false, opts = { type = "default" } },
  { "stevearc/dressing.nvim", enabled = false, event = "BufReadPost", opts = true },
  { "xiyaowong/nvim-transparent", enabled = false, cmd = "TransparentEnable", opts = true },
}
