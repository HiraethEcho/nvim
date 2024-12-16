return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "SirVer/ultisnips",   dependencies = { "quangnguyen30192/cmp-nvim-ultisnips", config = true, }, },
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      { "micangl/cmp-vimtex", },
      "zbirenbaum/copilot.lua",
      "hrsh7th/cmp-path",
      "onsails/lspkind-nvim",
      -- "neovim/nvim-lspconfig",
      -- "hrsh7th/cmp-nvim-lua",
      -- "nvim-treesitter/nvim-treesitter",
      -- "yehuohan/cmp-im",
      -- "yehuohan/cmp-im-zh",
      -- "liubianshi/cmp-lsp-rimels",
      {
        "folke/lazydev.nvim",
        enabled = false,
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lspkind = require('lspkind')
      local cmp = require("cmp")
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      cmp.setup({
        completion = { completeopt = "menu,popup,menuone,noselect", }, -- see :help 'completeopt'
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        mapping = {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<c-j>"] = cmp.mapping(
            function(fallback)
              cmp_ultisnips_mappings.jump_forwards(fallback)
            end,
            { "i", "s", }
          ),
          ["<c-k>"] = cmp.mapping(
            function(fallback)
              cmp_ultisnips_mappings.jump_backwards(fallback)
            end,
            { "i", "s", }
          ),
          ["<Tab>"] = cmp.mapping.select_next_item(fallback),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(fallback),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
          { name = "ultisnips" }, -- For ultisnips users.
          { name = "vimtex" },
          { name = "nvim_lua" },
          { name = 'nvim_lsp' },
          { name = "copilot" },
          { name = "buffer",   option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end, }, },
          { name = "path" },
          { name = "lazydev",  group_index = 0, },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',     -- show only symbol annotations
            maxwidth = {
              menu = 100,              -- leading text (labelDetails)
              abbr = 100,              -- actual suggestion item
            },
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            before = function(entry, vim_item)
              vim_item.menu = entry.source.name
              return vim_item
            end
          })
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    keys = { -- Example mapping to toggle outline
      { "<leader>cc", "<cmd>Copilot<CR>",        desc = "Copilot" },
      { "<leader>ct", "<cmd>Copilot toggle<CR>", desc = "Copilot toggle" },
      { "<leader>cd", "<cmd>Copilot detach<CR>", desc = "Copilot detach" },
      { "<leader>ca", "<cmd>Copilot attach<CR>", desc = "Copilot attach" },
      { "<leader>cp", "<cmd>Copilot panel<CR>",  desc = "Copilot panel" },
    },
    dependencies = {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup()
      end
    },
    config = function()
      require('copilot').setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "K",
            jump_next = "J",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
        },
        filetypes = {
          lua = true,
          markdown = true,
          latex = true,
          -- ["."] = false,
        },
      })
    end,
  },
  {
    "smjonas/snippet-converter.nvim",
    -- SnippetConverter uses semantic versioning. Example: use version = "1.*" to avoid breaking changes on version 1.
    -- Uncomment the next line to follow stable releases only.
    -- tag = "*",
    -- lazy = false,
    enabled = false,
    config = function()
      local template = {
        name = "t1", --(optionally give your template a name to refer to it in the `ConvertSnippets` command)
        sources = {
          ultisnips = {
            -- Add snippets from (plugin) folders or individual files on your runtimepath...
            -- "./vim-snippets/UltiSnips",
            -- "./latex-snippets/tex.snippets",
            -- ...or use absolute paths on your system.
            vim.fn.stdpath("config") .. "/UltiSnips_nopy",
          },
        },
        output = {
          -- Specify the output formats and paths
          vscode_luasnip = {
            vim.fn.stdpath("config") .. "/LuaSnip",
          },
        },
      }

      require("snippet_converter").setup {
        templates = { template },
        -- To change the default settings (see configuration section in the documentation)
        -- settings = {},
      }
    end
  }
}
