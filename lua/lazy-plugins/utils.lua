return {
  {
    "folke/lazy.nvim",
    version = "*",
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<C-f>",
        function()
          require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
        end,
        desc = "search and replace",
      },
    },
    config = function()
      require("grug-far").setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      })
    end,
  },
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },
  {
    "gelguy/wilder.nvim",
    -- enabled = false,
    event = "CmdlineEnter",
    -- event = "CmdlineEnter",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/" } })
      -- wilder.setup({ modes = { "/" } })
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            set_pcre2_pattern = 1,
          }),
          wilder.python_search_pipeline({
            pattern = "fuzzy",
          })
        ),
      })
      local popupmenu_palette = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        border = "rounded",
        max_height = "75%", -- max height of the palette
        min_height = 0, -- set to the same as 'max_height' for a fixed height window
        prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
        pumblend = 20,
        reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        winblend = 30,
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      }))
      local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        border = "rounded",
        pumblend = 20,
        winblend = 30,
        -- highlighter = highlighters,
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      }))
      local wildmenu_renderer = wilder.wildmenu_renderer({
        separator = " · ",
        left = { " ", wilder.wildmenu_spinner(), " " },
        right = { " ", wilder.wildmenu_index() },
      })
      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = popupmenu_palette,
          -- [':'] =popupmenu_renderer,
          ["/"] = wildmenu_renderer,
          substitute = wildmenu_renderer,
        })
      )
    end,
  },
  {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    keys = {
      {
        "?",
        function()
          require("which-key").show()
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    event = "BufRead",
    opts = {
      preset = "classic",
      layout = {
        align = "center", -- align columns left, center or right
      },
    },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      wk.add({
        { "<leader>i", group = "list" },
        { "<leader>D", group = "Diff" },
        { "<leader>u", group = "ui" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>m", group = "markdown" },
        { "<leader>h", group = "hunk" },
        { "<leader>c", group = "copilot" },
        { "<leader>s", group = "search" },
        { "<leader>S", group = "Session" },
        { "<leader>x", group = "trouble" },
        -- { "m", group = "bookmark", },
      })
    end,
  },
  -- disable
  {
    "kevinhwang91/nvim-ufo",
    -- event = "LspAttach",
    event = "BufRead",
    enabled = false,
    dependencies = {
      "kevinhwang91/promise-async",
    },
    keys = {
      -- { "zR", function() require('ufo').openAllFolds() end,               desc = "Open All Folds" },
      -- { "zM", function() require('ufo').closeAllFolds() end,              desc = "Close All Folds" },
      -- { "zr", function() require('ufo').openFoldsExceptKinds() end,       desc = "Open Folds Except Kinds" },
      -- { "zm", function() require('ufo').closeFoldsWith() end,             desc = "Close Folds With" },
      {
        "KK",
        function()
          require("ufo").peekFoldedLinesUnderCursor()
        end,
        desc = "Peek Folded Lines Under Cursor",
      },
    },
    config = function()
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        preview = {
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            jumpTop = "[",
            jumpBot = "]",
          },
        },
      })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    enabled = false,
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<C-f>",      function() require("spectre").open_file_search() end,                       desc = "toggle spectre" },
      { "<leader>sW", function() require("spectre").open_file_search({ select_word = true }) end, mode = { "x", "v" },    desc = "search word on current file" },
    },
  },
  {
    "echasnovski/mini.test",
    enabled = false,
    version = "*",
  },
  {
    "Zeioth/hot-reload.nvim",
    enabled = false,
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufEnter",
    opts = {},
  },
  {
    "stevearc/quicker.nvim",
    enabled = false,
    lazy = false,
    event = "FileType qf",
    keys = {
      {
        "<leader>x",
        function()
          require("quicker").toggle()
        end,
        desc = "toggle quicker",
      },
    },
    opts = {},
  },
  {
    "rhysd/nyaovim-mini-browser",
    enabled = false,
    event = "CmdlineEnter",
    -- keys = {
    --   { "<leader>B", "<cmd>StartMarkdownPreview<cr>", desc = "markdown Html Preview" },
    -- },
  },
}
