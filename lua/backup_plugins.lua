  local minimap={
    'echasnovski/mini.map', version = false ,
    enabled=false,
    -- lazy=false,
    config =function ()
      require('mini.map').setup({
        -- Highlight integrations (none by default)
        integrations = nil,
        symbols = {
          -- Encode symbols. See `:h MiniMap.config` for specification and
          -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
          -- Default: solid blocks with 3x2 resolution.
          -- encode = nil,
          -- Scrollbar parts for view and line. Use empty string to disable any.
          scroll_line = '█',
          scroll_view = '┃',
        },

        window = {
          -- Whether window is focusable in normal way (with `wincmd` or mouse)
          focusable = false,
          -- Whether to show count of multiple integration highlights
          show_integration_count = false,
          width = 40,
          winblend = 25,
        },
      })

      -- vim.api.nvim_create_user_command('MiniMapOpen',MiniMap.open(), { bang = true })
      -- vim.api.nvim_create_user_command('MiniMapClose', MiniMap.close(), { bang = true })
    end,
  },
local start={
  {
    "mhinz/vim-startify",
    event = "VimEnter",
    -- lazy=false,

    config=function()
      vim.g.startify_session_dir = vim.fn.stdpath("config").."/session/")
      vim.g.startify_files_number= 3
      vim.cmd([[
      let g:startify_lists= [
      \ { 'type': 'sessions'  , 'header': ['   Sessions'  ] } ,
      \ { 'type': 'files'     , 'header': ['   Recent'    ] } ,
      \ ]
      ]])
      -- let g:startify_custom_header=startify#pad(split(system('figlet -w 100 Carpe diem'), '\n'))
      -- let g:startify_custom_footer=startify#pad(split(system('figlet -w 100 Seize the day'), '\n'))
    end,
  },

  {
    "echasnovski/mini.starter",
    enabled=false,
    -- lazy=false,
    version = false, -- wait till new 0.7.0 release to put it back on semver
    -- event = "VimEnter",
    config=function()
      require('mini.starter').setup()
    end,
  },
}
local animate={
  'echasnovski/mini.animate', version = '*' ,
  event="CursorMoved",
  config=function ()
    require('mini.animate').setup({
      -- No need to copy this inside `setup()`. Will be used automatically.
      -- Cursor path
      cursor = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        -- timing = --<function: implements linear total 250ms animation duration>,

        -- Path generator for visualized cursor movement
        -- path = --<function: implements shortest line path>,
      },

      -- Vertical scroll
      scroll = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        -- timing = --<function: implements linear total 250ms animation duration>,

        -- Subscroll generator based on total scroll
        -- subscroll = --<function: implements equal scroll with at most 60 steps>,
      },

      -- Window resize
      resize = {
        -- Whether to enable this animation
        enable = true,
      },

      -- Window open
      open = {
        -- Whether to enable this animation
        enable = true,

      },

      -- Window close
      close = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
      }
    })
  end,
}

 local targets= {
    "wellle/targets.vim",
    event = "BufReadPost",
    enabled=false,
    -- lazy = false,
  }

