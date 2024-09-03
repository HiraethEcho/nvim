return {
  { "folke/lazy.nvim", version = "*" },
  {
    "rhysd/nyaovim-mini-browser",
    enabled = false,
    event = "CmdlineEnter",
    -- keys = {
    --   { "<leader>B", "<cmd>StartMarkdownPreview<cr>", desc = "markdown Html Preview" },
    -- },
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },
  {
    "gelguy/wilder.nvim",
    enabled = false,
    event = "VeryLazy",
    -- event = "CmdlineEnter",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/" } })
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
    keys = {
      { "?", function() require("which-key").show() end, desc = "Buffer Local Keymaps (which-key)" },
    },
    event = "VeryLazy",
    opts = {
      preset = "classic",
      layout = {
        align = "center", -- align columns left, center or right
      },
    },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      wk.add({
        { "<leader>i", group = "list", },
        { "<leader>D", group = "Diff", },
        { "<leader>u", group = "ui", },
        { "<leader>f", group = "find", },
        { "<leader>g", group = "git", },
        { "<leader>l", group = "lsp", },
        { "<leader>m", group = "markdown", },
        { "<leader>h", group = "hunk", },
        { "<leader>c", group = "Copilot", },
        -- { "m", group = "bookmark", },
      })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<C-f>",     function() require("spectre").open() end,                                   desc = "toggle spectre" },
      { "<leader>s", function() require("spectre").open_file_search({ select_word = true }) end, mode = { "x", "v" },    desc = "search word on current file" },
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    'rmagatti/auto-session',
    enabled = false,
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/github", "~/documents" },
        auto_session_root_dir = vim.fn.stdpath('data') .. "/autosessions/",
        auto_session_enabled = true,
      }
      vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, { noremap = true, })
    end
  },
  {
    'Shatur/neovim-session-manager',
    enabled = false,
    dependencies = {
      'stevearc/dressing.nvim',
    },
    config = function()
      local config = require('session_manager.config')
      require('session_manager').setup({
        sessions_dir = vim.fn.stdpath('data') .. '/autosessions/', -- The directory where the session files will be saved.
        autosave_last_session = true,                              -- Automatically save last session on exit and on session switch.
        autosave_ignore_dirs = {},                                 -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = {                              -- All buffers of these file types will be closed before the session is saved.
          'gitcommit',
          'gitrebase',
          'undotree',
          'neo-tree',
          "sagaoutline",
          "Outline",
        },
        autosave_only_in_session = false,             -- Always autosaves session. If true, only autosaves after a session is active.
        autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      })
    end,
  },
  {
    'ActivityWatch/aw-watcher-vim',
    enabled = false,
    -- lazy = false,
    event = "VimEnter",
    cmd = "AWStart",
  },
  { -- lazy.nvim
    "goolord/alpha-nvim",
    enabled = false,
    dependencies = {
      "jedrzejboczar/possession.nvim",
      -- "nvim-telescope/telescope.nvim",
      -- "Shatur/neovim-session-manager",
    },
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.buttons.val = {
        (function()
          local group = { type = "group", opts = { spacing = 0 } }
          group.val = {
            {
              type = "text",
              val = "Sessions",
              opts = {
                position = "center",
              },
            },
          }
          local path = vim.fn.stdpath("data") .. "/sessions"
          local files = vim.split(vim.fn.glob(path .. "/*.json"), "\n")
          local i = 1
          for _, file in pairs(files) do
            local basename = vim.fs.basename(file):gsub("%.json", "")
            if basename ~= "config" and basename ~= "tmp" and basename ~= "blog" then
              -- if basename ~= "tmp" then
              local button =
                  dashboard.button(tostring(i), "● " .. basename, "<cmd>PLoad " .. basename .. "<cr>")
              table.insert(group.val, button)
              i = i + 1
              -- end
            end
          end
          return group
        end)(),
        dashboard.button("e", " " .. " New Files", "<cmd>enew<CR>"),
        dashboard.button("t", "󰃨 " .. " TMP", [[<cmd>PLoad tmp<CR>]]),
        -- dashboard.button("h", " " .. " history files", [[<cmd>Telescope oldfiles<CR>]]),
        -- dashboard.button("s", " " .. " Sessions", ":SessionManager load_session<CR>"),
        dashboard.button("c", " " .. " Nvim Config", [[<cmd>PLoad config<CR>]]),
        dashboard.button("b", "󰖟 " .. " blog", [[<cmd>PLoad blog<CR>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", "<cmd>qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
      -- config = function()
      local alpha = require("alpha")
      local startify = require("alpha.themes.startify")

      startify.section.header.val = {
        [[                                   __                ]],
        [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }
      startify.section.top_buttons.val = {
        startify.button("e", " " .. " New Files", ":enew<CR>"),
        -- startify.button("s", "  Sessions", ":SessionManager load_session  <CR>"),
        -- startify.button("c", " " .. " Nvim Config", ":<cmd>e $MYVIMRC<CR>"),
        -- startify.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      }
      startify.section.mru.val = { { type = "padding", val = 3 } }
      startify.section.mru_cwd.val = { { type = "padding", val = 3 } }
      startify.section.bottom_buttons.val = {
        startify.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
      }
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          -- startify.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      -- alpha.setup(startify.config)
    end,
  },
  {
    "ghillb/cybu.nvim",
    branch = "main", -- timely updates
    enabled = false,
    -- branch = "v1.x", -- won't receive breaking changes
    -- dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    -- lazy = false,
    config = function()
      require("cybu").setup({
        position = {
          relative_to = "win",  -- win, editor, cursor
          anchor = "topcenter", -- topleft, topcenter, topright,
          -- centerleft, center, centerright,
          -- bottomleft, bottomcenter, bottomright
          vertical_offset = 10,  -- vertical offset from anchor in lines
          horizontal_offset = 0, -- vertical offset from anchor in columns
          -- float for relative to win/editor width
        },
        behavior = { -- set behavior for different modes
          mode = {
            default = {
              switch = "immediate", -- immediate, on_close
              view = "rolling",     -- paging, rolling
            },
            last_used = {
              switch = "immediate", -- immediate, on_close
              view = "paging",      -- paging, rolling
            },
            auto = {
              view = "rolling", -- paging, rolling
            },
          },
          show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
        },
        display_time = 750,        -- time the cybu window is displayed
        exclude = {                -- filetypes, cybu will not be active
          "neo-tree",
          "fugitive",
          "qf",
        },
      })
      -- vim.keymap.set("n", "[b", "<Plug>(CybuPrev)")
      -- vim.keymap.set("n", "]b", "<Plug>(CybuNext)")
      -- vim.keymap.set("n", "<s-tab>", "<plug>(CybuLastusedPrev)")
      -- vim.keymap.set("n", "<tab>", "<plug>(CybuLastusedNext)")
      vim.keymap.set("n", "<s-tab>", "<plug>(CybuPrev)")
      vim.keymap.set("n", "<tab>", "<plug>(CybuNext)")
    end,
  },
    -- enabled = false,
}
