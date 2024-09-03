local vim = vim
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "nvim-treesitter/nvim-treesitter",
      -- "micangl/cmp-vimtex",
      { "SirVer/ultisnips", dependencies = { "quangnguyen30192/cmp-nvim-ultisnips", config = true, }, },
      -- "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      cmp.setup({
        completion = {
          completeopt = "menu,noselect,noinsert,menuone,popup",
          --[[
              menu     Use a popup menu to show the possible completions.  The menu is only shown when there is more than one match and sufficient colors are available.  |ins-completion-menu|
              menuone  Use the popup menu also when there is only one match. Useful when there is additional information about the match, e.g., what file it comes from.
              longest  Only insert the longest common text of the matches.  If the menu is displayed you can use CTRL-L to add more characters.  Whether case is ignored depends on the kind of completion.  For buffer text the 'ignorecase' option is used.
              preview  Show extra information about the currently selected completion in the preview window.  Only works in combination with "menu" or "menuone".
              noinsert Do not insert any text for a match until the user selects a match from the menu. Only works in combination with "menu" or "menuone". No effect if "longest" is present.
              noselect Do not select a match in the menu, force the user to select one from the menu. Only works in combination with "menu" or "menuone".
              popup    Show extra information about the currently selected completion in a popup window.  Only works in combination with "menu" or "menuone".  Overrides "preview".
          --]]
        },
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,

          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "ultisnips" }, -- For ultisnips users.
          -- { name = "vimtex" },
          { name = "buffer",   option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end, }, },
          { name = "path" },
          { name = "copilot" },
          -- { name = 'nvim_lua' },
        }),
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
          yaml = true,
          lua = true,
          markdown = true,
          latex = true,
          -- ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
    end,
  },
}
