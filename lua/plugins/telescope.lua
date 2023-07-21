local Util = require("config.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "files" },
      { "<leader>fF", "<cmd>Telescope file_browser<cr>", desc = "files" },
      { "<leader>fc", "<cmd>lua require('material.functions').find_style()<cr>", desc = "color scheme" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "old files" },
      { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
      { "<leader>?", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
      { "<leader>fg", "<cmd>Telescope grep_string<cr>", desc = "grep string" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "buffers" },

      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "current buffer fuzzy find" },
      { "<leader>`", "<cmd>Telescope marks<cr>", desc = "marks" },

      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "git branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "git status" },
      { "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "git stash" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "git files" },

      { "<leader>id", ":lua require'telescope.builtin'.diagnostics{bufnr=0}<cr>", desc = "current buffer diagnostics" },
      { "<leader>iD", ":lua require'telescope.builtin'.diagnostics{}<cr>", desc = "workspace diagnostics" },
      { "<leader>ib", ":lua require'telescope.builtin'.builtin<cr>", desc = "telescope builtin" },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },

      { "<leader>ir", "<cmd>Telescope registers<cr>", desc = "registers" },
      { "<leader>it", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>ic", "<cmd>Telescope commands<cr>", desc = "commands" },
      { "<leader>;", "<cmd>Telescope command_history<cr>", desc = "commands history" },
      { "<leader>i/", "<cmd>Telescope search_history<cr>", desc = "search history" },
      { "<leader>is", "<cmd>Telescope possession list<cr>", desc = "sessions" },
      { "<leader>im", "<cmd>Telescope marks<cr>", desc = "marks" },
      { "<leader>ij", "<cmd>Telescope jumplist<cr>", desc = "jump list" },
      { "<leader>ih", "<cmd>Telescope help_tags<cr>", desc = "help tags" },
      { "<leader>w", "<cmd>Telescope spell_suggest<cr>", desc = "spell suggest" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-project.nvim",
      'nvim-telescope/telescope-ui-select.nvim',
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local fb_actions = require "telescope._extensions.file_browser.actions"
      require('telescope').setup{
        defaults = {
          winblend = 10,
          initial_mode="normal",
          scroll_strategy="limit",
          mappings = {
            i = {
              --       ["<c-d>"] = "delete_buffer",
              ["<C-s>"] = "select_horizontal",
              ["<C-v>"] = "select_vertical",
              ["<C-t>"] = "select_tab",
            },
            n = {
              ["s"] = "select_horizontal",
              ["q"] = "close",
              ["v"] = "select_vertical",
              ["t"] = "select_tab",
            },
          },
          prompt_prefix = " ",
          sorting_strategy = "ascending",
          selection_caret = " ",
          entry_prefix = " ",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            bottom_pane = {
              height = 15,
              preview_cutoff = 100,
              prompt_position = "top",
            },
          },
        },
        pickers = {
          current_buffer_fuzzy_find = {
            initial_mode="insert",
          },
          spell_suggest = {
            theme = "cursor",
          },
          help_tags = {
            initial_mode="insert",
          },
          commands = {
            initial_mode="insert",
          },
          live_grep = {
            initial_mode="insert",
          },
          grep_string = {
            initial_mode="insert",
          },
          find_files = {
            initial_mode="insert",
          },
          buffers = {
            initial_mode="normal",
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
              n = {
                ["d"] = "delete_buffer",
              },
            },
          },
          git_branches={
            initial_mode="normal",
            mappings = {
              n = {
                ["<space>"] = "git_checkout",
                ["n"] = "git_create_branch",
                ["d"] = "git_delete_branch",
                ["m"] = "git_merge_branch",
                ["r"] = "git_rebase_branch",
              },
            },
          },
          git_commits={
            initial_mode="normal",
            mappings = {
              n = {
                ["gm"] = "git_reset_mixed",
                ["gs"] = "git_reset_soft",
                ["gh"] = "git_reset_hard",
              },
            },
          },
          git_status={
            initial_mode="normal",
            mappings = {
              n = {
                ["<space>"] = "git_staging_toggle",
              },
            },
          },
        },
        extensions = {
          file_browser = {
            grouped = true,
            auto_depth = true,
            select_buffer = false,
            hidden = { file_browser = true, folder_browser = true },
            dir_icon = "",
            use_fd = true,
            git_status = true,
            mappings = {
              ["i"] = {
                ["<A-a>"] = fb_actions.create,
                ["<S-CR>"] = fb_actions.create_from_prompt,
                ["<A-r>"] = fb_actions.rename,
                ["<A-m>"] = fb_actions.move,
                ["<A-y>"] = fb_actions.copy,
                ["<A-d>"] = fb_actions.remove,
                ["<C-o>"] = fb_actions.open,
                ["<C-g>"] = fb_actions.goto_parent_dir,
                ["<C-e>"] = fb_actions.goto_home_dir,
                ["<C-w>"] = fb_actions.goto_cwd,
                ["<C-t>"] = fb_actions.change_cwd,
                ["<C-f>"] = fb_actions.toggle_browser,
                ["<C-h>"] = fb_actions.toggle_hidden,
                ["<C-s>"] = fb_actions.toggle_all,
                ["<bs>"] = fb_actions.backspace,
              },
              ["n"] = {
                ["a"] = fb_actions.create,
                ["r"] = fb_actions.rename,
                ["m"] = fb_actions.move,
                ["y"] = fb_actions.copy,
                ["D"] = fb_actions.remove,
                ["o"] = fb_actions.open,
                ["h"] = fb_actions.goto_parent_dir,
                ["e"] = fb_actions.goto_home_dir,
                ["w"] = fb_actions.goto_cwd,
                ["."] = fb_actions.change_cwd,
                ["f"] = fb_actions.toggle_browser,
                ["zh"] = fb_actions.toggle_hidden,
                ["H"] = fb_actions.toggle_hidden,
                ["s"] = fb_actions.toggle_all,
              },
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        },
      }
      require('telescope').load_extension('possession')
      require('telescope').load_extension('file_browser')
      require('telescope').load_extension('ui-select')
      require'telescope'.load_extension('project')
    end,
  },
  {
    'jedrzejboczar/possession.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      require('possession').setup {
        -- session_dir = (Path:new(vim.fn.stdpath('data')) / 'possession'):absolute(),
        session_dir = vim.fn.stdpath("data") .. "/sessions",
        silent = false,
        load_silent = true,
        debug = false,
        logfile = false,
        prompt_no_cr = false,
        autosave = {
          current = true,  -- or fun(name): boolean
          tmp = true,  -- or fun(): boolean
          tmp_name = 'tmp',
          on_load = true,
          on_quit = true,
        },
        commands = {
          save    = 'PSave',
          load    = 'PLoad',
          rename  = 'PRename',
          close   = 'PClose',
          delete  = 'PDelete',
          show    = 'PShow',
          list    = 'PList',
          migrate = 'PMigrate',
        },
        hooks = {
          before_save = function(name) return {} end,
          after_save = function(name, user_data, aborted) end,
          before_load = function(name, user_data) return user_data end,
          after_load = function(name, user_data) end,
        },
        plugins = {
          close_windows = {
            hooks = {'before_save', 'before_load'},
            preserve_layout = true,  -- or fun(win): boolean
            match = {
              floating = true,
              buftype = {},
              filetype = {},
              custom = false,  -- or fun(win): boolean
            },
          },
          delete_hidden_buffers = {
            hooks = {
              'before_load',
              vim.o.sessionoptions:match('buffer') and 'before_save',
            },
            force = false,  -- or fun(buf): boolean
          },
          nvim_tree = true,
          tabby = true,
          dap = true,
          delete_buffers = false,
        },
      }
    end,
  },
}
