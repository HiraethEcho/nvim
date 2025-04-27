return {
  {
    "lervag/vimtex",
    lazy =false,
    -- enabled = false,
    -- ft = { "bib", "tex" },
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      -- vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_imaps_leader = ';'

      -- this works
      -- vim.g.vimtex_view_general_viewer = "okular"
      -- vim.g.vimtex_view_general_options = [[ --unique file:@pdf\#src:@line@tex]]
      -- in okular, set 'nvr --remote-silent +%l %f' in settings - configure - editor

      -- vim.g.vimtex_syntax_enabled = 1
      -- vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_fold_enabled = 1
      -- vim.g.vimtex_indent_enabled = 0           -- turn off vimtex indentation
      -- vim.g.vimtex_mappings_enabled = 0         -- disable default mappings
      -- vim.g.vimtex_imaps_enabled = 0            -- disable insert mode mappings (I use UltiSnips)
      -- vim.g.vimtex_complete_enabled = 0         -- turn off completion (not currently used so more efficient to turn off)
      -- vim.g.vimtex_fold_manual=0
      -- vim.g.vimtex_fold_levelmarker      =1
      -- vim.g.vimtex_fold_types            =1
      -- vim.g.vimtex_fold_types_defaults   =1
      -- vim.g.vimtex_fold_bib_enabled      =1
      -- vim.g.vimtex_fold_bib_max_key_width=1

      vim.g.vimtex_toc_config = {
        name = "TOC",
        layers = { "label", "todo", "include", "content" },
        split_width = 30,
        todo_sorted = 1,
        show_help = 1,
        show_numbers = 2,
      }

      vim.g.vimtex_quickfix_enabled = 0
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull \\\\hbox",
        "Overfull \\\\hbox",
        "LaTeX Warning:  float specifier changed to",
        "LaTeX Warning: The counter will not be printed",
        "LaTeX Warning: Marginpair on page ",
        "LaTeX Font Warning: Font shape ",
        "LaTeX hooks Warning",
        'Package siunitx Warning: Detected the "physics" package:',
        "Package hyperref Warning: Token not allowed in a PDF string",
      }
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    dependencies = {
      "saghen/blink.cmp"
    },
    ft = { "markdown", "md" },
    keys = {
      { "<C-e>", "<cmd>Markview<cr>", desc = "Markiview toggle", ft = "markdown" },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = false,
    -- ft = { "markdown", "md" },
    --[[ keys = {
      { "<C-e>", "<cmd>RenderMarkdown toggle<cr>", desc = "Markiview toggle", ft = "markdown" },
    }, ]]
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      completions = { blink = { enabled = true } },
      heading = {
        width = 'block',
      },
      latex = {
        enabled = true,
      },
    },
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    -- cmd = { "Mkdnflow", },
    -- lazy=false,
    config = function()
      require("mkdnflow").setup({
        perspective = {
          priority = "root",
          fallback = "current",
          root_tell = ".obsidian",
          nvim_wd_heel = false,
          update = true,
        },
        silent = false,
        to_do = {
          symbols = { " ", "x" },
          update_parents = true,
          not_started = " ",
          -- in_progress = "-",
          complete = "x",
        },
        mappings = {
          MkdnTab = { "i", "<c-l>" },
          MkdnSTab = { "i", "<c-h>" },
          MkdnNextLink = { "n", "]l" },
          MkdnPrevLink = { "n", "[l" },
          MkdnFollowLink = { { "n", "v" }, "<leader>ma" },
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
          MkdnTableNextRow = { "i", "<c-j>" },
          MkdnTablePrevRow = { "i", "<c-k>" },
          MkdnTableNewRowBelow = { "n", "<leader>mj" },
          MkdnTableNewRowAbove = { "n", "<leader>mk" },
          MkdnTableNewColAfter = { "n", "<leader>ml" },
          MkdnTableNewColBefore = { "n", "<leader>mh" },
          -- MkdnNextHeading             = {'n', ']]'},
          -- MkdnPrevHeading             = {'n', '[['},
          -- MkdnGoBack                  = {'n', '<BS>'},
          -- MkdnGoForward               = {'n', '<Del>'},
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
  {
    'chomosuke/typst-preview.nvim',
    -- lazy = false, -- or
    ft = 'typst',
    version = '1.*',
    opts = {
      dependencies_bin = {
        ['tinymist'] = 'tinymist',
        ['websocat'] = 'websocat',
      },
    }, -- lazy.nvim will implicitly calls `setup {}`
  },
  -- disabled
  {
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
  {
    "epwalsh/obsidian.nvim",
    -- lazy=false,
    enabled = false,
    event = { "BufRead " .. vim.fn.expand("~") .. "/Documents/obsidian/**.md" },
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<cr>",       desc = "Open Obsidian" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>",     desc = "Search in Obsidian" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>",   desc = "Templates in Obsidian" },
      { "<leader>ob", "<cmd>ObsidianBacklink<cr>",   desc = "Backlink" },
      { "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts =
    {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/obsidian/",
        },
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
      -- way then set 'mappings = {}'.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        }
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
      wiki_link_func = function(opts)
        return require("obsidian.util").wiki_link_id_prefix(opts)
      end,

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

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-l>",
        },
      },

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
        enable = true,          -- set to false to disable all additional syntax features
        update_debounce = 200,  -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianImportant = { bold = true, fg = "#d73128" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },

      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "assets/imgs", -- This is the default
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      -- see also: 'follow_url_func' config option above.
    end,
  },
  {
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
}
