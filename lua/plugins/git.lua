local lazygit={
  "kdheepak/lazygit.nvim",
  cmd= "LazyGit",
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "lazygit" },
  },
  config=function()
    vim.g.lazygit_floating_window_winblend = 80  -- transparency of floating window
    vim.g.lazygit_floating_window_scaling_factor = 0.8
    vim.g.lazygit_floating_window_use_plenary = 1
  end,
}

local gutter={
  "airblade/vim-gitgutter",
  -- enable=false,
  keys = {
    { "<leader>hf" , "<cmd>GitGutterFold<cr>"      , desc ="gitfold"          } ,
    { "<leader>hj" , "<cmd>GitGutterNextHunk<cr>"  , desc = "next hunk"       } ,
    { "<leader>hk" , "<cmd>GitGutterPrevHunk<cr>"  , desc = "previous hunk"   } ,
    { "<leader>hd" , "<cmd>GitGutterDiffOrig<cr>"  , desc = "gitdifforig"     } ,
    { "<leader>hu" , "<cmd>GitGutterUndoHunk<cr>"  , desc = "undohunk"        } ,
    { "<leader>ha" , "<cmd>GitGutterStageHunk<cr>" , desc = "stagehunk"       } ,
    { "<leader>hh" , "<cmd>GitGutterToggle<cr><cmd>GitGutterLineNrHighlightsToggle<cr>"    , desc = "gitgutter sign toggle" } ,
    { "<leader>hl" , "<cmd>GitGutterLineHighlightsToggle<cr>"    , desc = "gitgutter highlight line toggle" } ,
    { "<leader>hp" , "<cmd>GitGutterPreviewHunk<cr>"    , desc = "preview a hunk" } ,
  },
  config=function()
    vim.g.gitgutter_highlight_linenrs=1
    vim.g.gitgutter_signs=1
    vim.g.gitgutter_close_preview_on_escape=1
  end,
}

local gitsigns ={
  'lewis6991/gitsigns.nvim',
  keys = {
    { "<leader>hj" , "<cmd>Gitsigns next_hunk <cr>"  , desc = "nexthunk"        } ,
    { "<leader>hk" , "<cmd>Gitsigns prev_hunk<cr>"      , desc = "prevhunk"        } ,
    { "<leader>hD" , "<cmd>Gitsigns diffthis<cr>"  , desc = "gitdiff"     } ,
    { "<leader>hd" , "<cmd>Gitsigns toggle_deleted<cr>"  , desc = "toggle deleted"     } ,
    { "<leader>hu" , "<cmd>Gitsigns reset_hunk<cr>"  , desc = "undohunk"        } ,
    { "<leader>ha" , "<cmd>Gitsigns stage_hunk<cr>" , desc = "stage hunk"       } ,
    { "<leader>hA" , "<cmd>Gitsigns undo_stage_hunk<cr>" , desc = "undo stage hunk"       } ,
    { "<leader>hh" , "<cmd>Gitsigns toggle_numhl<cr><cmd>Gitsigns toggle_signs<cr>"    , desc = "toggle gitgutter sign " } ,
    { "<leader>hl" , "<cmd>Gitsigns toggle_linehl<cr>"    , desc = "toggle gitgutter line " } ,
    { "<leader>hP" , "<cmd>Gitsigns preview_hunk<cr>"    , desc = "preview a hunk" } ,
    { "<leader>hp" , "<cmd>Gitsigns preview_hunk_inline<cr>"    , desc = "preview a hunk" } ,
    { "<leader>hb" , "<cmd>Gitsigns toggle_current_line_blame<cr>"    , desc = "toggle blame inline" } ,
    { "<leader>hw" , "<cmd>Gitsigns toggle_word_diff<cr>"    , desc = "toggle word diff" } ,
    -- { "<leader>hh" , "<cmd>Gitsigns get_hunks<cr>"    , desc = "get hunk list" } ,
  },
  dependencies = { "akinsho/git-conflict.nvim" },
  config=function()
    require('gitsigns').setup {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = false,  -- toggle with `:gitsigns toggle_signs`
      numhl      = false, -- toggle with `:gitsigns toggle_numhl`
      linehl     = false, -- toggle with `:gitsigns toggle_linehl`
      word_diff  = false, -- toggle with `:gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false, -- toggle with `:gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- use default
      max_file_length = 40000, -- disable if file is longer than this (in lines)
      preview_config = {
        -- options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm = {
        enable = false
      },
    }
    require("scrollbar.handlers.gitsigns").setup()
  end,
}

local confict={
  -- lazy=false,
  -- todo: lazyload, and keybings
  'akinsho/git-conflict.nvim',
  version = "*",
  config =function()
    require('git-conflict').setup({
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- this will disable the diagnostics in a buffer whilst it is conflicted
      highlights = { -- they must have background color, otherwise the default color will be used
      incoming = 'difftext',
      current = 'diffadd',
    }
  })
end,
}


local spec={
  lazygit,
  gitsigns,
  confict,
  -- gutter,
}
-- todo:gutter or gitsings?
return spec
