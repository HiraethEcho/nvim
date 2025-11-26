---
title: filemanager
---
```lua
return {
  { -- "mikavilpas/yazi.nvim",
    "mikavilpas/yazi.nvim",
    keys = {
      { "<leader>R", "<cmd>Yazi<cr>", desc = "Open yazi at the current file", },
      -- { "<leader>r", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory", },
      { '<leader>r', "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
        open_file_in_vertical_split = '<c-v>',
        open_file_in_horizontal_split = '<c-s>',
        open_file_in_tab = '<c-t>',
        change_working_directory = 'H',
        -- grep_in_directory = '<c-s>',
        -- replace_in_directory = '<c-g>',
        cycle_open_buffers = '<tab>',
        -- copy_relative_path_to_selected_files = '<c-y>',
        send_to_quickfix_list = '<c-q>',
      },
    },
  },
  { -- "echasnovski/mini.files",
    "echasnovski/mini.files",
    -- version = false,
    -- enabled = false,
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
        use_as_default_explorer = false,
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
  -- disable
  { -- "nvim-neo-tree/neo-tree.nvim",
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    keys = {
      -- { "<leader>e", "<cmd>Neotree float<cr>",                desc = "File tree float", },
      { "<leader>e", "<cmd>Neotree position=left toggle<cr>", desc = "File tree", },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "MunifTanjim/nui.nvim" },
      {
        "s1n7ax/nvim-window-picker",
        config = function()
          require("window-picker").setup({
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
        -- bind_to_cwd = true,
        follow_current_file = {
          enabled = true,          -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      commands = {
        system_open = function(state)
          require("util").system_open(state.tree:get_node():get_id())
        end,
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify
          local results = {
            f = { val = filename, msg = "Filename" },
            F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
            h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
            P = { val = filepath, msg = "Absolute path" },
          }

          local messages = {
            { "\nChoose to copy to clipboard:\n", "Normal" },
          }
          for i, result in pairs(results) do
            if result.val and result.val ~= "" then
              vim.list_extend(messages, {
                { ("%s."):format(i),           "Identifier" },
                { (" %s: "):format(result.msg) },
                { result.val,                  "String" },
                { "\n" },
              })
            end
          end
          vim.api.nvim_echo(messages, false, {})
          local result = results[vim.fn.getcharstr()]
          if result and result.val and result.val ~= "" then
            utils.notify(("Copied: `%s`"):format(result.val))
            vim.fn.setreg("+", result.val)
          end
        end,
      },
      window = {
        mappings = {
          o = "system_open",
          Y = "copy_selector",
          ["l"] = "toggle_node",
          ["<2-LeftMouse>"] = "open",
          ["<cr>"] = "open",
          -- ["<esc>"] = "revert_preview",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["<C-u>"] = { "scroll_preview", config = { direction = 10 } },
          ["<C-d>"] = { "scroll_preview", config = { direction = -10 } },
          ["<space>"] = "focus_preview",
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
              show_path = "none", -- "none", "relative", "absolute"
            },
          },
          -- ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
          ["D"] = "delete",
          ["r"] = "rename",
          ["yy"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["d"] = "",
          ["z"] = "",
          ["p"] = "paste_from_clipboard",
          ["q"] = "close_window",
          ["<esc>"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<bs>"] = "navigate_up",
          ["H"] = "set_root",
          ["zh"] = "toggle_hidden",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
          -- ['<key>'] = function(state, scroll_padding) ... end,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,          -- This will find and focus the file in the active buffer every time
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        window = {
          mappings = {
            ["d"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["z"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            ["zc"] = { "order_by_created", nowait = false },
            ["zd"] = { "order_by_diagnostics", nowait = false },
            ["zm"] = { "order_by_modified", nowait = false },
            ["zn"] = { "order_by_name", nowait = false },
            ["zs"] = { "order_by_size", nowait = false },
            ["zt"] = { "order_by_type", nowait = false },
          }
        },
      },
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰉖",
        },
      },
    },
  },
  { -- 'stevearc/oil.nvim',
    'stevearc/oil.nvim',
    enabled = false,
    cmd = "Oil",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
}
```
