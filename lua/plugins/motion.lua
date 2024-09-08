return {
  {
    'Bekaboo/dropbar.nvim',
    -- lazy = false,
    event = "LspAttach",
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
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
      outline_window = {
        position = 'left',
      },
      preview_window = {
        open_hover_on_preview = true,
        live = true,
      },
      keymaps = {
        goto_location = '<space>',
        peek_location = 'o',
        goto_and_close = '<Cr>',
        restore_location = '<C-g>',
        hover_symbol = 'K',
        toggle_preview = 'p',
        fold_all = 'zM',
        unfold_all = 'zR',
      },
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    enabled = false,
    keys = {
      { "<leader>O", "<cmd>Navbuddy<cr>", desc = "Jump by symbol" },
      -- TODO: reset keymap
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
      { 'f',                ":HopChar1<cr>",    desc = "Hop Char",    { noremap = true, silent = true } },
      { 'F',                ":HopWord<cr>",     desc = "Hop Word",    { noremap = true, silent = true } },
      { "<leader><leader>", ":HopAnywhere<cr>", desc = "HopAnywhere", { noremap = true, silent = true } },
    },
    -- TODO: more keys
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
  {
    'tomasky/bookmarks.nvim',
    enabled = false,
    -- tag = 'release' -- To use the latest release
    -- lazy = false,
    keys = {
      { "mm", function() require('bookmarks').bookmark_toggle() end,    desc = "add or remove bookmark at current line", mode = { "n" } },
      { "mi", function() require('bookmarks').bookmark_ann() end,       desc = "edit mark annotation at current line" },
      { "md", function() require('bookmarks').bookmark_clean() end,     desc = "clean all marks in local buffer" },
      { "mj", function() require('bookmarks').bookmark_next() end,      desc = "jump to next bookmark" },
      { "mk", function() require('bookmarks').bookmark_prev() end,      desc = "jump to previous bookmark" },
      { "ml", function() require('bookmarks').bookmark_list() end,      desc = "show marked file in quickfix" },
      { "mc", function() require('bookmarks').bookmark_clear_all() end, desc = "removes all bookmarks" },
    },
    -- event = "VimEnter",
    config = function()
      require('bookmarks').setup {
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.stdpath("data") .. "/.bookmarks",
        keywords = {
          ["@t"] = " ", -- mark annotation startswith @t ,signs this icon as `Todo`
          ["@w"] = " ", -- mark annotation startswith @w ,signs this icon as `Warn`
          ["@f"] = " ", -- mark annotation startswith @f ,signs this icon as `Fix`
          ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
        },
      }
    end,
  },
}