local aerial={
  'stevearc/aerial.nvim',
  -- enabled=false,
  cmd={"AerialToggle"},
  opts = {},
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
config=function()
-- Call the setup function to change the default behavior
require("aerial").setup({
  -- Priority list of preferred backends for aerial.
  -- This can be a filetype map (see :help aerial-filetype-map)
  backends = { "treesitter", "lsp", "markdown", "man" },

  layout = {
    -- These control the width of the aerial window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a list of mixed types.
    -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
    max_width = { 40, 0.2 },
    width = nil,
    min_width = 10,

    -- key-value pairs of window-local options for aerial window (e.g. winhl)
    win_opts = {},

    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    -- Enum: prefer_right, prefer_left, right, left, float
    default_direction = "prefer_right",

    -- Determines where the aerial window will be opened
    --   edge   - open aerial at the far right/left of the editor
    --   window - open aerial to the right/left of the current window
    placement = "window",

    -- Preserve window size equality with (:help CTRL-W_=)
    preserve_equality = false,
  },

  -- Determines how the aerial window decides which buffer to display symbols for
  --   window - aerial window will display symbols for the buffer in the window from which it was opened
  --   global - aerial window will display symbols for the current window
  attach_mode = "window",

  -- List of enum values that configure when to auto-close the aerial window
  --   unfocus       - close aerial when you leave the original source window
  --   switch_buffer - close aerial when you change buffers in the source window
  --   unsupported   - close aerial when attaching to a buffer that has no symbol source
  close_automatic_events = {},

  -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("aerial.actions").<name>
  -- Set to `false` to remove a keymap
  keymaps = {
    ["?"] = "actions.show_help",
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["p"] = "actions.scroll",
    ["<C-j>"] = "actions.down_and_scroll",
    ["<C-k>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["[["] = "actions.prev_up",
    ["]]"] = "actions.next_up",
    ["q"] = "actions.close",
    ["o"] = "actions.tree_toggle",
    ["za"] = "actions.tree_toggle",
    ["O"] = "actions.tree_toggle_recursive",
    ["zA"] = "actions.tree_toggle_recursive",
    ["l"] = "actions.tree_open",
    ["zo"] = "actions.tree_open",
    ["L"] = "actions.tree_open_recursive",
    ["zO"] = "actions.tree_open_recursive",
    ["h"] = "actions.tree_close",
    ["zc"] = "actions.tree_close",
    ["H"] = "actions.tree_close_recursive",
    ["zC"] = "actions.tree_close_recursive",
    ["zr"] = "actions.tree_increase_fold_level",
    ["zR"] = "actions.tree_open_all",
    ["zm"] = "actions.tree_decrease_fold_level",
    ["zM"] = "actions.tree_close_all",
    ["zx"] = "actions.tree_sync_folds",
    ["zX"] = "actions.tree_sync_folds",
  },

  -- When true, don't load aerial until a command or function is called
  -- Defaults to true, unless `on_attach` is provided, then it defaults to false
  lazy_load = true,

  -- Disable aerial on files with this many lines
  disable_max_lines = 10000,

  -- Disable aerial on files this size or larger (in bytes)
  disable_max_size = 2000000, -- Default 2MB

  -- A list of all symbols to display. Set to false to display all symbols.
  -- This can be a filetype map (see :help aerial-filetype-map)
  -- To see all available values, see :help SymbolKind
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },

  -- Determines line highlighting mode when multiple splits are visible.
  -- split_width   Each open window will have its cursor location marked in the
  --               aerial buffer. Each line will only be partially highlighted
  --               to indicate which window is at that location.
  -- full_width    Each open window will have its cursor location marked as a
  --               full-width highlight in the aerial buffer.
  -- last          Only the most-recently focused window will have its location
  --               marked in the aerial buffer.
  -- none          Do not show the cursor locations in the aerial window.
  highlight_mode = "split_width",

  -- Highlight the closest symbol if the cursor is not exactly on one.
  highlight_closest = true,

  -- Highlight the symbol in the source buffer when cursor is in the aerial win
  highlight_on_hover = false,

  -- When jumping to a symbol, highlight the line for this many ms.
  -- Set to false to disable
  highlight_on_jump = 300,

  -- Jump to symbol in source window when the cursor moves
  autojump = false,

  -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
  -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
  -- default collapsed icon. The default icon set is determined by the
  -- "nerd_font" option below.
  -- If you have lspkind-nvim installed, it will be the default icon set.
  -- This can be a filetype map (see :help aerial-filetype-map)
  icons = {},

  -- Control which windows and buffers aerial should ignore.
  -- Aerial will not open when these are focused, and existing aerial windows will not be updated
  ignore = {
    -- Ignore unlisted buffers. See :help buflisted
    unlisted_buffers = false,

    -- List of filetypes to ignore.
    filetypes = {},

    -- Ignored buftypes.
    -- Can be one of the following:
    -- false or nil - No buftypes are ignored.
    -- "special"    - All buffers other than normal, help and man page buffers are ignored.
    -- table        - A list of buftypes to ignore. See :help buftype for the
    --                possible values.
    -- function     - A function that returns true if the buffer should be
    --                ignored or false if it should not be ignored.
    --                Takes two arguments, `bufnr` and `buftype`.
    buftypes = "special",

    -- Ignored wintypes.
    -- Can be one of the following:
    -- false or nil - No wintypes are ignored.
    -- "special"    - All windows other than normal windows are ignored.
    -- table        - A list of wintypes to ignore. See :help win_gettype() for the
    --                possible values.
    -- function     - A function that returns true if the window should be
    --                ignored or false if it should not be ignored.
    --                Takes two arguments, `winid` and `wintype`.
    wintypes = "special",
  },

  -- Use symbol tree for folding. Set to true or false to enable/disable
  -- Set to "auto" to manage folds if your previous foldmethod was 'manual'
  -- This can be a filetype map (see :help aerial-filetype-map)
  manage_folds = false,

  -- When you fold code with za, zo, or zc, update the aerial tree as well.
  -- Only works when manage_folds = true
  link_folds_to_tree = false,

  -- Fold code when you open/collapse symbols in the tree.
  -- Only works when manage_folds = true
  link_tree_to_folds = true,

  -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
  -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
  nerd_font = "auto",

  -- Call this function when aerial attaches to a buffer.
  -- on_attach = function(bufnr) end,

  -- Call this function when aerial first sets symbols on a buffer.
  -- on_first_symbols = function(bufnr) end,

  -- Automatically open aerial when entering supported buffers.
  -- This can be a function (see :help aerial-open-automatic)
  open_automatic = false,

  -- Run this command after jumping to a symbol (false will disable)
  post_jump_cmd = "normal! zz",

  -- Invoked after each symbol is parsed, can be used to modify the parsed item,
  -- or to filter it by returning false.
  --
  -- bufnr: a neovim buffer number
  -- item: of type aerial.Symbol
  -- ctx: a record containing the following fields:
  --   * backend_name: treesitter, lsp, man...
  --   * lang: info about the language
  --   * symbols?: specific to the lsp backend
  --   * symbol?: specific to the lsp backend
  --   * syntax_tree?: specific to the treesitter backend
  --   * match?: specific to the treesitter backend, TS query match
  post_parse_symbol = function(bufnr, item, ctx)
    return true
  end,

  -- Invoked after all symbols have been parsed and post-processed,
  -- allows to modify the symbol structure before final display
  --
  -- bufnr: a neovim buffer number
  -- items: a collection of aerial.Symbol items, organized in a tree,
  --        with 'parent' and 'children' fields
  -- ctx: a record containing the following fields:
  --   * backend_name: treesitter, lsp, man...
  --   * lang: info about the language
  --   * symbols?: specific to the lsp backend
  --   * syntax_tree?: specific to the treesitter backend
  post_add_all_symbols = function(bufnr, items, ctx)
    return items
  end,

  -- When true, aerial will automatically close after jumping to a symbol
  close_on_select = false,

  -- The autocmds that trigger symbols update (not used for LSP backend)
  update_events = "TextChanged,InsertLeave",

  -- Show box drawing characters for the tree hierarchy
  show_guides = false,

  -- Customize the characters used when show_guides = true
  guides = {
    -- When the child item has a sibling below it
    mid_item = "├─",
    -- When the child item is the last in the list
    last_item = "└─",
    -- When there are nested child guides to the right
    nested_top = "│ ",
    -- Raw indentation
    whitespace = "  ",
  },


  -- Options for opening aerial in a floating win
  float = {
    -- Controls border appearance. Passed to nvim_open_win
    border = "rounded",

    -- Determines location of floating window
    --   cursor - Opens float on top of the cursor
    --   editor - Opens float centered in the editor
    --   win    - Opens float centered in the window
    relative = "cursor",

    -- These control the height of the floating window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a list of mixed types.
    -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },
  },

  -- Options for the floating nav windows
  nav = {
    border = "rounded",
    max_height = 0.9,
    min_height = { 10, 0.1 },
    max_width = 0.5,
    min_width = { 0.2, 20 },
    win_opts = {
      cursorline = true,
      winblend = 10,
    },
    -- Jump to symbol in source window when the cursor moves
    autojump = false,
    -- Show a preview of the code in the right column, when there are no child symbols
    preview = false,
    -- Keymaps in the nav window
    keymaps = {
      ["<CR>"] = "actions.jump",
      ["<2-LeftMouse>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["<C-s>"] = "actions.jump_split",
      ["h"] = "actions.left",
      ["l"] = "actions.right",
      ["<C-c>"] = "actions.close",
    },
  },

  lsp = {
    -- Fetch document symbols when LSP diagnostics update.
    -- If false, will update on buffer changes.
    diagnostics_trigger_update = true,

    -- Set to false to not update the symbols when there are LSP errors
    update_when_errors = true,

    -- How long to wait (in ms) after a buffer change before updating
    -- Only used when diagnostics_trigger_update = false
    update_delay = 300,

    -- Map of LSP client name to priority. Default value is 10.
    -- Clients with higher (larger) priority will be used before those with lower priority.
    -- Set to -1 to never use the client.
    priority = {
      -- pyright = 10,
    },
  },

  treesitter = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },

  markdown = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },

  man = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },
})

