return {
  {
    "nvim-telescope/telescope.nvim",
    -- cmd = { "Telescope oldfiles", },
    keys = {
      -- { "<leader>fF", "<cmd>Telescope file_browser<cr>",                          desc = "files" },
      -- { "<leader>fs", "<cmd>Telescope live_grep<cr>",                             desc = "live grep" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                            desc = "files" },
      { "<leader>fh", "<cmd>Telescope oldfiles<cr>",                              desc = "history files" },
      { "<leader>B",  "<cmd>Telescope buffers<cr>",                               desc = "buffers" },

      -- { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>",             desc = "current buffer fuzzy find", },
      { "<leader>?", "<cmd>Telescope grep_string<cr>",                           desc = "grep string" },
      { "<leader>/",  "<cmd>Telescope live_grep<cr>",                             desc = "live grep" },
      { "<leader>`",  "<cmd>Telescope marks<cr>",                                 desc = "marks" },
      { '<leader>"',  "<cmd>Telescope registers<cr>",                             desc = "marks" },
      -- { '<leader>y',  "<cmd>Telescope neoclip<cr>",                               desc = "yank history" },
      { "<leader>;",  "<cmd>Telescope commands<cr>",                              desc = "commands" },
      { "<leader>w",  "<cmd>Telescope spell_suggest<cr>",                         desc = "spell suggest" },
      { "<leader>j",  "<cmd>Telescope jumplist<cr>",                              desc = "jump list" },
      -- { "M",  "<cmd>Telescope bookmarks list<cr>",                                 desc = "bookmarks" },
      -- { "M",  "<cmd>Telescope marks list<cr>",                                 desc = "bookmarks" },


      { "<leader>gb", "<cmd>Telescope git_branches<cr>",                          desc = "git branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",                           desc = "git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>",                            desc = "git status" },
      { "<leader>gS", "<cmd>Telescope git_stash<cr>",                             desc = "git stash" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>",                             desc = "git files" },

      { "<leader>i/", "<cmd>Telescope search_history<cr>",                        desc = "search history" },
      { "<leader>i;", "<cmd>Telescope command_history<cr>",                       desc = "commands history" },


      { "<leader>it", "<cmd>TodoTelescope<cr>",                                   desc = "Todo" },
      { "<leader>ih", "<cmd>Telescope help_tags<cr>",                             desc = "help tags" },

      -- { "<leader>is", "<cmd>Telescope possession list<cr>",                       desc = "sessions" },
      { "<leader>ii", ":lua require'telescope.builtin'.builtin{}<cr>",            desc = "telescope builtin" },
      -- { "<leader>ft", "<cmd>Telescope builtin<cr>",                               desc = "telescope builtin" },
      { "<leader>ir", "<cmd>Telescope lsp_references<cr>",                        desc = "References" },
      { "<leader>id", ":lua require'telescope.builtin'.diagnostics{bufnr=0}<cr>", desc = "current buffer diagnostics", },
      { "<leader>iD", ":lua require'telescope.builtin'.diagnostics{}<cr>",        desc = "workspace diagnostics" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- { "AckslD/nvim-neoclip.lua", config = true, },
      -- "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      -- local fb_actions = require("telescope._extensions.file_browser.actions")
      require("telescope").setup({
        defaults = {
          winblend = 10,
          initial_mode = "normal",
          scroll_strategy = "limit",
          mappings = {
            i = {
              --       ["<c-d>"] = "delete_buffer",
              ["<C-s>"] = "select_horizontal",
              ["<C-v>"] = "select_vertical",
              ["<C-t>"] = "select_tab",
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["up"] = "cycle_history_prev",
              ["down"] = "cycle_history_next",
              -- ["<C-k>"] = "move_previous",
            },
            n = {
              ["s"] = "select_horizontal",
              ["q"] = "close",
              ["v"] = "select_vertical",
              ["t"] = "select_tab",
              ["<space>"] = "toggle_selection",
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
            initial_mode = "insert",
          },
          spell_suggest = {
            theme = "cursor",
          },
          help_tags = {
            initial_mode = "insert",
          },
          commands = {
            initial_mode = "insert",
          },
          live_grep = {
            initial_mode = "insert",
          },
          grep_string = {
            initial_mode = "insert",
          },
          find_files = {
            initial_mode = "insert",
          },
          buffers = {
            initial_mode = "normal",
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
              n = {
                ["d"] = "delete_buffer",
              },
            },
          },
          git_branches = {
            initial_mode = "normal",
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
          git_commits = {
            initial_mode = "normal",
            mappings = {
              n = {
                ["gm"] = "git_reset_mixed",
                ["gs"] = "git_reset_soft",
                ["gh"] = "git_reset_hard",
              },
            },
          },
          git_status = {
            initial_mode = "normal",
            mappings = {
              n = {
                ["<space>"] = "git_staging_toggle",
              },
            },
          },
        },
        extensions = {
          --[[
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
]]
        },
      })
      -- require("telescope").load_extension("possession")
      -- require('telescope').load_extension("bookmarks")
      -- require("telescope").load_extension("file_browser")
    end,
  },
}
