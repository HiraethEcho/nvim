local tele={
  "nvim-telescope/telescope.nvim",
  -- lazy=false,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "files" },
    { "<leader>fc", "<cmd>lua require('material.functions').find_style()<cr>", desc = "color scheme" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "old files" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
    { "<leader>fg", "<cmd>Telescope grep_string<cr>", desc = "grep string" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "buffers" },
    { "<leader>s", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "current buffer fuzzy find" },

    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "git branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "git commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "git status" },
    -- { "<leader>gs", "<cmd>Telescope git_stash<cr>", desc = "git stash" },
    { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "git files" },

    { "<leader>ir", "<cmd>Telescope registers<cr>", desc = "registers" },
    { "<leader>it", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>ic", "<cmd>Telescope commands<cr>", desc = "commands" },
    { "<leader>i;", "<cmd>Telescope command_history<cr>", desc = "commands history" },
    { "<leader>i/", "<cmd>Telescope search_history<cr>", desc = "search history" },
    { "<leader>is", "<cmd>Telescope possession list<cr>", desc = "sessions" },
    { "<leader>im", "<cmd>Telescope marks<cr>", desc = "marks" },
    { "<leader>ij", "<cmd>Telescope jumplist<cr>", desc = "jump list" },
    { "<leader>ih", "<cmd>Telescope help_tags<cr>", desc = "help tags" },
    { "<leader>w", "<cmd>Telescope spell_suggest<cr>", desc = "spell suggest" },
  },
  dependencies = {
    {"nvim-lua/plenary.nvim"},
    -- {"nvim-telescope/telescope-project.nvim"},
    {'jedrzejboczar/possession.nvim'}
  },

  -- apply the config and additionally load fzf-native
  config = function()
    -- require('telescope').load_extension('aerial')
    require('telescope').load_extension('possession')
    require('telescope').setup{
      defaults = {
        -- winblend = 0,
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
        selection_caret = " ",
        entry_prefix = " ",
        color_devicons = true,
        -- file_ignore_patterns = { "node_modules" },
        -- theme
        layout_strategy = "bottom_pane",
        -- config
        layout_config = {
          bottom_pane = {
            height = 15,
            preview_cutoff = 100,
            prompt_position = "bottom",
          },
        },
      },
      pickers = {
        current_buffer_fuzzy_find = {
          initial_mode="insert",
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
          mappings = {
            --     i = {
              --       ["<c-d>"] = "delete_buffer",
              --     },
              -- n = {
                -- },
              },
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
          },
        }

      end,
    }

local neotree={
  "nvim-neo-tree/neo-tree.nvim",
  -- lazy=false,
  -- event = "InsertEnter",
  keys = {
    { "<leader>ee", "<cmd>NeoTreeFocusToggle<cr>", desc = "File tree" },
    { "<leader>ef", "<cmd>NeoTreeFloatToggle<cr>", desc = "File tree float" },
    { "<leader>eb", "<cmd>Neotree toggle=true float source=buffers<cr>", desc = "buffers float" },
    { "<leader>en", "<cmd>Neotree toggle=true float dir="..vim.fn.stdpath("config").." <cr>", desc = "nvim file float" },
    { "<leader>eg", "<cmd>Neotree toggle=true float dir=~/github<cr>", desc = "win github file float" },
    { "<leader>eG", "<cmd>Neotree toggle=true float dir=~/Github_arch<cr>", desc = "arch Github file float" },
    { "<leader>ep", "<cmd>Neotree toggle=true float dir=~/documents/Projects <cr>", desc = "Projects file float" },
    { "<leader>ed", "<cmd>Neotree toggle=true float dir=~/documents<cr>", desc = "documents file float" },
    { "<leader>eh", "<cmd>Neotree toggle=true float dir=~<cr>", desc = "home file float" },
    { "<leader>eo", "<cmd>Neotree toggle=true float dir=~/documents/obsidian<cr>", desc = "obsidian file float" },
    { "<leader>gs", "<cmd>Neotree source=git_status <cr>", desc = "git_status" },
  },
  dependencies = {
    {"nvim-lua/plenary.nvim"},
    {"MunifTanjim/nui.nvim"},
    {
      's1n7ax/nvim-window-picker',
      config = function()
        require'window-picker'.setup({
          autoselect_one = true,
          include_current = false,
        })
      end,
    }
  },
  config=function()
    require("neo-tree").setup({
      close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      sort_case_insensitive = false, -- used when sorting files and directories in the tree
      default_component_configs = {
        container = {
          enable_character_fade = true
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- expander config, needed for nesting files
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰉖",
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "✖",-- this can only be used in the git_status source
            renamed   = "",-- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored   = "◌",
            unstaged  = "✗",
            staged    = "✓",
            conflict  = "",
          }
        },
      },
      -- A list of functions, each representing a global custom command
      -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
      -- see `:h neo-tree-global-custom-commands`
      commands = {},
      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["l"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
          },
          ["<2-LeftMouse>"] = "open",
          ["<cr>"] = "open",
          -- ["<esc>"] = "revert_preview",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["L"] = "focus_preview",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["S"] = "split_with_window_picker",
          ["V"] = "vsplit_with_window_picker",
          ["t"] = "open_tabnew",
          ["h"] = "close_node",
          ["z"] = "close_all_nodes",
          --["Z"] = "expand_all_nodes",
          ["a"] = {
            "add",
            config = {
              show_path = "none" -- "none", "relative", "absolute"
            }
          },
          ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
          ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
          ["q"] = "close_window",
          ["<esc>"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
          -- ["D"] = "fuzzy_sorter_directory",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        }
      },
      filesystem = {
        -- bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        cwd_target = {
          sidebar = "tab",   -- sidebar is when position = left or right
          current = "window" -- current is when position = current
        },
        -- time the current file is changed while the tree is open.
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      },
      buffers = {
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
          mappings = {
            ["d"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["S"] = "split_with_window_picker",
            ["V"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
          }
        },
      },
      git_status = {
        window = {
          position = "float",
          mappings = {
            ["a"]  = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["<space>"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["c"] = "git_commit",
            ["p"] = "git_push",
            ["gg"] = "git_commit_and_push",
          }
        }
      }
    })
  end,
}

local possession ={
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
        on_load = false,
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
}

local spec ={tele,neotree,possession}

return spec
