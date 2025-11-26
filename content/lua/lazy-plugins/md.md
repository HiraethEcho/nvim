---
title: md
---
# markdown plugin

enhance markdown

```lua
return {
  -- render
  { -- markview
    "OXY2DEV/markview.nvim",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "markdown", "md", "codecompanion" },
    keys = {
      { "<C-e>", "<cmd>Markview Toggle<cr>", desc = "Markiview toggle" },
    },
    opts = {
      experimental = { check_rtp = false },
      preview = {
        filetypes = { "markdown", "codecompanion" },
      },
    },
  },
  { -- MeanderingProgrammer/render-markdown.nvim
    "MeanderingProgrammer/render-markdown.nvim",
    -- enabled = false,
    ft = { "markdown", "md", "codecompanion", "Avante", "copilot-chat" },
    keys = {
      { "<C-e>", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown Render Toggle" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      file_types = { "markdown", "codecompanion", "Avante", "copilot-chat", "opencode-output" },
      heading = { border = false, render_modes = true },
      bullet = { render_modes = false },
      anti_conceal = {
        ignore = {
          bullet = false,
          head_border = true,
          head_background = true,
        },
      },
      -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
      win_options = { concealcursor = { rendered = "nvc" } },
      checkbox = {
        right_pad = 0,
        custom = {
          doing = { raw = "[>]", rendered = "󰁕 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
          deleted = { raw = "[-]", rendered = "󰅙 ", highlight = "DiagnosticWarning", scope_highlight = nil },
        },
      },
      code = { width = "block", min_width = 30, position = "right" },
    },
  },
  -- enhance
  { -- jakewvincent/mkdnflow.nvim
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    -- cmd = { "Mkdnflow", },
    config = function()
      require("mkdnflow").setup({
        modules = {
          bib = true,
          buffers = true,
          conceal = false,
          cursor = true,
          folds = true,
          foldtext = true,
          links = true,
          lists = true,
          maps = true,
          paths = true,
          tables = true,
          yaml = true,
          cmp = false,
        },
        perspective = {
          priority = "root",
          fallback = "current",
          root_tell = ".obsidian",
          nvim_wd_heel = false,
          update = true,
        },
        silent = false,
        to_do = {
          symbols = { " ", "x", ">", "-" },
          update_parents = true,
          not_started = " ",
          in_progress = ">",
          complete = "x",
          deleted = "-",
        },
        mappings = {
          MkdnTab = { "i", "<c-l>" },
          MkdnSTab = { "i", "<c-h>" },
          MkdnNextLink = { "n", "]l" },
          MkdnPrevLink = { "n", "[l" },
          MkdnCreateLink = { "v", "<leader>mA" },
          MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>mL" },
          MkdnDestroyLink = { "n", "<leader>md" },
          MkdnMoveSource = { "n", "<leader>mm" },
          MkdnYankAnchorLink = { "n", "<leader>my" },
          MkdnYankFileAnchorLink = { "n", "<leader>mY" },
          MkdnIncreaseHeading = { "n", "-" },
          MkdnDecreaseHeading = { "n", "=" },
          MkdnToggleToDo = { { "n" }, "X" },
          MkdnNewListItem = { "i", "<c-o>" },
          MkdnNewListItemBelowInsert = { "n", "o" },
          MkdnNewListItemAboveInsert = { "n", "O" },
          MkdnUpdateNumbering = { "n", "<leader>mn" },
          MkdnTableFormat = { "n", "<leader>mt" },
          MkdnTableNewRowBelow = { "n", "<leader>mj" },
          MkdnTableNewRowAbove = { "n", "<leader>mk" },
          MkdnTableNewColAfter = { "n", "<leader>ml" },
          MkdnTableNewColBefore = { "n", "<leader>mh" },
          MkdnFollowLink = { { "n", "v" }, "<leader>ma" },
          -- MkdnNextHeading             = {'n', ']]'},
          -- MkdnPrevHeading             = {'n', '[['},
          -- MkdnGoBack                  = {'n', '<BS>'},
          -- MkdnGoForward               = {'n', '<Del>'},
          -- MkdnTableNextRow = { "i", "<c-j>" },
          -- MkdnTablePrevRow = { "i", "<c-k>" },
          MkdnTableNextRow = false,
          MkdnTablePrevRow = false,
          -- MkdnFollowLink = false,
          MkdnEnter = false,
          MkdnNextHeading = false,
          MkdnPrevHeading = false,
          MkdnGoBack = false,
          MkdnGoForward = false,
          MkdnFoldSection = false,
          MkdnExtendList = false,
          MkdnTableNextCell = false,
          MkdnTablePrevCell = false,
          MkdnUnfoldSection = false,
        },
        foldtext = {
          title_transformer = function()
            return function(text)
              local updated_title = text:gsub("%b{}", "")
              updated_title = updated_title:gsub("^%s*", "")
              updated_title = updated_title:gsub("%s*$", "")
              updated_title = updated_title:gsub("^######", "h6")
              updated_title = updated_title:gsub("^#####", "h5")
              updated_title = updated_title:gsub("^####", "h4")
              updated_title = updated_title:gsub("^###", "h3")
              updated_title = updated_title:gsub("^##", "h2")
              updated_title = updated_title:gsub("^#", "h1")
              return updated_title
            end
          end,
          object_count_icon_set = "nerdfont",
          object_count_opts = function()
            return {
              link = false,
              blockquote = { icon = " ", count_method = { pattern = { "^>.+$" }, tally = "blocks" } },
              fncblk = { icon = " " },
            }
          end,
          line_count = true,
          word_count = true,
          fill_chars = {
            left_edge = "╾─",
            right_edge = "──╼",
            item_separator = " · ",
            section_separator = " // ",
            left_inside = " ┝",
            right_inside = "┥ ",
            middle = "─",
          },
        },
      })
    end,
  },
}
```
