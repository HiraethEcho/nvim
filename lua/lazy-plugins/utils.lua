return {
  { "folke/lazy.nvim", version = "*" },
  { -- "MagicDuck/grug-far.nvim",
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
    opts = {},
  },
  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
  { -- "y3owk1n/cmd.nvim",
    "y3owk1n/cmd.nvim",
    cmd = { "Cmd" },
    opts = {
      progress_notifier = {
        -- adapter = require("cmd.nvim").builtins.spinner_adapters.mini,
        -- adapter = require("cmd").builtins.spinner_adapters.fidget,
      },
    },
  },
  { -- "folke/which-key.nvim",
    "folke/which-key.nvim",
    -- cmd = "WhichKey",
    keys = {
      {
        "?",
        function()
          require("which-key").show()
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    event = "BufRead",
    opts = {
      preset = "helix", -- classic, helix, modern
      -- layout = { align = "center" },
      defaults = {},
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        -- { "<leader>i", group = "list" },
        { "<leader>D", group = "Diff" },
        { "<leader>u", group = "toggle" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>m", group = "markdown" },
        { "<leader>h", group = "hunk" },
        { "<leader>c", group = "copilot" },
        { "<leader>s", group = "search" },
        { "<leader>S", group = "Session" },
        { "<localleader>a", group = "Avante" },
        { "<localleader>c", group = "CodeCompanion" },
        { "<localleader>C", group = "copilot Chat" },
        { "<localleader>o", group = "OpenCode" },
        -- { "<leader>x", group = "troube" },
        -- { "m", group = "bookmark", },
      })
    end,
  },
  { -- "markgandolfo/lightswitch.nvim",
    "markgandolfo/lightswitch.nvim",
    cmd = { "LightSwitchShow" },
    keys = { { "<leader>uu", ":LightSwitchShow<CR>" } },
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      toggles = {
        {
          name = "readonly",
          enable_cmd = "setl ma! ma?",
          disable_cmd = "setl ma! ma?",
        },
        {
          name = "colorcolumn",
          enable_cmd = "set cc=80",
          disable_cmd = "set cc=0",
          state = false, -- Initially enabled
        },
        {
          name = "color",
          enable_cmd = "ColorizerAttachToBuffer",
          disable_cmd = "ColorizerAttachToBuffer",
          state = false, -- Initially enabled
        },
        {
          name = "Copilot",
          enable_cmd = "Copilot enable",
          disable_cmd = "Copilot disable",
          state = true, -- Initially enabled
        },
        {
          name = "LSP",
          enable_cmd = ":Lspstart<CR>",
          disable_cmd = ":Lspstop<CR>",
          state = true, -- Initially disabled
        },
        {
          name = "Diagnostics",
          enable_cmd = "lua vim.diagnostic.enable()",
          disable_cmd = "lua vim.diagnostic.disable()",
          state = true,
        },
      },
    },
  },
  { -- "ingur/floatty.nvim",
    "ingur/floatty.nvim",
    -- event = "VeryLazy",
    config = function()
      -- initialize config
      local term = require("floatty").setup({
        window = {
          row = function()
            return vim.o.lines - 11
          end,
          width = 1.0,
          height = 8,
        },
      })
      -- stylua: ignore start
      vim.keymap.set("n", "<C-t>", function() term.toggle() end)
      vim.keymap.set("t", "<C-t>", function() term.toggle() end)
      -- sytlua: ignore stop
    end,
  },
  -- disable
  { -- "kevinhwang91/nvim-ufo",
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
  { -- "nvim-pack/nvim-spectre",
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
  { "echasnovski/mini.test", enabled = false, version = "*" },
  {
    "Zeioth/hot-reload.nvim",
    enabled = false,
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufEnter",
    opts = {},
  },
  { -- "stevearc/quicker.nvim",
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
}
