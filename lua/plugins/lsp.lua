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
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- "nvimdev/guard.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- "SmiteshP/nvim-navbuddy",
    },
    config = function()
      -- An example nvim-lspconfig capabilities setting
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local servers = {
        -- textlsp = {},
        -- grammarly = {},
        -- mdformat = {},
        -- alex = {},
        -- markdown-oxide = {},
        -- ltex     = {},
        texlab   = {
          texlab = {
            build = {
              executable = 'xelatex',
              onSave = true,
              forwardSearchAfter = false,
            },
            forwardSearch = {
              --[[ executable = "sioyek",
              args = {
                "--reuse-window",
                "--inverse-search",
                vim.fn.stdpath("data") .. "/mason/bin/texlab inverse-search -i %%1 -l %%2",
                "--forward-search-file",
                "%f",
                "--forward-search-line",
                "%l",
                "%p",
              }, ]]
              executable = "zathura",
              args = {
                "--synctex-forward",
                "%l:1:%f", "%p",
                -- "--synctex-editor-command",
                -- vim.fn.stdpath("data") .. "/mason/bin/texlab inverse-search -i %{input} -l %{line}",
              },
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            bibtexFormatter = "texlab",
            latexFormatter = "latexindent",
            formatterLineLength = 80,
          },
        },
        marksman = {},
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
      require("lspconfig").texlab.setup({
        settings = servers.texlab,
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<cr><cr>", "<cmd>TexlabBuild<cr>",
            { noremap = true, silent = true, buffer = bufnr, desc = "texlab build" })
          vim.keymap.set("n", "<cr>", "<cmd>TexlabForward<cr>",
            { noremap = true, silent = true, buffer = bufnr, desc = "texlab forward" })
        end,
      })
      require("mason-lspconfig").setup({
        -- ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              settings = servers[server_name],
              on_attach = function(client, bufnr)
                require("nvim-navic").attach(client, bufnr)
                vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end,
                  { noremap = true, silent = true, buffer = bufnr, desc = "lsp rename" })
                vim.keymap.set("n", "gA", function() vim.lsp.buf.code_action() end,
                  { noremap = true, silent = true, buffer = bufnr, desc = "lsp action" })
                -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr, desc = "lsp goto definition" })
                vim.keymap.set("n", "K", vim.lsp.buf.hover,
                  { noremap = true, silent = true, buffer = bufnr, desc = "lsp hover" })
                -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, buffer = bufnr, desc = "lsp references" })
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
        width = 15,
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
        height = 18, -- Height of the window
        zindex = 45,

        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        detached = true,

        -- Or use a function to enable `detached` only when the active window is too small
        -- (default behavior)
        -- detached = function(winid)
        --   return vim.api.nvim_win_get_width(winid) < 100
        -- end,

        border = {
          enable = true, -- Show window borders. Only horizontal borders allowed
          top_char = '―',
          bottom_char = '―',
        },
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
            -- ['q'] = actions.close,
            ['<Tab>'] = actions.next_location,
            ['<S-Tab>'] = actions.previous_location,
            ['q'] = actions.enter_win('list'), -- Focus list window
          },
        },
        hooks = {},
      })
    end,
  },
  {
    'vigoux/ltex-ls.nvim',
    lazy = false,
    enabled = false,
    dependencies = 'neovim/nvim-lspconfig',
    config = function()
      require 'ltex-ls'.setup {
        -- on_attach = on_attach,
        -- capabilities = capabilities,
        use_spellfile = false,
        filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
        settings = {
          ltex = {
            enabled = { "latex", "tex", "bib", "markdown", },
            language = "auto",
            diagnosticSeverity = "information",
            sentenceCacheSize = 2000,
            additionalRules = {
              enablePickyRules = true,
              motherTongue = "en",
            },
            disabledRules = {
            },
            dictionary = (function()
              -- For dictionary, search for files in the runtime to have
              -- and include them as externals the format for them is
              -- dict/{LANG}.txt
              --
              -- Also add dict/default.txt to all of them
              local files = {}
              for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
                local lang = vim.fn.fnamemodify(file, ":t:r")
                local fullpath = vim.fs.normalize(file, ":p")
                files[lang] = { ":" .. fullpath }
              end

              if files.default then
                for lang, _ in pairs(files) do
                  if lang ~= "default" then
                    vim.list_extend(files[lang], files.default)
                  end
                end
                files.default = nil
              end
              return files
            end)(),
          },
        },
      }
    end,
  },
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
    "rmagatti/goto-preview",
    enabled = false,
    -- event = "BufEnter",
    event = "LspAttach",
    -- config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    config = function()
      require('goto-preview').setup {
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = true, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
      }
    end,
    --[[
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
]]
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
}
