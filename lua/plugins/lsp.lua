return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPost", "BufNewFile" },
    -- lazy=false,
    cmd = "LspStart",
    keys = {
      { "<leader>ll", "<cmd>LspStart<cr>",   desc = "Start lsp" },
      { "<leader>ls", "<cmd>LspStop<cr>",    desc = "stop lsp" },
      { "<leader>li", "<cmd>LspInfo<cr>",    desc = "lsp info" },
      { "<leader>lL", "<cmd>LspRestart<cr>", desc = "Restart lsp" },
    },
    dependencies = {
      -- { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
      "rachartier/tiny-inline-diagnostic.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
      {
        "smjonas/inc-rename.nvim",
        enabled = false,
        opts = {},
      },
      -- "nvimdev/guard.nvim",
      -- "hrsh7th/cmp-nvim-lsp",
      "kevinhwang91/nvim-ufo",
      {
        "Dan7h3x/signup.nvim",
        enabled = false,
        branch = "main",
        opts = {
          number = true,
          winblend = 10,
          trigger_chars = { "(", "," },
          max_height = 10,
          max_width = 40,
          floating_window_above_cur_line = true,
          preview_parameters = true,
          dock_toggle_key = "<Leader>sd",
          toggle_key = "<C-k>",
          dock_mode = {
            enabled = true,
            position = "bottom",
            height = 3,
            padding = 1,
          },
        },
      },
    },
    config = function()
      -- An example nvim-lspconfig capabilities setting
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.foldingRange = {
        -- dynamicRegistration = false,
        lineFoldingOnly = true
      }
      capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        }
      )
      local servers = {
        -- textlsp = {},
        -- grammarly = {},
        -- mdformat = {},
        -- alex = {},
        markdown_oxide = {},
        -- ltex     = {},
        -- digestif = {},
        -- textlsp  = {},
        texlab   = {
          texlab = {
            build = {
              -- executable = 'xelatex',
              onSave = true,
              forwardSearchAfter = false,
            },
            forwardSearch = {
              executable = "sioyek",
              -- vim.fn.stdpath("data") .. "/mason/bin/texlab inverse-search -i %%1 -l %%2",
              args = {
                "--reuse-window",
                "--inverse-search",
                "texlab inverse-search -i %%1 -l %%2",
                "--forward-search-file",
                "%f",
                "--forward-search-line",
                "%l",
                "%p",
              },
              --[[ executable = "zathura",
              args = {
                "--synctex-forward",
                "%l:1:%f", "%p",
                "--synctex-editor-command",
                "texlab inverse-search -i %{input} -l %{line}",
              }, ]]
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            bibtexFormatter = "texlab",
            latexFormatter = "latexindent",
            latexindent = {
              ['local'] = nil, -- local is a reserved keyword
              modifyLineBreaks = false,
            },
            formatterLineLength = 80,
          },
        },
        marksman = {},
        -- write-good = {},
        tinymist = {
          single_file_support = true,
        },
        lua_ls   = {
          lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
          },
          checkThirdParty = false,
        },
        bashls   = {},
        -- html     = {},
        clangd   = {},
      }
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
              capabilities = capabilities,
              offset_encoding = "utf-8",
              settings = servers[server_name],
              root_dir = function(_, bufnr)
                return vim.fs.root(bufnr, { ".git", ".obsidian" }) or vim.fn.expand("%:p:h")
              end,
              on_attach = function(client, bufnr)
                require("nvim-navic").attach(client, bufnr)
                vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end,
                  -- vim.keymap.set("n", "gR", function() return ":IncRename " .. vim.fn.expand("<cword>") end,
                  { noremap = true, silent = true, buffer = bufnr, desc = "lsp rename" })
                vim.keymap.set("n", "gA", function() vim.lsp.buf.code_action() end,
                  { noremap = true, silent = true, buffer = bufnr, desc = "lsp action" })
                -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr, desc = "lsp goto definition" })
                vim.keymap.set("n", "K", vim.lsp.buf.hover,
                  { noremap = true, silent = true, buffer = bufnr, desc = "lsp hover" })
                -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, buffer = bufnr, desc = "lsp references" })
                if server_name == "tinymist" then
                  vim.keymap.set("n", "<cr><cr>", "<cmd>TypstPreviewSyncCursor<cr>",
                    { noremap = true, silent = true, buffer = bufnr, desc = "Typst Preview" })
                end
                if server_name == "texlab" then
                  vim.keymap.set("n", "<cr><cr>", "<cmd>TexlabBuild<cr>",
                    { noremap = true, silent = true, buffer = bufnr, desc = "texlab build" })
                  vim.keymap.set("n", "<cr>", "<cmd>TexlabForward<cr>",
                    { noremap = true, silent = true, buffer = bufnr, desc = "texlab forward" })
                end
              end,
            })
          end,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    -- enabled = false,
    event = "LspAttach",
    keys = {
      { "<leader>O", "<cmd>Navbuddy<cr>", desc = "Jump by symbol" },
    },
    cmd = "Navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
    },
    -- opts = { lsp = { auto_attach = true } },
    config = function()
      local navbuddy = require("nvim-navbuddy")
      local actions = require("nvim-navbuddy.actions")
      navbuddy.setup({
        window = {
          size = "80%",     -- Or table format example: { height = "40%", width = "100%"}
          position = "50%", -- Or table format example: { row = "100%", col = "0%"}
          scrolloff = nil,  -- scrolloff value within navbuddy window
          sections = {
            left = {
              size = "20%",
              border = nil, -- You can set border style for each section individually as well.
            },
            mid = {
              size = "40%",
              border = nil,
            },
            right = {
              -- No size option for right most section. It fills to
              -- remaining area.
              border = nil,
              preview = "leaf", -- Right section can show previews too.
              -- Options: "leaf", "always" or "never"
            }
          },
        },
        use_default_mappings = false,  -- If set to false, only mappings set by user are set. Else default mappings are used for keys that are not set by user
        mappings = {
          ["<esc>"] = actions.close(), -- Close and cursor to original location
          ["q"] = actions.close(),

          ["j"] = actions.next_sibling(),     -- down
          ["k"] = actions.previous_sibling(), -- up

          ["h"] = actions.parent(),           -- Move to left panel
          ["l"] = actions.children(),         -- Move to right panel
          -- ["0"] = actions.root(),           -- Move to first panel

          ["v"] = actions.visual_name(),  -- Visual selection of name
          ["V"] = actions.visual_scope(), -- Visual selection of scope

          ["y"] = actions.yank_name(),    -- Yank the name to system clipboard "+
          ["Y"] = actions.yank_scope(),   -- Yank the scope to system clipboard "+

          ["i"] = actions.insert_name(),  -- Insert at start of name
          ["I"] = actions.insert_scope(), -- Insert at start of scope

          ["a"] = actions.append_name(),  -- Insert at end of name
          ["A"] = actions.append_scope(), -- Insert at end of scope

          ["r"] = actions.rename(),       -- Rename currently focused symbol

          ["x"] = actions.delete(),       -- Delete scope

          ["f"] = actions.fold_create(),  -- Create fold of current scope
          ["F"] = actions.fold_delete(),  -- Delete fold of current scope

          ["c"] = actions.comment(),      -- Comment out current scope

          ["<enter>"] = actions.select(), -- Goto selected symbol
          ["o"] = actions.select(),

          ["J"] = actions.move_down(),      -- Move focused node down
          ["K"] = actions.move_up(),        -- Move focused node up

          ["p"] = actions.toggle_preview(), -- Show preview of current node

          ["<C-v>"] = actions.vsplit(),     -- Open selected node in a vertical split
          ["<C-s>"] = actions.hsplit(),     -- Open selected node in a horizontal split

          ["t"] = actions.telescope({       -- Fuzzy finder at current level.
            layout_config = {               -- All options that can be
              height = 0.60,                -- passed to telescope.nvim's
              width = 0.60,                 -- default can be passed here.
              prompt_position = "top",
              preview_width = 0.50
            },
            layout_strategy = "horizontal"
          }),
          ["g?"] = actions.help(),    -- Open mappings help window
        },
        lsp = { auto_attach = true }, -- If set to true, you don't need to manually use attach function },
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
      outline_window = {
        position = 'right',
        width = 20,
      },
      preview_window = {
        open_hover_on_preview = true,
        live = true,
      },
      keymaps = {
        goto_location = '<space>',
        peek_location = 'o',
        goto_and_close = '<Cr>',
        restore_location = '<C-g>',
        hover_symbol = 'K',
        toggle_preview = 'p',
        fold_all = 'zM',
        unfold_all = 'zR',
      },
    },
  },
  {
    "dnlhc/glance.nvim",
    -- lazy = false,
    event = "LspAttach",
    keys = {
      { "gd", "<cmd>Glance definitions<cr>",      desc = "Glance definitions" },
      { "gr", "<cmd>Glance references<cr>",       desc = "Glance references" },
      { "gy", "<cmd>Glance type_definitions<cr>", desc = "Glance type_definitions" },
      { "gm", "<cmd>Glance implementations<cr>",  desc = "Glance implementations" },
    },
    config = function()
      local actions = require('glance').actions
      require('glance').setup({

        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        detached = true,

        -- Or use a function to enable `detached` only when the active window is too small
        -- (default behavior)
        -- detached = function(winid)
        --   return vim.api.nvim_win_get_width(winid) < 100
        -- end,

        list = {
          position = 'left', -- Position of the list window 'left'|'right'
          width = 0.2,       -- 33% width relative to the active window, min 0.1, max 0.5
        },
        mappings = {
          list = {
            ['j'] = actions.next,     -- Bring the cursor to the next item in the list
            ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
            ['<Down>'] = actions.next,
            ['<Up>'] = actions.previous,
            ['<Tab>'] = actions.next_location,       -- Bring the cursor to the next location skipping groups in the list
            ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ['<C-u>'] = actions.preview_scroll_win(5),
            ['<C-d>'] = actions.preview_scroll_win(-5),
            ['v'] = actions.jump_vsplit,
            ['s'] = actions.jump_split,
            ['t'] = actions.jump_tab,
            ['<CR>'] = actions.jump,
            ['l'] = actions.open_fold,
            ['h'] = actions.close_fold,
            ['<space>'] = actions.enter_win('preview'), -- Focus preview window
            ['q'] = actions.close,
            ['Q'] = false,
            ['<Esc>'] = actions.close,
            ['<C-q>'] = actions.quickfix,
          },
          preview = {
            ['<Tab>'] = actions.next_location,
            ['<S-Tab>'] = actions.previous_location,
            ['q'] = actions.enter_win('list'), -- Focus list window
          },
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    -- enabled = false,
    opts = {
      modes = {
        split = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>XX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>x",
        "<cmd>Trouble diagnostics toggle filter.buf=0 focus=false<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>Xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>Xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>XL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>XQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    priority = 1000,     -- needs to be loaded in first
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      require("tiny-inline-diagnostic").setup({
        preset = "powerline", -- Can be: "modern", "classic", "minimal", "powerline", ghost", "simple", "nonerdfont", "amongus"
        options = {
          show_source = true,
          multiple_diag_under_cursor = true,
        },
      })
    end
  },
  -- disabled
  {
    "glepnir/lspsaga.nvim",
    enabled = false,
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      -- { "nvim-treesitter/nvim-treesitter" },
      "neovim/nvim-lspconfig",
    },
    keys = {
      -- { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "hover doc" },
      { "<leader>lo", "<cmd>Lspsaga outline<cr>",                    desc = "lsp outline" },
      { "<leader>la", "<cmd>Lspsaga code_action<cr>",                desc = "lsp code_action" },
      { "<leader>ld", "<cmd>Lspsaga show_buf_diagnostics<cr>",       desc = "lsp buff diagnostic" },
      { "<leader>lD", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "lsp workspace diagnostic" },
      { "<leader>lf", "<cmd>Lspsaga finder<cr>",                     desc = "lsp finder" },
      -- { "<leader>lF", ":lua vim.lsp.buf.format()<cr>",               desc = "lsp formart" },
      { "gp",         "<cmd>Lspsaga peek_definition<cr>",            desc = "lsp peek definition" },
      { "gd",         "<cmd>Lspsaga goto_definition<cr>",            desc = "go to definition" },
      { "[d",         "<cmd>Lspsaga diagnostic_jump_prev<cr>",       desc = "previous diagnostic" },
      { "]d",         "<cmd>Lspsaga diagnostic_jump_next<cr>",       desc = "next diagnostic" },
    },
    config = function()
      require("lspsaga").setup({
        scroll_preview = {
          scroll_down = "<C-u>",
          scroll_up = "<C-d>",
        },
        finder = {
          keys = {
            jump_to = "p",
            expand_or_jump = "<cr>",
            vsplit = "v",
            split = "s",
            tabe = "t",
            tabnew = "r",
            quit = { "q", "<ESC>" },
            close_in_preview = "<ESC>",
          },
        },
        outline = {
          keys = {
            expand_or_jump = "<cr>",
            quit = "q",
            jump = "<space>"
          },
        },
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = false,
          show_file = false,
          folder_level = 5,
          color_mode = true,
        },
        hover = {
          max_width = 0.6,
          open_link = "gw",
          open_browser = "qutebrowser",
        },
        diagnostic = {
          keys = {
            exec_action = "o",
            quit = "q",
            expand_or_jump = "<CR>",
            quit_in_show = { "q", "<ESC>" },
          },
        },
        ui = {
          winblend = 30,
        },
      })
      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end
      sign({ name = "DiagnosticSignError", text = "" })
      sign({ name = "DiagnosticSignWarn", text = "" })
      sign({ name = "DiagnosticSignHint", text = "" })
      sign({ name = "DiagnosticSignInfo", text = "" })
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        signs = true,
        underline = false,
      })
    end,
  },
  {
    "jinzhongjia/LspUI.nvim",
    branch = "main",
    enabled = false,
    config = function()
      require("LspUI").setup({
        -- config options go here
      })
    end
  },
}