end,
}
local term={
  "numToStr/FTerm.nvim",
  -- lazy=false,
  keys = {
    { "<leader>tt", "<cmd>FTermToggle<cr>", desc = "toggle float terminal" },
    { "<leader>tc", "<cmd>FTermClose<cr>", desc = "close float terminal" },
    { "<leader>to", "<cmd>FTermOpen<cr>", desc = "open float terminal" },
    { "<leader>te", "<cmd>FTermExit<cr>", desc = "exit float terminal" },
    { "<leader>tg", "<cmd>FTermGitui<cr>", desc = "float terminal: Gitui" },
    { "<leader>gg", "<cmd>FTermLazygit<cr>", desc = "float terminal: Lazygit" },
    -- { "q", "<cmd>FTermToggle<cr>",mode="t", desc = "float terminal" },
  },
  config=function()
    require'FTerm'.setup({
      ft = 'FTerm',
      cmd = "pwsh",
      auto_close = true,
      ---Transparency of the floating window. See `:h winblend`
      blend = 15,

      dimensions = {
        height = 0.9, -- Height of the terminal window
        width = 0.9, -- Width of the terminal window
        x = 0.5, -- X axis of the terminal window
        y = 0.5, -- Y axis of the terminal window
      },
    })

    vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })
    vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
    -- This will close the terminal window but preserves the actual terminal session
    vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
    -- Unlike closing, this will remove the terminal session
    vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true })

    local fterm = require("FTerm")
    local gitui = fterm:new({
      ft = 'fterm_gitui', -- You can also override the default filetype, if you want
      cmd = "gitui",
      dimensions = {
        height = 0.9,
        width = 0.9
      }
    })
    vim.api.nvim_create_user_command('FTermGitui', function()gitui:toggle()end , { bang = true })
    local ftermlazygit = fterm:new({
      ft = 'fterm_lazygit', -- You can also override the default filetype, if you want
      cmd = "lazygit",
      dimensions = {
        height = 0.9,
        width = 0.9
      }
    })
    vim.api.nvim_create_user_command('FTermLazygit', function()ftermlazygit:toggle()end , { bang = true })
  end,
}
local minipair={
    "echasnovski/mini.pairs",
    -- event = "VeryLazy",
    -- lazy=false,
    enabled=false,
    config = function()
      require("mini.pairs").setup()
    end,
  }
