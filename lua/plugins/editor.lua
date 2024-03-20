local vim = vim
return {
  {
    "lervag/vimtex",
    ft = { "bib", "tex" },
    config = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_view_general_options = ""
      vim.g.tex_comment_nospell = 1
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_quickfix_enabled = 0

      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 0,
        spacing = 0,
        greek = 0,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 0,
        math_super_sub = 0,
        math_symbols = 0,
        sections = 1,
        styles = 1,
      }
      vim.g.vimtex_toc_config = {
        name = "TOC",
        layers = { "label", "todo", "include", "content" },
        split_width = 30,
        todo_sorted = 1,
        show_help = 1,
        show_numbers = 2,
      }
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
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    enabled = false,
    -- ft = { "markdown" },
    keys = {
      { "<leader>mP", "<cmd>MarkdownPreviewToggle<cr>", desc = "markdown Html Preview" },
    },
    config = function()
      if vim.g.is_linux then
        vim.g.mkdp_browser = "surf"
      end
      vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/colors/markdown.css"
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_filetypes = { "markdown", "md" }
    end,
  },
  {
    "rhysd/nyaovim-markdown-preview",
    enabled = false,
    keys = {
      { "<leader>mP", "<cmd>StartMarkdownPreview<cr>", desc = "markdown Html Preview" },
    },
    ft = { "markdown" },
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    cmd = {
      "Mkdnflow",
    },
    -- lazy=false,
    config = function()
      require("mkdnflow").setup({
        modules = {
          bib = true,
          buffers = true,
          conceal = true,
          cursor = true,
          folds = false,
          links = true,
          lists = true,
          maps = true,
          paths = true,
          tables = true,
          yaml = true,
        },
        filetypes = { md = true, rmd = true, markdown = true },
        create_dirs = true,
        perspective = {
          priority = "current",
          fallback = "current",
          root_tell = false,
          nvim_wd_heel = true,
          update = true,
        },
        wrap = false,
        bib = {
          default_path = nil,
          find_in_root = true,
        },
        silent = false,
        links = {
          style = "markdown",
          conceal = false,
          context = 0,
          implicit_extension = nil,
          transform_implicit = false,
          transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            -- text = text..os.date('_%Y-%m-%d')
            return text
          end,
        },
        to_do = {
          symbols = { " ", "-", "x" },
          update_parents = true,
          not_started = " ",
          in_progress = "-",
          complete = "x",
        },
        tables = {
          trim_whitespace = true,
          format_on_move = true,
          auto_extend_rows = false,
          auto_extend_cols = false,
        },
        yaml = {
          bib = { override = false },
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
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
    keys = {
      { "<leader>mp", "<cmd>Glow<cr>", desc = "markdown Glow Preview" },
    },
  },
  {
    "antonk52/markdowny.nvim",
    ft = { "md", "markdown" },
    config = function()
      require("markdowny").setup()
      vim.keymap.set("v", "<C-b>", ":lua require('markdowny').bold()<cr>", { buffer = 0 })
      vim.keymap.set("v", "<C-i>", ":lua require('markdowny').italic()<cr>", { buffer = 0 })
      vim.keymap.set("v", "<C-k>", ":lua require('markdowny').link()<cr>", { buffer = 0 })
      vim.keymap.set("v", "<C-e>", ":lua require('markdowny').code()<cr>", { buffer = 0 })
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    -- lazy=false,
    enabled = false,
    event = { "BufRead " .. vim.fn.expand("~") .. "/obsidian/**.md" },
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<cr>",       desc = "Open Obsidian" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>",     desc = "Search in Obsidian" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>",   desc = "Templates in Obsidian" },
      { "<leader>ob", "<cmd>ObsidianBacklink<cr>",   desc = "Backlink" },
      { "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    },
    cmd = {
      "ObsidianOpen",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      dir = "~/obsidian/", -- no need to call 'vim.fn.expand' here
      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "notes",
      daily_notes = {
        folder = "dailies",
        date_format = "%Y-%m-%d",
      },
      -- Optional, completion.
      completion = {
        -- If using nvim-cmp, otherwise set to false
        nvim_cmp = true,
        -- Trigger completion at 2 chars
        min_chars = 2,
        new_notes_location = "current_dir",
      },
      -- Optional, set to true if you don't want Obsidian to manage frontmatter.
      disable_frontmatter = true,
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      open_app_foreground = true,
      finder = "telescope.nvim",
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      -- see also: 'follow_url_func' config option above.
    end,
  },
}
