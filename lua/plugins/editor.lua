local tex = {
  "lervag/vimtex",
  ft= {"bib","tex"},
  config = function ()
    -- vim.g.vimtex_view_general_viewer = 'sioyek'
    vim.g.vimtex_view_method = 'sioyek'
    vim.g.vimtex_view_general_options = ''
    vim.g.tex_comment_nospell = 1
    vim.g.vimtex_fold_enabled = 1
    -- g:vimtex_mappings_prefix
    vim.g.vimtex_quickfix_enabled = 0
    vim.g.vimtex_toc_config = {
      name        =  'TOC',
      layers      =  {'label', 'todo', 'include'},
      split_width =  30,
      todo_sorted =  1,
      show_help   =  1,
      show_numbers=  2,
    }
    vim.g.vimtex_quickfix_ignore_filters = {
      'Underfull \\\\hbox',
      'Overfull \\\\hbox',
      'LaTeX Warning:  float specifier changed to',
      'LaTeX Warning: The counter will not be printed',
      'LaTeX Warning: Marginpair on page ',
      'LaTeX Font Warning: Font shape ',
      'LaTeX hooks Warning',
      'Package siunitx Warning: Detected the "physics" package:',
      'Package hyperref Warning: Token not allowed in a PDF string',
    }
  end,
}


local md = {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  ft = { "markdown" },
  config=function()
-- if  vim.g.islinux then
    -- vim.g.mkdp_browser = 'surf'
-- end
    vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. '/colors/markdown.css'
    vim.g.mkdp_theme = 'dark'
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_page_title = '「${name}」'
    vim.g.mkdp_filetypes = {'markdown','md'}
  end,
}


local mkdnflow={
  'jakewvincent/mkdnflow.nvim',
  cmd={"Mkdnflow"},
  -- lazy=false,
  config=function()
    require('mkdnflow').setup({
      modules = {
        bib = true,
        buffers = true,
        conceal = true,
        cursor = true,
        folds = true,
        links = true,
        lists = true,
        maps = true,
        paths = true,
        tables = true,
        yaml = false
      },
      -- filetypes = {md = true, rmd = true, markdown = true},
      create_dirs = true,             
      perspective = {
        priority = 'first',
        fallback = 'current',
        root_tell = false,
        nvim_wd_heel = false,
        update = true
      },    
      wrap = false,
      bib = {
        default_path = nil,
        find_in_root = true
      },
      silent = false,
      links = {
        style = 'markdown',
        conceal = false,
        context = 0,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
          text = text:gsub(" ", "-")
          text = text:lower()
          text = os.date('%Y-%m-%d_')..text
          return(text)
        end
      },
      to_do = {
        symbols = {' ', '-', 'X'},
        update_parents = true,
        not_started = ' ',
        in_progress = '-',
        complete = 'X'
      },
      tables = {
        trim_whitespace = true,
        format_on_move = true,
        auto_extend_rows = false,
        auto_extend_cols = false
      },
      yaml = {
        bib = { override = false }
      },
      mappings = {
        -- MkdnEnter = {{'n', 'v', 'i'}, '<CR>'},
        MkdnEnter = {'n', '<CR>'},
        MkdnTab = true,
        MkdnSTab = true,
        MkdnNextLink = {'n', '<Tab>'},
        MkdnPrevLink = {'n', '<S-Tab>'},
        MkdnNextHeading = {'n', ']]'},
        MkdnPrevHeading = {'n', '[['},
        MkdnGoBack = {'n', '<BS>'},
        MkdnGoForward = {'n', '<Del>'},
        MkdnFollowLink = false, -- see MkdnEnter
        MkdnCreateLink = false, -- see MkdnEnter
        MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader>p'}, -- see MkdnEnter
        MkdnDestroyLink = {'n', '<leader><CR>'},
        MkdnMoveSource = {'n', '<F2>'},
        MkdnYankAnchorLink = {'n', 'ya'},
        MkdnYankFileAnchorLink = {'n', 'yfa'},
        MkdnIncreaseHeading = {'n', '+'},
        MkdnDecreaseHeading = {'n', '-'},
        MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = {'n', 'o'},
        MkdnNewListItemAboveInsert = {'n', 'O'},
        MkdnExtendList = false,
        MkdnUpdateNumbering = {'n', '<leader>nn'},
        MkdnTableNextCell = {'i', '<Tab>'},
        MkdnTablePrevCell = {'i', '<S-Tab>'},
        MkdnTableNextRow = false,
        MkdnTablePrevRow = {'i', '<M-CR>'},
        MkdnTableNewRowBelow = {'n', '<leader>ir'},
        MkdnTableNewRowAbove = {'n', '<leader>iR'},
        MkdnTableNewColAfter = {'n', '<leader>ic'},
        MkdnTableNewColBefore = {'n', '<leader>iC'},
        MkdnFoldSection = {'n', '<leader>f'},
        MkdnUnfoldSection = {'n', '<leader>F'}
      }
    })
  end,
}

local obsidian ={
  "epwalsh/obsidian.nvim",
  -- lazy=false,
  event = { "BufRead " .. vim.fn.expand "~" .. "/obsidian/**.md" },
  keys ={

    { "<leader>oo" , "<cmd>ObsidianOpen<cr>" , desc = "Open Obsidian" } ,
    { "<leader>os" , "<cmd>ObsidianSearch<cr>" , desc = "Search in Obsidian" } ,
    { "<leader>ot" , "<cmd>ObsidianTemplate<cr>" , desc = "Templates in Obsidian" } ,
    { "<leader>ob" , "<cmd>ObsidianBacklink<cr>" , desc = "Backlink" } ,
    { "<leader>ol" , "<cmd>ObsidianFollowLink<cr>" , desc = "Follow link" } ,
  },
  cmd = {
    "ObsidianOpen",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = "~/obsidian/",  -- no need to call 'vim.fn.expand' here
    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = "notes",
    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
    },
    -- Optional, completion.
    completion = {
      -- If using nvim-cmp, otherwise set to false
      nvim_cmp = true,
      -- Trigger completion at 2 chars
      min_chars = 2,
      new_notes_location = "current_dir"
    },
    -- Optional, set to true if you don't want Obsidian to manage frontmatter.
    disable_frontmatter = true,
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    open_app_foreground = true,
    finder = "telescope.nvim",
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    -- see also: 'follow_url_func' config option above.
  end,
}

local spec={
  -- tex,
  md,
  obsidian,
  -- knapnvim,
  -- mkdnflow,
}

return spec