local undo ={
  "jiaoshijie/undotree",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys={
    {'<leader>u', ":lua require('undotree').toggle()<cr>",  mode="n"},
  },
  config=function()
    local undotree = require('undotree')
    undotree.setup({
      float_diff = true,  -- using float window previews diff, set this `true` will disable layout option
      layout = "left_bottom", -- "left_bottom", "left_left_bottom"
      ignore_filetype = { 'Undotree', 'UndotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
      window = {
        winblend = 30,
      },
      keymaps = {
        ['j'] = "move_next",
        ['k'] = "move_prev",
        ['J'] = "move_change_next",
        ['K'] = "move_change_prev",
        ['<cr>'] = "action_enter",
        ['p'] = "enter_diffbuf",
        ['q'] = "quit",
      },
    })
  end,
}
local firenvim={
  'glacambre/firenvim',
lazy=false,
  -- Lazy load firenvim
  -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  cond = not not vim.g.started_by_firenvim,
  build = function()
    require("lazy").load({ plugins = "firenvim", wait = true })
    vim.fn["firenvim#install"](0)
  end
}

local bar={
  "utilyre/barbecue.nvim",
  enabled=false,
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
  },
  config = function()
    require("barbecue").setup()
  end,
}



  local mini_indentscope={
    "echasnovski/mini.indentscope",
    enabled=false,
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufRead",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  }


local wiki={
  "vimwiki/vimwiki",
  ft={"md"},
}
local md={
  -- use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })
  "toppair/peek.nvim",
  enabled = false,
  build ="deno task --quiet build:fast",
  ft="md",
  lazy=false,
  config = function()
    require('peek').setup({
      auto_load = false,         -- whether to automatically load preview when
      -- entering another markdown buffer
      close_on_bdelete = true,  -- close preview window on buffer delete
      syntax = true,            -- enable syntax highlighting, affects performance
      theme = 'dark',           -- 'dark' or 'light'
      update_on_change = true,
      app = 'browser',          -- 'webview', 'browser', string or a table of strings
      -- explained below
      filetype = { 'markdown' } -- list of filetypes to recognize as markdown
      -- relevant if update_on_change is true
      -- throttle_at = 200000,     -- start throttling when file exceeds this
      -- amount of bytes in size
      -- throttle_time = 'auto',   -- minimum amount of time in milliseconds
      -- that has to pass before starting new render
    })
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
  end,
}