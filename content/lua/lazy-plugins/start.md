---
title: start
---

# starter

using mini.starer, because it is so mini. and it needs mini.session to access sessions.

There is a autocomd in [/plugin/autocmds](/plugin/autocmds) to generate tmp session.

```lua
vim.o.sessionoptions = "buffers,curdir,help,tabpages,terminal,localoptions,folds"
return {
  { -- "echasnovski/mini.starter",
    "echasnovski/mini.starter",
    -- enabled = false,
    version = "*",
    event = "VimEnter",
    dependencies = {
      "echasnovski/mini.sessions",
    },
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        evaluate_single = true,
        items = {
          starter.sections.sessions(8, true),
          starter.sections.recent_files(5, false),
          -- starter.sections.telescope(),
          -- starter.sections.recent_files(3, true), -- local
          -- starter.sections.builtin_actions(),
          { name = "start up time", action = [[StartupTime]], section = "actions" },
          { name = "find files", action = [[lua Snacks.dashboard.pick('oldfiles')]], section = "actions" },
          { name = "lazy.nvim", action = [[Lazy]], section = "actions" },
          { name = "quit", action = [[quit]], section = "actions" },
          -- { name = "profile", action = [[lua Snacks.profiler.toggle()]], section = "actions" },
          { name = "new file", action = "enew", section = "actions" },
        },
        header = "",
        footer = "",
        content_hooks = {
          -- starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing("all", { "Sessions", "actions" }),
          -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
          starter.gen_hook.padding(3, 2),
          starter.gen_hook.aligning("center", "center"),
        },
      })
    end,
  },
  { -- "echasnovski/mini.sessions",
    "echasnovski/mini.sessions",
    version = "*",
    -- cmd = { "SessionSave", "SessionSearch" },
    -- enabled = false,
    opts = {
      directory = vim.fn.stdpath("state") .. "/sessions",
    },
  },
  { -- "rmagatti/auto-session",
    "rmagatti/auto-session",
    -- enabled = false,
    event = "BufRead",
    keys = {
      { "<leader>Ss", "<cmd>AutoSession search<CR>", desc = "Session search" },
      { "<leader>Ss", "<cmd>AutoSession save<CR>", desc = "Save session" },
      { "<leader>Sa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    },
    config = function()
      require("auto-session").setup({
        post_cwd_changed_cmds = {
          function()
            require("lualine").refresh() -- example refreshing the lualine status line _after_ the cwd changes
          end,
        },
        auto_session_root_dir = vim.fn.stdpath("state") .. "/sessions/",
        auto_create = false,
        session_lens = {
          load_on_setup = false, -- Initialize on startup (requires Telescope)
          previewer = true, -- File preview for session picker
          mappings = {
            delete_session = { "n", "d" },
            alternate_session = { "n", "<CR>" },
            copy_session = { "n", "Y" },
          },
          session_control = {
            control_dir = vim.fn.stdpath("state") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
            control_filename = "session_control.json", -- File name of the session control file
          },
        },
      })
    end,
  },
  { -- "dstein64/vim-startuptime",
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
```
