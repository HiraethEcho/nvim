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
      "nvimdev/guard.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navbuddy",
    },
    config = function()
      local servers = {
        lua_ls = {
          lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
          },
          checkThirdParty = false,
        },
        bashls = {},
        html = {},
        clangd = {},
      }
      -- require("fidget").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              settings = servers[server_name],

              on_attach = function(client, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, bufopts, { desc = "lsp rename" })
                vim.keymap.set("n", "gF", function() vim.lsp.buf.format() end, bufopts, { desc = "lsp format" })
                vim.keymap.set("n", "gA", function() vim.lsp.buf.code_action() end, bufopts, { desc = "lsp action" })
              end,
            })
          end,
        },
      })
      require("lspconfig").texlab.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          texlab = {
            build = {
              executable = 'xelatex',
              onSave = true,
              forwardSearchAfter = false,
            },
            forwardSearch = {
              executable = "sioyek",
              args = {
                "--reuse-window",
                -- "--execute-command", "toggle_synctex", -- Open Sioyek in synctex mode.
                "--inverse-search",
                [[nvim --server ]] .. vim.v.servername .. [[ --remote-send ":e %%%1<cr>:%%%2<cr>"]],
                -- [[nvr --server ]] .. vim.v.servername .. [[ --remote-silent %%%1 -c vs]],
                "--forward-search-file",
                "%f",
                "--forward-search-line",
                "%l",
                "%p",
              },
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            bibtexFormatter = "texlab",
            latexFormatter = "latexindent",
            latexindent = {
              ['local'] = nil, -- local is a reserved keyword
              modifyLineBreaks = true,
            },
            formatterLineLength = 80,
          },
        },
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "<cr><cr>", "<cmd>TexlabBuild<cr>", bufopts)
          vim.keymap.set("n", "<cr>", "<cmd>TexlabForward<cr>", bufopts)
        end,
      })
      --[[
      require("lspconfig").grammarly.setup({
        filetypes = { "markdown", "tex", "plaintex" },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          grammarly = {},
        },
        on_attach = on_attach,
      })
]]
      require("lspconfig").marksman.setup({
        filetypes = { "markdown" },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          grammarly = {},
        },
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "<cr><cr>", "<cmd>MarkdownPreview<cr>", bufopts)
        end,
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
          width = 0.25,      -- 33% width relative to the active window, min 0.1, max 0.5
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
}
