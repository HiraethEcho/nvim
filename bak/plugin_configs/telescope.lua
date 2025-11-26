return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    -- cmd = { "Telescope oldfiles", },
    keys = {
      -- telescope builtin
      { "<leader>ii", "<cmd>Telescope builtin<cr>",                               desc = "telescope builtin" },
      -- files
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                            desc = "files" },
      { "<leader>fh", "<cmd>Telescope oldfiles<cr>",                              desc = "history files" },
      { "<leader>b",  "<cmd>Telescope buffers<cr>",                               desc = "buffers" },
      -- enhance native
      { "<leader>*",  ":lua require'telescope.builtin'.grep_string{bufnr=0}<cr>", desc = "current buffer grep_string", },
      { "<leader>/",  "<cmd>Telescope live_grep<cr>",                             desc = "live grep" },
      { "<leader>fr", "<cmd>Telescope resume<cr>",                                desc = "resume" },
      { "<leader>;",  "<cmd>Telescope commands<cr>",                              desc = "commands" },
      { "<leader>w",  "<cmd>Telescope spell_suggest<cr>",                         desc = "spell suggest" },
      { "<leader>j",  "<cmd>Telescope jumplist<cr>",                              desc = "jump list" },
      { "<leader>`",  "<cmd>Telescope marks<cr>",                                 desc = "marks" },
      { '<leader>"',  "<cmd>Telescope registers<cr>",                             desc = "registers" },
      { "<leader>ih", "<cmd>Telescope help_tags<cr>",                             desc = "help tags" },
      { "<leader>ic", "<cmd>Telescope colorscheme<cr>",                          desc = "colorschemes" },
      -- git
      { "<leader>gB", "<cmd>Telescope git_branches<cr>",                          desc = "git branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",                           desc = "git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>",                            desc = "git status" },
      { "<leader>gS", "<cmd>Telescope git_stash<cr>",                             desc = "git stash" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>",                             desc = "git files" },
      -- history
      { "<leader>i/", "<cmd>Telescope search_history<cr>",                        desc = "search history" },
      { "<leader>i;", "<cmd>Telescope command_history<cr>",                       desc = "commands history" },
      { "<leader>in", "<cmd>Telescope notify<cr>",                                desc = "notify history" },
      -- lsp
      { "<leader>ir", "<cmd>Telescope lsp_references<cr>",                        desc = "References" },
      { "<leader>id", ":lua require'telescope.builtin'.diagnostics{bufnr=0}<cr>", desc = "current buffer diagnostics", },
      { "<leader>iD", ":lua require'telescope.builtin'.diagnostics{}<cr>",        desc = "workspace diagnostics" },
      -- plugins
      { "<leader>it", "<cmd>TodoTelescope<cr>",                                   desc = "Todo" },
      -- { "<leader>is", "<cmd>Telescope possession list<cr>",                       desc = "sessions" },
      -- { "<leader>fF", "<cmd>Telescope file_browser<cr>",                          desc = "files" },
      -- { '<leader>y',  "<cmd>Telescope neoclip<cr>",                               desc = "yank history" },
      -- { "M",  "<cmd>Telescope bookmarks list<cr>",                                 desc = "bookmarks" },
      -- { "M",  "<cmd>Telescope marks list<cr>",                                 desc = "bookmarks" },
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
          initial_mode = "insert",
          scroll_strategy = "limit",
          mappings = {
            i = {
              ["<C-s>"] = "select_horizontal",
              ["<C-v>"] = "select_vertical",
              ["<C-t>"] = "select_tab",
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["up"] = "cycle_history_prev",
              ["down"] = "cycle_history_next",
            },
            n = {
              ["s"] = "select_horizontal",
              ["q"] = "close",
              ["v"] = "select_vertical",
              ["t"] = "select_tab",
              ["<space>"] = "toggle_selection",
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
          sorting_strategy = "ascending",
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
          spell_suggest = {
            initial_mode = "normal",
            theme = "cursor",
          },
          grep_string = {
            initial_mode = "normal",
          },
          buffers = {
            initial_mode = "normal",
            mappings = {
              i = { ["<c-d>"] = "delete_buffer", },
              n = { ["d"] = "delete_buffer", },
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
        },
      })
      -- require("telescope").load_extension("possession")
      -- require('telescope').load_extension("bookmarks")
      -- require("telescope").load_extension("file_browser")
    end,
  },
  -- disable
  {
    "ibhagwan/fzf-lua",
    enabled = false,
    -- optional for icon support
    -- lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- search files
      -- { "<leader>ff", "<cmd>FzfLua files<cr>",                    desc = "files" },
      -- { "<leader>fh", "<cmd>FzfLua oldfiles<cr>",                 desc = "history files" },
      -- search string
      -- { "<leader>?",  "<cmd>FzfLua live_grep_resume<cr>",         desc = "grep string" },
      -- { "<leader>/",  "<cmd>FzfLua grep<cr>",                     desc = "live grep" },
      -- { "/",          "<cmd>FzfLua grep_visual<cr>",              desc = "live grep visual select", mode = "v" },
      -- { "**",         "<cmd>FzfLua grep_cword<cr>", desc = "live grep cursor word" },
      -- git
      -- { "<leader>gb", "<cmd>FzfLua git_blame<cr>",  desc = "git blame" },
      -- { "<leader>gB", "<cmd>FzfLua git_branches<cr>",             desc = "git branch" },
      -- { "<leader>gc", "<cmd>FzfLua git_commits<cr>",              desc = "git commits" },
      -- { "<leader>gs", "<cmd>FzfLua git_status<cr>",               desc = "git status" },
      -- { "<leader>gS", "<cmd>FzfLua git_stash<cr>",                desc = "git stash" },
      -- { "<leader>gf", "<cmd>FzfLua git_files<cr>",                desc = "git files" },
      -- list native
      -- { "<leader>b",  "<cmd>FzfLua buffers<cr>",                  desc = "buffers" },
      -- { "<leader>i/", "<cmd>FzfLua search_history<cr>",           desc = "search history" },
      -- { "<leader>i;", "<cmd>FzfLua command_history<cr>",          desc = "commands history" },
      -- { "<leader>ic", "<cmd>FzfLua colorschemes<cr>",             desc = "colorschemes" },
      -- { "<leader>ih", "<cmd>FzfLua helptags<cr>",                 desc = "help tags" },
      -- { "<leader>iq", "<cmd>FzfLua quickfix<cr>",                 desc = "quickfix" },
      -- { "<leader>im", "<cmd>FzfLua menu<cr>",                     desc = "menu" },
      -- { "<leader>`",  "<cmd>FzfLua marks<cr>",                    desc = "marks" },
      -- { '<leader>"',  "<cmd>FzfLua registers<cr>",                desc = "registers" },
      -- { "<leader>;",  "<cmd>FzfLua commands<cr>",                 desc = "commands" },
      -- { "<leader>w",  "<cmd>FzfLua spell_suggest<cr>",            desc = "spell suggest" },
      -- { "<leader>j",  "<cmd>FzfLua jumplist<cr>",                 desc = "jump list" },
      -- list lsp and treesitter
      -- { "<leader>ir", "<cmd>FzfLua lsp_references<cr>",           desc = "lsp references" },
      -- { "<leader>if", "<cmd>FzfLua lsp_finder<cr>", desc = "lsp finder" },
      -- { "<leader>io", "<cmd>FzfLua lsp_document_symbols<cr>",     desc = "lsp symbols" },
      -- { "<leader>id", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "lsp diagnostics" },
      -- { "<leader>it", "<cmd>FzfLua treesitter<cr>",               desc = "treesitter" },
      -- itself
      -- { "<leader>ii", "<cmd>FzfLua builtin",                      desc = "telescope builtin" },
    },
    config = function()
      require("fzf-lua").setup({})
    end
  },
}
