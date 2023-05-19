local whichkey={
  "folke/which-key.nvim",
  lazy=false,
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup({
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = true, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      -- operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by deafult for Telescope
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
    })
    local wk = require("which-key")
    -- As an example, we will create the following mappings:
    --  * <leader>ff find files
    --  * <leader>fr show recent files
    --  * <leader>fb Foobar
    -- we'll document:
    --  * <leader>fn new file
    --  * <leader>fe edit file
    -- and hide <leader>1

    wk.register({
      l={
        name="list",
      },
      e={
        name="explorer",
      },
      g={
        name="git",
      },
      f = {
        name = "find", -- optional group name
        -- f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
        -- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false, buffer = 123 }, -- additional options for creating the keymap
        -- n = { "New File" }, -- just a label. don't create any mapping
        -- e = "Edit File", -- same as above
        -- ["1"] = "which_key_ignore",  -- special label to hide it in the popup
        -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
      },
      g={
        name="git",
      },
      t={
        name="terminal",
      },
      h={
        name="hunk",
      },
    },
    { prefix = "<leader>" })
  end,
}

local miscellaneous={
  {
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime",
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
    config=function()

    end,
  },
}

local wildernvim={
  "gelguy/wilder.nvim",
  event = 'CmdlineEnter',
  config = function()
    local wilder = require('wilder')
    wilder.set_option('use_python_remote_plugin', 0)
    wilder.setup({modes = {':', '/', '?'}})

    wilder.set_option('pipeline', {
      wilder.branch(
      wilder.cmdline_pipeline({
        fuzzy = 1,
        set_pcre2_pattern = 1,
      }),
      wilder.python_search_pipeline({
        pattern = 'fuzzy',
      })
      ),
    })

    local popupmenu_palette= wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme({
      border = 'rounded',
      max_height = '75%',      -- max height of the palette
      min_height = 0,          -- set to the same as 'max_height' for a fixed height window
      prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
      reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
      left = {' ', wilder.popupmenu_devicons()},
      right = {' ', wilder.popupmenu_scrollbar()},
    })
    )

    local popupmenu_renderer = wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
      border = 'rounded',
      highlighter = highlighters,
      left = {' ', wilder.popupmenu_devicons()},
      right = {' ', wilder.popupmenu_scrollbar()},
    })
    )

    local wildmenu_renderer = wilder.wildmenu_renderer({
      highlighter = highlighters,
      separator = ' · ',
      left = {' ', wilder.wildmenu_spinner(), ' '},
      right = {' ', wilder.wildmenu_index()},
    })

    wilder.set_option('renderer', wilder.renderer_mux({
      [':'] = popupmenu_renderer,
      ['/'] = wildmenu_renderer,
      substitute = wildmenu_renderer,
    }))
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

local spec={term,whichkey,wildernvim,miscellaneous}

return spec
