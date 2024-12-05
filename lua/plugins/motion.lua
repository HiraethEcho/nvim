return {
  {
    'Bekaboo/dropbar.nvim',
    enabled = false,
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
