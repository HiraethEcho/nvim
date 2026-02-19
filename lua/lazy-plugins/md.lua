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
  { -- yelog/marklive.nvim
    "yelog/marklive.nvim",
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = { { "<C-e>", "<cmd>MarkliveToggle<cr>", desc = "Markiview toggle", ft = "markdown" } },
    ft = "markdown",
    config = true,
  },
  { -- iamcco/markdown-preview.nvim
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    -- build = function() vim.fn["mkdp#util#install"]() end,
    enabled = false,
    -- ft = { "markdown" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "markdown Html Preview" },
    },
    config = function()
      if vim.g.is_linux then
        vim.g.mkdp_browser = "qutebrowser"
      end
      -- vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/colors/markdown.css"
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_filetypes = { "markdown", "md" }
    end,
  },
  -- enhance
  { -- "yousefhadder/markdown-plus.nvim",
    "yousefhadder/markdown-plus.nvim",
    enabled = false,
    ft = "markdown", -- Load on markdown files by default
    config = function()
      require("markdown-plus").setup({
        enabled = true,
        features = {
          list_management = true, -- Enable list management features
          text_formatting = true, -- Enable text formatting features
          headers_toc = true, -- Enable headers and TOC features
          links = true, -- Enable link management features
        },
        keymaps = {
          enabled = true, -- Enable default keymaps
        },
        filetypes = { "markdown" }, -- Filetypes to enable the plugin for
      })
    end,
  },
  { -- jakewvincent/mkdnflow.nvim
    "jakewvincent/mkdnflow.nvim",
    -- enabled = false,
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
        --[[ to_do = {
          symbols = { " ", "x", ">", "-" },
          update_parents = true,
          not_started = " ",
          in_progress = ">",
          complete = "x",
          deleted = "-",
        }, ]]
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
      })
    end,
  },
  { -- antonk52/markdowny.nvim
    "antonk52/markdowny.nvim",
    enabled = false,
    ft = { "md", "markdown" },
    config = function()
      require("markdowny").setup()
      vim.keymap.set("v", "<C-e>", ":lua require('markdowny').bold()<cr>", { buffer = 0 })
      vim.keymap.set("v", "<C-i>", ":lua require('markdowny').italic()<cr>", { buffer = 0 })
      -- vim.keymap.set("v", "<C-l>", ":lua require('markdowny').link()<cr>", { buffer = 0 })
      -- vim.keymap.set("v", "<C-k>", ":lua require('markdowny').code()<cr>", { buffer = 0 })
    end,
  },
  { -- epwalsh/obsidian.nvim
    "epwalsh/obsidian.nvim",
    enabled = false,
    event = { "BufRead " .. vim.fn.expand("~") .. "/obsidian/**.md" },
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search in Obsidian" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Templates in Obsidian" },
      { "<leader>ob", "<cmd>ObsidianBacklink<cr>", desc = "Backlink" },
      { "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/obsidian/",
        },
      },
      completion = {
        nvim_cmp = false,
        min_chars = 2,
      },
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "current_dir",

      -- Optional, customize how wiki links are formatted. You can set this to one of:
      --  * "use_alias_only", e.g. '[[Foo Bar]]'
      --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
      --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      --  * "use_path_only", e.g. '[[foo-bar.md]]'
      -- Or you can set it to a function that takes a table of options and returns a string, like this:

      -- Optional, customize how markdown links are formatted.
      markdown_link_func = function(opts)
        return require("obsidian.util").markdown_link(opts)
      end,

      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "markdown",

      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = false,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = true,

      -- Optional, sort search results by "path", "modified", "accessed", or "created".
      -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
      -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
      sort_by = "modified",
      sort_reversed = true,

      -- Optional, determines how certain commands open notes. The valid options are:
      -- 1. "current" (the default) - to always open in the current window
      -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
      -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
      open_notes_in = "vsplit",

      -- Optional, configure additional syntax highlighting / extmarks.
      -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
      ui = {
        enable = true, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        block_ids = { hl_group = "ObsidianBlockID" },
      },

      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "assets", -- This is the default
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      -- see also: 'follow_url_func' config option above.
    end,
  },
  { -- Zeioth/markmap.nvim
    "Zeioth/markmap.nvim",
    cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    opts = {
      html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
      hide_toolbar = false, -- (default)
      grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
    },
    config = function(_, opts)
      require("markmap").setup(opts)
    end,
  },
  { -- 3rd/image.nvim
    "3rd/image.nvim",
    build = false,
    enabled = false,
    keys = {
      {
        "<leader>up",
        function()
          local image = require("image")
          if image.is_enabled() then
            image.disable()
          else
            image.enable()
          end
        end,
        desc = "show pictures",
      },
    },
    opts = {
      integrations = {
        markdown = {
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = "inline",
        },
      },
    },
  },
  { -- HakonHarnes/img-clip.nvim
    "HakonHarnes/img-clip.nvim",
    enabled = false,
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = { insert_mode = true },
        use_absolute_path = false,
      },
    },
    keys = {
      { "<leader>mP", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
