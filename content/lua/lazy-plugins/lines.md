---
title: lines
---

# UI

ui plugins that decorate lines, like tabline, bufferline, command line, status line, vertical line, etc.

```lua
return {
  -- top and bottom
  { -- lualine
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local function cwd_fancy()
        local result = vim.fn.getcwd()
        local home = os.getenv("HOME")
        if home and vim.startswith(result, home) then
          result = "~" .. result:sub(home:len() + 1)
        end
        return result
      end
      -- vim.cmd("colorscheme github_dark")
      require("lualine").setup({
        extensions = { "quickfix" },
        options = {
          theme = "OceanicNext",
          disabled_filetypes = {
            statusline = {
              "neo-tree",
              "sagaoutline",
              "Outline",
              "undotree",
            },
          },
        },
        sections = {
          lualine_a = {
          },
          lualine_b = {
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
              newfile_status = true, -- Display new file status (new file means no write after created)
              path = 1,
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_c = {
            "diff",
          },
          lualine_x = {
              function()
                if not vim.g.loaded_mcphub then
                  return "󰐻 -"
                end
                local count = vim.g.mcphub_servers_count or 0
                local status = vim.g.mcphub_status or "stopped"
                local executing = vim.g.mcphub_executing
                if status == "stopped" then
                  return "󰐻 -"
                end
                if executing or status == "starting" or status == "restarting" then
                  local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                  local frame = math.floor(vim.loop.now() / 100) % #frames + 1
                  return "󰐻 " .. frames[frame]
                end
                return "󰐻 " .. count
              end,
              color = function()
                if not vim.g.loaded_mcphub then
                  return { fg = "#18181f" } -- Gray for not loaded
                end
                local status = vim.g.mcphub_status or "stopped"
                if status == "ready" or status == "restarted" then
                  return { fg = "#50fa7b" } -- Green for connected
                elseif status == "starting" or status == "restarting" then
                  return { fg = "#ffb86c" } -- Orange for connecting
                else
                  return { fg = "#ff5555" } -- Red for error/stopped
                end
              end,
            }, ]]
          },
          lualine_y = {
            { "%l/%L:%c" },
          },
          lualine_z = {
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
              newfile_status = true, -- Display new file status (new file means no write after created)
              path = 0, -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              shorting_target = 40, -- Shortens path to leave 40 spaces in the window
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { "progress" },
          lualine_z = {},
        },
        winbar = {},
        tabline = {
          lualine_a = {
            {
              "tabs",
              max_length = vim.o.columns / 3, -- Maximum width of tabs component.
              mode = 1, -- 0: Shows tab_nr
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
              -- 1: Shows tab_name
              -- 2: Shows tab_nr + tab_name
            },
          },
          lualine_b = {
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          },
          lualine_c = {
            {
              "buffers",
              show_filename_only = true, -- Shows shortened relative path when set to false.
              hide_filename_extension = true,
              show_modified_status = false, -- Shows indicator when the buffer is modified.
              mode = 2, -- 0: Shows buffer name 1: Shows buffer index 2: Shows buffer name + buffer index 3: Shows buffer number 4: Shows buffer name + buffer number
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
                alternate_file = "", -- Text to show to identify the alternate file
              },
            },
          },
          lualine_x = {
            "lsp_status",
          },
          lualine_y = {
            cwd_fancy,
          },
          lualine_z = {
            "branch",
            {
              function()
                return require("auto-session.lib").current_session_name(true)
              end,
            },
          },
        },
      })
      vim.keymap.set("n", "<C-1>", "<cmd>LualineBuffersJump 1<CR>")
      vim.keymap.set("n", "<C-2>", "<cmd>LualineBuffersJump 2<CR>")
      vim.keymap.set("n", "<C-3>", "<cmd>LualineBuffersJump 3<CR>")
      vim.keymap.set("n", "<C-4>", "<cmd>LualineBuffersJump 4<CR>")
      vim.keymap.set("n", "<C-5>", "<cmd>LualineBuffersJump 5<CR>")
      vim.keymap.set("n", "<C-6>", "<cmd>LualineBuffersJump 6<CR>")
      vim.keymap.set("n", "<C-7>", "<cmd>LualineBuffersJump 7<CR>")
      vim.keymap.set("n", "<C-8>", "<cmd>LualineBuffersJump 8<CR>")
      vim.keymap.set("n", "<C-9>", "<cmd>LualineBuffersJump 9<CR>")
      vim.keymap.set("n", "<C-0>", "<cmd>LualineBuffersJump 10<CR>")
    end,
  },
  -- inside horizontal
  { -- "mvllow/modes.nvim",
    "mvllow/modes.nvim",
    enabled = false,
    tag = "v0.2.0",
    event = "InsertEnter",
    config = function()
      require("modes").setup({
        colors = {
          bg = "", -- Optional bg param, defaults to Normal hl group
          copy = "#f5c359",
          delete = "#c75c6a",
          insert = "#78ccc5",
          visual = "#9745be",
        },
        -- Set opacity for cursorline and number background
        line_opacity = 0.2,
      })
    end,
  },
}
```
