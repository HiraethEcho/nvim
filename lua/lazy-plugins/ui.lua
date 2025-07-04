return {
  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "InsertEnter", -- keep for lazy loading
    opts = {
      pairs = {
        { "(", ")" },
        { "{", "}" },
        { "[", "]" },
      }, -- config
    },
  },
  -- disable
  {
    "rcarriga/nvim-notify",
    event = "BufRead",
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
  {
    "folke/noice.nvim",
    enabled = false,
    event = "BufReadPost",
    opts = {
      -- add any options here
      -- cmdline = {enabled = false,}
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "edluffy/hologram.nvim",
    enabled = false,
  },
  {
    "gen740/SmoothCursor.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("smoothcursor").setup({
        type = "default", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    enabled = false,
    event = "BufReadPost",
    opts = {},
  },
  {
    "xiyaowong/nvim-transparent",
    enabled = false,
    cmd = "TransparentEnable",
    -- lazy=false,
    config = function()
      require("transparent").setup({})
    end,
  },
}
