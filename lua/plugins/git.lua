local lazygit={
  "kdheepak/lazygit.nvim",
  cmd= "LazyGit",
  keys = {
    -- { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config=function()
-- let g:lazygit_floating_window_winblend = 0 " transparency of floating window
vim.g.lazygit_floating_window_winblend = 20
vim.g.lazygit_floating_window_scaling_factor = 0.8
vim.g.lazygit_floating_window_use_plenary = 1
  end,
}

local gutter={
    "airblade/vim-gitgutter",
    -- enable=false,
    keys = {
      { "<leader>hf" , "<cmd>GitGutterFold<cr>"      , desc ="GitFold"          } ,
      { "<leader>hj" , "<cmd>GitGutterNextHunk<cr>"  , desc = "NextHunk"        } ,
      { "<leader>hk" , "<cmd>GitGutterPrevHunk<cr>"      , desc = "PrevHunk"        } ,
      { "<leader>hd" , "<cmd>GitGutterDiffOrig<cr>"  , desc = "GitDiffOrig"     } ,
      { "<leader>hu" , "<cmd>GitGutterUndoHunk<cr>"  , desc = "UndoHunk"        } ,
      { "<leader>ha" , "<cmd>GitGutterStageHunk<cr>" , desc = "StageHunk"       } ,
      { "<leader>hh" , "<cmd>GitGutterToggle<cr><cmd>GitGutterLineNrHighlightsToggle<cr>"    , desc = "GitGutter Sign Toggle" } ,
      { "<leader>hl" , "<cmd>GitGutterLineHighlightsToggle<cr>"    , desc = "GitGutter highlight line Toggle" } ,
      { "<leader>hp" , "<cmd>GitGutterPreviewHunk<cr>"    , desc = "Preview a Hunk" } ,
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
    -- { "<leader>hj" , "<cmd>Gitsigns next_hunk <cr>"  , desc = "NextHunk"        } ,
    -- { "<leader>hk" , "<cmd>Gitsigns prev_hunk<cr>"      , desc = "PrevHunk"        } ,
    -- { "<leader>hd" , "<cmd>Gitsigns diffthis<cr>"  , desc = "GitDiff"     } ,
    -- { "<leader>hu" , "<cmd>Gitsigns reset_hunk<cr>"  , desc = "UndoHunk"        } ,
    -- { "<leader>ha" , "<cmd>Gitsigns stage_hunk<cr>" , desc = "Stage Hunk"       } ,
    -- { "<leader>hA" , "<cmd>Gitsigns undo_stage_hunk<cr>" , desc = "Undo Stage Hunk"       } ,
    -- { "<leader>hh" , "<cmd>Gitsigns toggle_numhl<cr><cmd>Gitsigns toggle_signs<cr>"    , desc = "Toggle GitGutter Sign " } ,
    -- { "<leader>hl" , "<cmd>Gitsigns toggle_linehl<cr>"    , desc = "Toggle GitGutter Line " } ,
    -- { "<leader>hp" , "<cmd>Gitsigns preview_hunk<cr>"    , desc = "Preview a Hunk" } ,
    { "<leader>hb" , "<cmd>Gitsigns toggle_current_line_blame<cr>"    , desc = "Toggle Blame Inline" } ,
    { "<leader>hw" , "<cmd>Gitsigns toggle_word_diff<cr>"    , desc = "Toggle Word Diff" } ,
    -- { "<leader>hh" , "<cmd>Gitsigns get_hunks<cr>"    , desc = "get hunk list" } ,
    -- { "<leader>gm", "<cmd>GitMessenger<cr>", desc = "GitMessenger" },
  },
  config=function()
    require('gitsigns').setup {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
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
  end,
}

local confict={
  -- lazy=false,
  'akinsho/git-conflict.nvim',
  version = "*",
  config =function()
    require('git-conflict').setup({
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      highlights = { -- They must have background color, otherwise the default color will be used
      incoming = 'DiffText',
      current = 'DiffAdd',
    }
  })
end,
}


local spec={
  lazygit,
  gitsigns,
  confict,
  gutter,
}

return spec
