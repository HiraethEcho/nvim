vim.g.loaded_matchparen = 1 -- "utilyre/sentiment.nvim",
return {
  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("colorizer").setup()
    end,
  },
  { "nvzone/volt", lazy = true },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
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
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- disable
  {
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
