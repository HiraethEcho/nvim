return {
  {
    'Bekaboo/dropbar.nvim',
    lazy = false,
    -- optional, but required for fuzzy finder support
    dependencies = {
      -- 'nvim-telescope/telescope-fzf-native.nvim'
    },
    opt = {
      bar = {
        pick = {
          pivots = 'asdfghjkl',
        },
      },
      menu = {
        -- Menu scrollbar options
        scrollbar = {
          enable = true,
          -- The background / gutter of the scrollbar
          -- When false, only the scrollbar thumb is shown.
          background = true
        },
        keymaps = {
          ['q'] = '<C-w>q',
          ['<Esc>'] = '<C-w>q',
          ['<CR>'] = function()
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then
              menu:click_on(component, nil, 1, 'l')
            end
          end,
        },
      },
    },
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here

      outline_window = {
        -- Where to open the split window: right/left
        position = 'right',
        width = 25,
        -- Whether width is relative to the total width of nvim
        -- When relative_width = true, this means take 25% of the total
        -- screen width for outline window.
        relative_width = true,

        -- Auto close the outline window if goto_location is triggered and not for
        -- peek_location
        auto_close = false,
        -- Automatically scroll to the location in code when navigating outline window.
        auto_jump = false,
        -- boolean or integer for milliseconds duration to apply a temporary highlight
        -- when jumping. false to disable.
        jump_highlight_duration = 300,

        -- Vim options for the outline window
        wrap = false,

        -- Enable this only if you enabled cursorline so your cursor color can
        -- blend with the cursorline, in effect, as if your cursor is hidden
        -- in the outline window.
        -- This makes your line of cursor have the same color as if the cursor
        -- wasn't focused on the outline window.
        -- This feature is experimental.
        hide_cursor = false,

        -- Winhighlight option for outline window.
        -- See :help 'winhl'
        -- To change background color to "CustomHl" for example, use "Normal:CustomHl".
        winhl = '',
      },

      outline_items = {
        -- Show corresponding line numbers of each symbol on the left column as
        -- virtual text, for quick navigation when not focused on outline.
        -- Why? See this comment:
        -- https://github.com/simrat39/symbols-outline.nvim/issues/212#issuecomment-1793503563
        show_symbol_lineno = false,
        -- Whether to automatically set cursor location in outline to match
        -- location in code when focus is in code. If disabled you can use
        -- `:OutlineFollow[!]` from any window or `<C-g>` from outline window to
        -- trigger this manually.
        auto_set_cursor = true,
        -- Autocmd events to automatically trigger these operations.
      },


      preview_window = {
        -- Automatically open preview of code location when navigating outline window
        auto_preview = false,
        -- Automatically open hover_symbol when opening preview (see keymaps for
        -- hover_symbol).
        -- If you disable this you can still open hover_symbol using your keymap
        -- below.
        open_hover_on_preview = true,
        width = 50,     -- Percentage or integer of columns
        min_width = 50, -- This is the number of columns
        relative_width = true,
        -- winhl options for the preview window, see ':h winhl'
        winhl = 'NormalFloat:',
        -- Pseudo-transparency of the preview window, see ':h winblend'
        winblend = 0,
        -- Experimental feature that let's you edit the source content live
        -- in the preview window. Like VS Code's "peek editor".
        live = true
      },

      -- These keymaps can be a string or a table for multiple keys.
      -- Set to `{}` to disable. (Using 'nil' will fallback to default keys)
      keymaps = {
        show_help = '?',
        close = { '<Esc>', 'q' },
        -- Jump to symbol under cursor.
        -- It can auto close the outline window when triggered, see
        -- 'auto_close' option above.
        goto_location = 'o',
        -- Jump to symbol under cursor but keep focus on outline window.
        peek_location = '<space>',
        -- peek_location = 'p',
        -- Visit location in code and close outline immediately
        goto_and_close = '<Cr>',
        -- Change cursor position of outline window to match current location in code.
        -- 'Opposite' of goto/peek_location.
        restore_location = '<C-g>',
        -- Open LSP/provider-dependent symbol hover information
        hover_symbol = '<C-space>',
        -- Preview location code of the symbol under cursor
        toggle_preview = 'P',
        rename_symbol = 'r',
        code_actions = 'a',
        fold_toggle = '<Tab>',
        fold_toggle_all = '<S-Tab>',
        fold_all = 'zM',
        unfold_all = 'zR',
        fold_reset = 'R',
        -- Move down/up by one line and peek_location immediately.
        -- You can also use outline_window.auto_jump=true to do this for any
        -- j/k/<down>/<up>.
        down_and_jump = '<C-j>',
        up_and_jump = '<C-k>',
      },

      providers = {
        priority = { 'lsp', 'markdown' },
        -- Configuration for each provider (3rd party providers are supported)
        lsp = {
          -- Lsp client names to ignore
          blacklist_clients = {},
        },
        markdown = {
          -- List of supported ft's to use the markdown provider
          filetypes = { 'markdown' },
        },
      },

      symbols = {
        -- Filter by kinds (string) for symbols in the outline.
        -- Possible kinds are the Keys in the icons table below.
        -- A filter list is a string[] with an optional exclude (boolean) field.
        -- The symbols.filter option takes either a filter list or ft:filterList
        -- key-value pairs.
        -- Put  exclude=true  in the string list to filter by excluding the list of
        -- kinds instead.
        -- Include all except String and Constant:
        --   filter = { 'String', 'Constant', exclude = true }
        -- Only include Package, Module, and Function:
        --   filter = { 'Package', 'Module', 'Function' }
        -- See more examples below.
        filter = nil,

        ---                        to fallback to `icon_source`.
        icon_fetcher = nil,
        -- 3rd party source for fetching icons. This is used as a fallback if
        -- icon_fetcher returned an empty string.
        -- Currently supported values: 'lspkind'
        icon_source = nil,
        -- The next fallback if both icon_fetcher and icon_source has failed, is
        -- the custom mapping of icons specified below. The icons table is also
        -- needed for specifying hl group.
        icons = {
          File = { icon = '󰈔', hl = 'Identifier' },
          Module = { icon = '󰆧', hl = 'Include' },
          Namespace = { icon = '󰅪', hl = 'Include' },
          Package = { icon = '󰏗', hl = 'Include' },
          Class = { icon = '𝓒', hl = 'Type' },
          Method = { icon = 'ƒ', hl = 'Function' },
          Property = { icon = '', hl = 'Identifier' },
          Field = { icon = '󰆨', hl = 'Identifier' },
          Constructor = { icon = '', hl = 'Special' },
          Enum = { icon = 'ℰ', hl = 'Type' },
          Interface = { icon = '󰜰', hl = 'Type' },
          Function = { icon = '', hl = 'Function' },
          Variable = { icon = '', hl = 'Constant' },
          Constant = { icon = '', hl = 'Constant' },
          String = { icon = '𝓐', hl = 'String' },
          Number = { icon = '#', hl = 'Number' },
          Boolean = { icon = '⊨', hl = 'Boolean' },
          Array = { icon = '󰅪', hl = 'Constant' },
          Object = { icon = '⦿', hl = 'Type' },
          Key = { icon = '🔐', hl = 'Type' },
          Null = { icon = 'NULL', hl = 'Type' },
          EnumMember = { icon = '', hl = 'Identifier' },
          Struct = { icon = '𝓢', hl = 'Structure' },
          Event = { icon = '🗲', hl = 'Type' },
          Operator = { icon = '+', hl = 'Identifier' },
          TypeParameter = { icon = '𝙏', hl = 'Identifier' },
          Component = { icon = '󰅴', hl = 'Function' },
          Fragment = { icon = '󰅴', hl = 'Constant' },
          TypeAlias = { icon = ' ', hl = 'Type' },
          Parameter = { icon = ' ', hl = 'Identifier' },
          StaticMethod = { icon = ' ', hl = 'Function' },
          Macro = { icon = ' ', hl = 'Function' },
        },
      },
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    -- enabled = false,
    keys = {
      { "<leader>ln", "<cmd>Navbuddy<cr>", desc = "Jump by symbol" },
    },
    cmd = "Navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = { lsp = { auto_attach = true } },
  },
  {
    "phaazon/hop.nvim",
    -- event = "BufRead",
    keys = {
      -- {'<leader>j', "<cmd>lua require'hop'.hint_vertical()<cr>",  mode={"n","v"}},
      -- {'F', "<cmd>lua require'hop'.hint_char1()<cr>", mode={"n","v"}},
      -- {'f', ":HopChar1CurrentLine<cr>", {noremap= true,silent=true}},
      { "<leader><leader>", ":HopWord<cr>", desc = "Hop Word", { noremap = true, silent = true } },
    },
    config = function()
      require("hop").setup()
    end,
  },
  {
    "echasnovski/mini.files",
    version = false,
    enabled = false,
    keys = {
      { "<leader>E", ":lua MiniFiles.open()<cr>", desc = "mini file " },
    },
    opts = {
      mappings = {
        close = "q",
        go_in = "l",
        go_in_plus = "",
        go_out = "h",
        go_out_plus = "",
        reset = "<BS>",
        show_help = "?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
      options = {
        use_as_default_explorer = true,
      },
      windows = {
        preview = true,
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 25,
        -- Width of preview window
        width_preview = 45,
      },
    },
  },
}
