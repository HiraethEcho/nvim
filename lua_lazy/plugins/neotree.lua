return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>ee" , "<cmd>Neotree position=left toggle=true<cr>"                             , desc = "File tree"              } ,
    { "<leader>ef" , "<cmd>Neotree float toggle=true<cr>"                                     , desc = "File tree float"        } ,
    { "<leader>eb" , "<cmd>Neotree toggle=true float source=buffers<cr>"                      , desc = "buffers float"          } ,
    { "<leader>en" , "<cmd>Neotree toggle=true float dir="..vim.fn.stdpath("config").." <cr>" , desc = "nvim file float"        } ,
    { "<leader>eg" , "<cmd>Neotree toggle=true float dir=~/github<cr>"                        , desc = "win github file float"  } ,
    { "<leader>eG" , "<cmd>Neotree toggle=true float dir=~/Github_arch<cr>"                   , desc = "arch Github file float" } ,
    { "<leader>ep" , "<cmd>Neotree toggle=true float dir=~/documents/Projects <cr>"           , desc = "Projects file float"    } ,
    { "<leader>ed" , "<cmd>Neotree toggle=true float dir=~/documents<cr>"                     , desc = "documents file float"   } ,
    { "<leader>eo" , "<cmd>Neotree toggle=true float dir=~/obsidian<cr>"                      , desc = "obsidian file float"    } ,
    { "<leader>es" , "<cmd>Neotree toggle=true float dir=~/site<cr>"                          , desc = "site file float"        } ,
    { "<leader>eh" , "<cmd>Neotree toggle=true float dir=~<cr>"                               , desc = "home file float"        } ,
    { "<leader>gs" , "<cmd>Neotree source=git_status <cr>"                                    , desc = "git_status"             } ,
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
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
      use_libuv_file_watcher = true,
    },
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
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
        ["zM"] = "close_all_nodes",
        ["zR"] = "expand_all_nodes",
        ["a"] = {
          "add",
          config = {
            show_path = "none" -- "none", "relative", "absolute"
          }
        },
        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
        ["D"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["d"] = "cut_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        -- ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        -- ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
        ["q"] = "close_window",
        ["<esc>"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        -- ["H"] = "toggle_hidden",
        ["zh"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        -- ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      }
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰉖",
      },
      git_status = {
        symbols = {
          added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "✖",-- this can only be used in the git_status source
          renamed = "󰁕",
          -- Status type
          untracked = "",
          ignored   = "◌",
          unstaged  = "✗",
          staged    = "✓",
          conflict  = "",
        }
      },
    },
  }
}
