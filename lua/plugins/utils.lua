local vim = vim

return {
  { "folke/lazy.nvim", version = "*" },
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            set_pcre2_pattern = 1,
          }),
          wilder.python_search_pipeline({
            pattern = "fuzzy",
          })
        ),
      })
      local popupmenu_palette = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        border = "rounded",
        max_height = "75%",      -- max height of the palette
        min_height = 0,          -- set to the same as 'max_height' for a fixed height window
        prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
        pumblend = 20,
        reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        winblend = 30,
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      }))
      local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        border = "rounded",
        pumblend = 20,
        winblend = 30,
        -- highlighter = highlighters,
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      }))
      local wildmenu_renderer = wilder.wildmenu_renderer({
        separator = " · ",
        left = { " ", wilder.wildmenu_spinner(), " " },
        right = { " ", wilder.wildmenu_index() },
      })
      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = popupmenu_palette,
          -- [':'] =popupmenu_renderer,
          ["/"] = wildmenu_renderer,
          substitute = wildmenu_renderer,
        })
      )
    end,
  },
  {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    event = "BufRead",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        key_labels = {
          ["<space>"] = "SPC",
          ["<cr>"] = "RET",
          ["<tab>"] = "TAB",
        },
        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>",   -- binding to scroll up inside the popup
        },
        layout = {
          align = "center", -- align columns left, center or right
        },
        triggers_blacklist = {
          i = { "j", "k" },
          v = { "j", "k" },
        },
        -- disable the WhichKey popup for certain buf types and file types.
        -- Disabled by deafult for Telescope
        disable = {
          buftypes = {},
          filetypes = {
            "TelescopePrompt",
            'neo-tree',
            'undotree',
          },
        },
      })
      local wk = require("which-key")
      wk.register({
        i = {
          name = "list",
        },
        e = {
          name = "explorer",
        },
        u = {
          name = "ui", -- optional group name
        },
        f = {
          name = "find", -- optional group name
        },
        o = {
          name = "obsidian",
        },
        g = {
          name = "git",
        },
        l = {
          name = "lsp",
        },
        m = {
          name = "markdown",
        },
        h = {
          name = "hunk",
        },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
