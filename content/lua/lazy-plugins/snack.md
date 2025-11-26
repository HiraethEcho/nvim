---
title: snack
---

# snack

folke's great snack, so many functions.

The feature I don't use:

- dashboard, see [/lua/lazy-plugins/start.lua](/lua/lazy-plugins/start)


```lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    -- "Shatur/neovim-session-manager",
    -- "echasnovski/mini.sessions",
  },
  opts = {
    bigfile = { enabled = true },
    image = {
      enabled = true,
      force = true,
      doc = { enabled = true, inline = false, float = true },
      math = {
        enabled = false,
        typst = {
          tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
        },
        latex = {
          font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
          -- for latex documents, the doc packages are included automatically,
          -- but you can add more packages here. Useful for markdown documents.
          packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
          color = "#ffffff",
          tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
        },
      },
    },
    dashboard = { enabled = false, },
    explorer = { enabled = true },
    indent = {
      enabled = false,
      animate = { enabled = false },
      indent = { enabled = true },
      scope = { enabled = false },
      chunk = {
        enabled = true,
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
        },
        hl = { "SnacksIndent1", "SnacksIndent2", "SnacksIndent3", "SnacksIndent4", "SnacksIndent5", "SnacksIndent6", "SnacksIndent7", "SnacksIndent8", },
      },
    },
    input = { enabled = true },
    notifier = { enabled = false },
    picker = {
      ui_select = true,
      sources = {
        explorer = {
          -- layout = { layout = { position = "right" } },
          win = {
            list = {
              keys = {
                ["."] = "tcd",
                ["zh"] = "toggle_hidden",
                ["s"] = "edit_split",
                ["v"] = "edit_vsplit",
                ["<c-u>"] = { "preview_scroll_up" },
                ["<c-d>"] = { "preview_scroll_down" },
                ["w"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
              },
            },
          },
        },
        buffers = { layout = { preset = "ivy" } },
        colorschemes = { layout = { preset = "bottom" } },
      },
      layout = { cycle = false },
      matcher = { frecency = true, history_bonus = true },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n" } },
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-b>"] = { "list_scroll_up", mode = { "i", "n" } },
            ["<c-f>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["s"] = { "flash", mode = { "n" } },
            -- ["<C-S>"] = { "flash", mode = { "n", "i" } },
          },
        },
      },
      actions = {
        flash = function(picker)
          require("flash").jump({
            pattern = "^",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end,
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    debug = { enabled = false },
    scroll = { enabled = false },
    lazygit = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    zen = {
      zoom = {
        toggles = {},
        show = { statusline = true, tabline = false },
      },
      toggles = {
        dim = false,
        git_signs = true,
        mini_diff_signs = true,
        diagnostics = true,
      },
    },
    styles = {
      notification = { wo = { wrap = true } },
      snacks_image = { relative = "editor", col = -1, row = 1 },
    },
  },
  -- stylua: ignore
  keys = {
    -- Top Pickers & Explorer
    { "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>X", function() Snacks.bufdelete.other() end, desc = "Delete other Buffers" },
    { "<leader>Q", function() Snacks.bufdelete.delete() end, desc = "Delete Buffer" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>P", function() Snacks.picker.pick() end, desc = "pickers" },
    { "<leader>p", function() Snacks.picker.resume() end, desc = "Resume" },
    -- find
    { "<leader>ff", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- git
    { "<leader>gw", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash", },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    -- search
    { '<leader>"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    -- { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons", },
    { "<leader>j", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>M", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>sc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- Other
    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    { "<leader>gR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "<leader>nn", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    -- { "]]",         function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",            mode = { "n", "t" }, },
    -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",            mode = { "n", "t" }, },
    {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.inlay_hints():map("<leader>uI")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>uB")
        Snacks.toggle.animate():map("<leader>ua")
        Snacks.toggle.scroll():map("<leader>us")
        Snacks.toggle.words():map("<leader>uW")
      end,
    })
  end,
}
```
