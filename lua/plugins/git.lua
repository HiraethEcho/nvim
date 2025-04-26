return {
  {
    "lewis6991/gitsigns.nvim",
    -- enabled = false,
    keys = {
      -- { "<leader>hj", "<cmd>Gitsigns next_hunk<cr>",                                  desc = "nexthunk" },
      -- { "<leader>hk", "<cmd>Gitsigns prev_hunk<cr>",                                  desc = "prevhunk" },
      { "]h",         "<cmd>Gitsigns next_hunk<cr>",                                  desc = "nexthunk" },
      { "[h",         "<cmd>Gitsigns prev_hunk<cr>",                                  desc = "prevhunk" },
      { "<leader>hD", "<cmd>Gitsigns diffthis<cr>",                                   desc = "gitdiff" },
      { "<leader>hd", "<cmd>Gitsigns toggle_deleted<cr>",                             desc = "toggle deleted" },
      { "<leader>hu", "<cmd>Gitsigns reset_hunk<cr>",                                 desc = "undohunk" },
      { "<leader>ha", "<cmd>Gitsigns stage_hunk<cr>",                                 desc = "stage hunk" },
      { "<leader>hA", "<cmd>Gitsigns undo_stage_hunk<cr>",                            desc = "undo stage hunk" },
      { "<leader>hh", "<cmd>Gitsigns toggle_numhl<cr><cmd>Gitsigns toggle_signs<cr>", desc = "toggle gitgutter sign ", },
      -- { "<leader>hh", "<cmd>Gitsigns toggle_numhl<cr><cmd>Gitsigns toggle_signs<cr>", desc = "toggle gitgutter sign ", },
      { "<leader>hl", "<cmd>Gitsigns toggle_linehl<cr>",                              desc = "toggle gitgutter line " },
      { "<leader>hP", "<cmd>Gitsigns preview_hunk<cr>",                               desc = "preview a hunk" },
      -- { "<leader>hp", "<cmd>Gitsigns preview_hunk_inline<cr>",       desc = "preview a hunk" },
      -- { "<leader>hb", "<cmd>Gitsigns toggle_current_line_blame<cr>",                  desc = "toggle blame inline" },
      { "<leader>gb", "<cmd>Gitsigns blame<cr>",                                      desc = "toggle blame inline" },
      { "<leader>hw", "<cmd>Gitsigns toggle_word_diff<cr>",                           desc = "toggle word diff" },
      -- { "<leader>hh" , "<cmd>Gitsigns get_hunks<cr>"    , desc = "get hunk list" } ,
    },
    -- dependencies = { "akinsho/git-conflict.nvim" },
    config = function()
      require("gitsigns").setup({
        signcolumn = false, -- toggle with `:gitsigns toggle_signs`
        numhl = false,      -- toggle with `:gitsigns toggle_numhl`
        linehl = false,     -- toggle with `:gitsigns toggle_linehl`
        word_diff = false,  -- toggle with `:gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- toggle with `:gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "overlay", -- 'eol' | 'overlay' | 'right_align'
          delay = 200,
          ignore_whitespace = true,
        },
        current_line_blame_formatter = "<summary>, <author_time:%y-%m-%d>",
      })
      -- require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    "Yu-Leo/blame-column.nvim",
    enabled = false,
    opts = {}, -- for default options. Refer to the configuration section for custom setup.
    keys = {
      { "<leader>hb", "<cmd>BlameColumnToggle<cr>", desc = "toggle blame inline" },
    },
    cmd = "BlameColumnToggle",
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    enabled = false,
    config = function()
      require("git-conflict").setup({
        default_mappings = true,     -- disable buffer local mapping created by this plugin
        default_commands = true,     -- disable commands created by this plugin
        disable_diagnostics = false, -- this will disable the diagnostics in a buffer whilst it is conflicted
        highlights = {               -- they must have background color, otherwise the default color will be used
          incoming = "difftext",
          current = "diffadd",
        },
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>DD", "<cmd>DiffviewOpen<cr>",        desc = "Diff View" },
      { "<leader>DH", "<cmd>DiffviewFileHistory<cr>", desc = "Diff View File History" },
      { "<leader>DC", "<cmd>DiffviewClose<cr>",       desc = "Diff close" },
    },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        hooks = {}, -- See ':h diffview-config-hooks'
        keymaps = {
          file_panel = {
            { "n", "<c-u>", actions.scroll_view(-0.25), { desc = "Scroll the view up" }, },
            { "n", "<c-d>", actions.scroll_view(0.25),  { desc = "Scroll the view down" }, },
          },
          file_history_panel = {
            { "n", "<c-u>", actions.scroll_view(-0.25),         { desc = "Scroll the view up" } },
            { "n", "<c-d>", actions.scroll_view(0.25),          { desc = "Scroll the view down" }, },
            { "n", "g?",    actions.help("file_history_panel"), { desc = "Open the help panel" } },
          },
          option_panel = {
            { "n", "<tab>", actions.select_entry,         { desc = "Change the current option" } },
            { "n", "q",     actions.close,                { desc = "Close the panel" } },
            { "n", "g?",    actions.help("option_panel"), { desc = "Open the help panel" } },
          },
          help_panel = {
            { "n", "q",     actions.close, { desc = "Close help menu" } },
            { "n", "<esc>", actions.close, { desc = "Close help menu" } },
          },
        },
      })
    end,
  },
  {
    'fredeeb/tardis.nvim',
    cmd = "Tardis",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
  },
}
