---
title: filemanager
---

# file managers

- [snack](/lua/lazy-plugins/snack) has a file manager
- use yazi in float terminal
- mini.files can edit files as a buffer. that is cool

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
}
```
